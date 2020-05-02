module Itslabel::TranslationMethods
  
  extend ActiveSupport::Concern

  DELIMITERS = [
                # All . (dots) not preceeded by a numeral
                /((?<![\d])\.)/,
                # Matching 'and' and 'or' and their arabic and french literals
                /(\band\b|\bet\b|\bor\b|\bou\b|\bأو\b|\bو\b)/,
                # English and French version of units
                # 10gms, 10gm, 10mgs, 10mg, 10gram, 10grams, , 10.5 gram, 10.5grams
                # 10mg, 10 mg
                /(\ ?[0-9]+\.?[0-9]*?\ ?grammes\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?gr?a?m?s?\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?mg\ ?)/,
                # Arabic version of grams and other units
                /(\ ?[0-9]+\.?[0-9]*?\ ?جرامات\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?غرام\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?ملغ\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?جم\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?غ\ ?)/,
                # Percentages 10%, 10.50%
                /(\ ?[0-9]+\.?[0-9]*?\ ?%\ ?)/,
                #/(\ ?%\ ?[0-9]*\.?[0-9]+?)/,
                # Commas and other characters
                /(،|,|;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n)/
              ]

  # DELIMITERS_TRANSLATIONS = {
  #   ".": {ENGLISH: ".", FRENCH: ".", ARABIC: ""},
  #   "،": {ENGLISH: ",", FRENCH: ",", ARABIC: "،"},
  #   ",": {ENGLISH: ",", FRENCH: ",", ARABIC: "،"},
  #   ";": {ENGLISH: ";", FRENCH: ";", ARABIC: "."},
  #   "mg": {ENGLISH: "mg", FRENCH: "mg", ARABIC: "ملغ"},
  #   "gm": {ENGLISH: "gm", FRENCH: "gm", ARABIC: "جم"},
  #   "grams": {ENGLISH: "grams", FRENCH: "grams", ARABIC: "جم"},
  #   "gram": {ENGLISH: "gram", FRENCH: "gram", ARABIC: "جم"},
  #   " and ": {ENGLISH: " and ", FRENCH: " et ", ARABIC: " و "},
  #   " or ": {ENGLISH: " or ", FRENCH: " ou ", ARABIC: " أو "},
  # }

  class_methods do

    def translate_word(word, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      return "" if word == ""

      where(input_language: options[:input_language], 
            output_language: options[:output_language]).
      where("LOWER(input_phrase) = LOWER(?)", word.strip).
      select(:output_phrase).
      first.try(:output_phrase)
    end

    def translate_words(words, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      translation_hash = {}
      words.each do |word|
        cleaned_word = word.strip.gsub("\u00A0", "")
        translated_word = translate_word(cleaned_word, options)
        if translated_word
          translation_hash[word.strip] = translated_word
        elsif word.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
          # Translating the simple Delimitters 
          translation_hash[word] = word
        else
          # Translating the complex Delimitters 
          translation_hash[word.strip] = translate_delimiter(word, options)
        end
      end
      translation_hash
    end

    def get_words(input)
      unprocessed_words = input.split(Regexp.union(Translation::DELIMITERS))
      final_words = []
      unprocessed_words.each do |w|
        if w.starts_with?(' ')
          final_words << " "
        end

        final_words << w.strip

        if w.end_with?(' ')
          final_words << " "
        end
      end

      final_words.delete_if {|w| w == ""}
      return final_words
    end

    def translate_paragraph(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC",
        return_in_hash: false
      })
      options.symbolize_keys!

      input.gsub!("&nbsp;", " ")

      words = get_words(input)
      hash = translate_words(words, options)

      hash["_tokens"] = words

      if options[:return_in_hash]
        return hash
      else
        output = input.clone
        hash.each do |key, value|
          next unless value
          next if key == "_tokens"
          output.gsub!(key, value)
        end
        return output
      end
    end

    def translate_html(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # Create nokogiri object
      html = Nokogiri::HTML.fragment(input)
      html.children.each do |node|
        if node.children.any?
          unless (node.attributes.any? && node.attributes["class"] && node.attributes["class"].value.include?("do-not-translate"))
            translate_children(node, options)
          end
        else
          options[:return_in_hash] = true
          hash = translate_paragraph(node.text, options)
          node.replace(format_translation(hash, options))
        end
      end

      html.children.reverse if options[:output_language].downcase == "arabic"
      return html
    end

    def translate_children(node, **options)
      # Iterating the node and translating
      node.children.each do |child|
        if child.children.any?
          unless (child.attributes.any? && child.attributes["class"] && child.attributes["class"].value.include?("do-not-translate"))
            translate_children(child, options)
          end
        else
          options[:return_in_hash] = true
          hash = translate_paragraph(child.text, options)
          child.replace(format_translation(hash, options))
        end
      end

      # set direction
      node['dir'] = options[:output_language].downcase == "arabic" ? 'rtl' : 'ltr'

      # Reverse children
      node.children.reverse if options[:output_language].downcase == "arabic"
    end

    def format_translation(hash, **options)
      options.reverse_merge!({
        return_string: false,
      })
      display_text = ""
      tokens = hash["_tokens"]

      tokens.each do |tk|

        # tk.strip gives "" if tk == "\n" or those characters, hence handling them separately
        # tk.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
        if tk.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
          translated_text = tk
        else
          if tk.strip.blank?
            translated_text = tk
          else
            translated_text = hash[tk.strip]
          end
          # translated_text += " "
        end

        if translated_text
          display_text += translated_text
          # display_text += translated_text + " "
        else
          dir_attr = options[:output_language].downcase == "arabic" ? 'rtl' : 'ltr'
          display_text += "<span class='its-tran-not-found' dir='#{dir_attr}' data-output-language='#{options[:output_language]}'><i class=\"icon-question mr-2\"></i>#{tk}</span>"
        end
      end

      if options[:return_string]
        return display_text
      else
        return Nokogiri::HTML::DocumentFragment.parse(display_text)
      end
    end

    def translate_delimiter(delim, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "FRENCH",
        return_in_hash: false
      })
      options.symbolize_keys!

      rtl = options[:output_language].downcase == "arabic"

      if delim.match(/،|,/)
        # Match , and arabic comma
        return rtl ? " ،" : ", "
      elsif delim.match(/(?<![\d])\./)
        # Match .
        return "."
      elsif delim.match(/\ ?\(?([0-9]+(\.[0-9]*)?(\ )?)\)?\ ?%/)
        # Match if the string is an integer or decimal but with a %
        # return rtl ? "%#{delim.gsub('%','')}".strip : delim
        return delim
      elsif delim.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
        # Match other special delimiter characers
        return delim
      else
        # Match if the string is of this format : 100.00grams, 10.0 gms, 1gm
        num = delim.scan(/-?\d*\.?\d+/).try(:first)
        # below, first scan grammes and then grams 
        weight = delim.scan(/mg/).try(:first) || 
                 delim.scan(/grammes?/).try(:first) || 
                 delim.scan(/جرامات/).try(:first) ||
                 delim.scan(/جم/).try(:first) ||
                 delim.scan(/ملغ/).try(:first) ||
                 delim.scan(/غرام/).try(:first) ||
                 delim.scan(/غ/).try(:first) ||
                 delim.scan(/gr?a?m?s?/).try(:first)
        if num && weight
          translated_weight = Translation.translate_word(weight, input_language: options[:input_language], output_language: options[:output_language]) || weight
          # Get num and weign seperately and replace the weight with translated weight
          delim_trans = delim.dup
          return delim.gsub(weight, translated_weight)
        elsif delim.match(/\ ?\(?([0-9]+(\.[0-9]*)?(\ )?)\)?\ ?/)
         # Match if the string is an integer or decimal
         return delim
        else
          return nil
        end
      end
    end

    def translate(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      case input
      when String
        translate_paragraph(input, options)
      when Array
        translate_words(input, options)
      end
    end

  end
  
end
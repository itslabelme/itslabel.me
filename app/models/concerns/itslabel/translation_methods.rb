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
                /(\ ?[0-9]+\.?[0-9]*?\ ?غ\ ?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?جم\ ?)/,
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

    def translate_paragraph(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC",
        return_in_hash: false
      })
      options.symbolize_keys!

      input.gsub!("&nbsp;", " ")

      rtl = options[:output_language] == "ARABIC"

      words = input.split(Regexp.union(Translation::DELIMITERS))
      hash = translate_words(words, options)

      # binding.pry

      if rtl
        #hash["_tokens"] = words.reverse
        hash["_tokens"] = words
      else
        hash["_tokens"] = words
      end

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

      # Extract the texts
      doc = Nokogiri::HTML(input)
      extracted_texts = doc.search('//text()').map(&:text).join(",")

      # Translate them and return as hash
      options[:return_in_hash] = true
      hash = translate_paragraph(extracted_texts, options)

      # Replace the translations in html
      output = input.clone
      hash.each do |key, value|
        next unless value
        next if key == "_tokens"
        output.gsub!(key, value)
      end
      return output
    end

    def translate_html_old(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # Extract the texts
      doc = Nokogiri::HTML(input)
      extracted_texts = doc.search('//text()').map(&:text).join(",")

      # Translate them and return as hash
      options[:return_in_hash] = true
      hash = translate_paragraph(extracted_texts, options)

      # Replace the translations in html
      output = input.clone
      hash.each do |key, value|
        next unless value
        next if key == "_tokens"
        output.gsub!(key, value)
      end
      return output
    end

    def format_output(hash, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      display_text = ""
      tokens = hash["_tokens"]

      tokens.each do |tk|

        # tk.strip gives "" if tk == "\n" or those characters
        # hence handling them separately
        if tk.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
          translated_text = hash[tk]
        else
          if tk.strip.blank?
            translated_text = tk
          else
            translated_text = hash[tk.strip]
          end
        end
        
        display_text += translated_text.to_s + " "

        # if translated_text
        #   display_text += translated_text + " "
        # else
        #   dir_attr = options[:output_language] == "ARABIC" ? 'rtl' : ''
        #   display_text += "<span class='its-tran-not-found' dir='#{dir_attr}'><i class=\"icon-question mr-2\"></i>#{tk}</span>"
        # end
      end

      display_text.gsub!(/\n+/, '<br>')
      return display_text
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

    def translate_delimiter(delim, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "FRENCH",
        return_in_hash: false
      })
      options.symbolize_keys!

      rtl = options[:output_language] == "ARABIC"

      if delim.match(/،|,/)
        # Match , and arabic comma
        return rtl ? " ،" : ", "
      elsif delim.match(/(?<![\d])\./)
        # Match .
        return "."
      elsif delim.match(/\ ?\(?([0-9]+(\.[0-9]*)?(\ )?)\)?\ ?%/)
        # Match if the string is an integer or decimal but with a %
        return rtl ? "%#{delim.gsub('%','')}".strip : delim
      elsif delim.match(/;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n/)
        # Match other special delimiter characers
        return delim
      else
        # Match if the string is of this format : 100.00grams, 10.0 gms, 1gm
        num = delim.scan(/-?\d*\.?\d+/).try(:first)
        # below, first scan grammes and then grams 
        weight = delim.scan(/mg/).try(:first) || 
                 delim.scan(/غ/).try(:first) ||
                 delim.scan(/جم/).try(:first) ||
                 delim.scan(/grammes?/).try(:first) || 
                 delim.scan(/gr?a?m?s?/).try(:first)
        
        if num && weight
          translated_weight = Translation.translate_word(weight, input_language: options[:input_language], output_language: options[:output_language]) || weight
          return rtl ? "#{translated_weight} #{num}" : "#{num} #{translated_weight}" 
        elsif delim.match(/\ ?\(?([0-9]+(\.[0-9]*)?(\ )?)\)?\ ?/)
         # Match if the string is an integer or decimal
         return delim
        else
          return nil
        end
      end
    end

  end
  
end
module Itslabel::TranslationMethods
  
  extend ActiveSupport::Concern

  DELIMITERS = [/((?<![\d])\.)/,
                # Matching 'and' and 'or' and their arabic and french literals
                /(\ ?et\ ?|\ ou\ ?|\ ?أو\ ?|\ ?و\ ?|\ and\ ?|\ or\ ?)/,
                # 10gms, 10gm, 10mgs, 10mg, 10gram, 10grams, , 10.5 gram, 10.5grams
                # /(\(?\ ?[0-9]+\.?[0-9]*?\ ?gr?a?m?s?\ ?\)?)/,
                /(\ ?[0-9]+\.?[0-9]*?\ ?gr?a?m?s?\ ?)/,
                # 10mg, 10 mg
                /(\ ?\(?([0-9]+(\.[0-9]*)?(\ )?mg)\)?\ ?)/,
                # Percentages 10%, 10.50%
                /(\d*\.?\d*%)/,
                # Commas and other characters
                /(،|,|;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n)/
              ]

  DELIMITERS_TRANSLATIONS = {
    ".": {ENGLISH: ".", FRENCH: ".", ARABIC: ""},
    "،": {ENGLISH: ",", FRENCH: ",", ARABIC: "،"},
    ",": {ENGLISH: ",", FRENCH: ",", ARABIC: "،"},
    ";": {ENGLISH: ";", FRENCH: ";", ARABIC: "."},
    "mg": {ENGLISH: "mg", FRENCH: "mg", ARABIC: "ملغ"},
    "gm": {ENGLISH: "gm", FRENCH: "gm", ARABIC: "جم"},
    "grams": {ENGLISH: "grams", FRENCH: "grams", ARABIC: "جم"},
    "gram": {ENGLISH: "gram", FRENCH: "gram", ARABIC: "جم"},
    " and ": {ENGLISH: " and ", FRENCH: " et ", ARABIC: " و "},
    " or ": {ENGLISH: " or ", FRENCH: " ou ", ARABIC: " أو "},
  }

  class_methods do

    def translate_word(word, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!
      #raise options[:input_language].inspect 
       if (options[:input_language].eql?('English') && options[:output_language].eql?('Arabic') )
        where("LOWER(english_phrase) = LOWER(?)", word.strip).
        select(:arabic_phrase).
        first.try(:arabic_phrase)
      elsif (options[:input_language].eql?('Arabic') && options[:output_language].eql?('English') )
        
        where("LOWER(arabic_phrase) = LOWER(?)", word.strip).
        select(:english_phrase).
        first.try(:english_phrase)
      elsif (options[:input_language].eql?('English') && options[:output_language].eql?('French') )
        where("LOWER(english_phrase) = LOWER(?)", word.strip).
        select(:french_phrase).
        first.try(:french_phrase)
      elsif (options[:input_language].eql?('French') && options[:output_language].eql?('English') )
        where("LOWER(french_phrase) = LOWER(?)", word.strip).
        select(:english_phrase).
        first.try(:english_phrase)
       elsif (options[:input_language].eql?('French') && options[:output_language].eql?('Arabic') )
        where("LOWER(french_phrase) = LOWER(?)", word.strip).
        select(:arabic_phrase).
        first.try(:arabic_phrase)
       elsif (options[:input_language].eql?('Arabic') && options[:output_language].eql?('French') )
        where("LOWER(arabic_phrase) = LOWER(?)", word.strip).
        select(:french_phrase).
        first.try(:frnch_phrase)
      end
      #binding.pry
    end

    def translate_words(words, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      translation_hash = {}
      words.each do |word|
        translated_word = translate_word(word.strip, options)
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

      if rtl
        hash["_tokens"] = words.reverse
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
        weight = delim.scan(/mg/).try(:first) || delim.scan(/gr?a?m?s?/).try(:first)
        if num && weight
          translated_weight = Translation.translate_word(weight, input_language: options[:input_language], output_language: options[:output_language]) || translated_weight
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
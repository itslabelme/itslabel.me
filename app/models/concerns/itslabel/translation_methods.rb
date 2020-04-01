module Itslabel::TranslationMethods
  
  extend ActiveSupport::Concern

  # DELIMITERS = ['.', ',', ';', '(', ')', '[', ']', ':', '|', '!', '-'] 
  # /(\t\r\n|\t|\r|\n)/,

  # DELIMITERS = [/\.|,|،|;|\(|\)|\[|\]|:|\||!|\-|\ and\ |\ or\ |\t|\r|\n/, 
  #               # 10gms, 10gm, 10mgs, 10mg, 10gram, 10grams
  #               /(\d*\.?\d*gms?)/, /(\d*\.?\d*mgs?)/, /(\d*\.?\d*grams?)/,
  #               # Percentages 10%, 10.50%
  #               /(\d*\.?\d*%)/
  #             ]

  DELIMITERS = [/((?<![\d])\.)/,
                # Matching 'and' and 'or' and their arabic and french literals
                /(\ ?et\ ?|\ ou\ ?|\ ?أو\ ?|\ ?و\ ?|\ and\ ?|\ or\ ?)/,
                # Commas and other characters
                /(،|,|;|\(|\)|\[|\]|:|\||!|\-|\t|\r|\n)/, 
                # 10gms, 10gm, 10mgs, 10mg, 10gram, 10grams, , 10.5 gram, 10.5grams
                /([0-9]+(\.[0-9]*)?(\ )?gr?a?m?ms?)/,
                # Percentages 10%, 10.50%
                /(\d*\.?\d*%)/
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
        translation_hash[word.strip] = translate_word(word, options)
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

      words = input.split(Regexp.union(Translation::DELIMITERS))
      hash = translate_words(words, options)
      hash.delete_if{|x, y| x.to_s.strip.blank?}

      # if output_language == "ARABIC"
      #   hash["_tokens"] = words.reverse
      # else
      #   hash["_tokens"] = words
      # end
      
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

  end
  
end
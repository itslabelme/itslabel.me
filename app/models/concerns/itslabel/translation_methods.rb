module Itslabel::TranslationMethods
  
  extend ActiveSupport::Concern

  DELIMITERS = ['.', ',', /(\t\r\n|\t|\r|\n)/, ';', '(', ')', '[', ']', ':', '|', "'", '!', ' and ', ' or ']

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
      words.delete_if{|x| x.to_s.strip.blank? ||  DELIMITERS.include?(x)}
      hash = translate_words(words, options)
      if options[:return_in_hash]
        return hash
      else
        output = input.clone
        hash.each do |key, value|
          next unless value
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
        output.gsub!(key, value)
      end
      return output
    end

  end
  
end
module Itslabel::TranslationMethods
  
  extend ActiveSupport::Concern

  # DELIMITERS_OLD = [
  #                 # All . (dots) not preceeded by a numeral
  #                 /((?<![\d])\.)/,
  #                 # Matching 'and' and 'or' and their arabic and french literals
  #                 /(\band\b|\bet\b|\bor\b|\bou\b|\bأو\b|\bو\b)/,
  #                 # English and French version of units
  #                 # 10gms, 10gm, 10mgs, 10mg, 10gram, 10grams, , 10.5 gram, 10.5grams
  #                 # 10mg, 10 mg
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?grammes\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?gr?a?m?s?\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?mg\ ?)/,
  #                 # Arabic version of grams and other units
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?جرامات\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?غرام\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?ملغ\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?جم\ ?)/,
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?غ\ ?)/,
  #                 # Percentages 10%, 10.50%
  #                 /(\ ?[0-9]+\.?[0-9]*?\ ?%\ ?)/,
  #                 # Commas and other characters
  #                 /(،|,|;|:|.|\(|\)|\[|\]|:|\||!|\t|\r|\n)/]
  # CONJUNCTIONS_OLD = ["and", "or", "with", "without", "for", "so", "of", "&"]

  DELIMITERS = [
    /(،|,|;|\(|\)|\[|\]|\{|\}|:|\||!|\t|\r|\n)/i,
    # All . (dots) not preceeded by a numeral
    /((?<![\d])\.)/,
  ]
  CONJUNCTIONS = [
    /(&)/,
    /(\band\b|\bet\b|\bو\b)/,
    /(\bor\b|\bou\b|\bxxxxx\b)/,
    /(\bof\b|\bde\b|\bأو\b)/,
    /(\bwith\b|\bavec\b|\bمع\b)/,
    /(\bwithout\b|\bsans\b|\bبدون\b)/,
    /(\bfor\b|\bpour\b)/,
    /(\bso\b|\bdonc\b)/
  ]
  UNITS = ["%", "oz", "lb", "kg", "mg", "ml", "g", "gm", "gms", "gram", "grams", "litres", "kilo", "kilos", "ug", "milligram", "ounce"]
  UNIT_REGEX = /\(?([0-9]+(.[0-9]+)?)\s?([a-zA-Z]+|%)?\)?/i

  class_methods do

    # translate method an input string and translate it
    # it can translate html and non html (large paragraphs) and also single or multiple words
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

    # translate_html accept a string input (html) and iterate them through its children 
    # and translate all its text contents to stich them back to html
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
          node.replace(format_translation(hash, **options))
        end
      end
      html.children.reverse if options[:output_language].upcase == "ARABIC"

      return html
    end

    # translate_children are recursive methods to transate nested html
    # only caled from translate_html
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
      node['dir'] = options[:output_language].upcase == "ARABIC" ? 'rtl' : 'ltr'

      # Reverse children
      node.children.reverse if options[:output_language].upcase == "ARABIC"
    end

    # translate_paragraph accept a string input and tokenize them and translate them
    def translate_paragraph(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC",
        return_in_hash: false
      })
      options.symbolize_keys!

      # hash = {}
      # words = tokenize(input, options)
      # translations = translate_words(words, options)
      # translations.map{|item| hash.merge(item)}
      # hash["_translations"] = translations
      # hash["_words"] = words
      # hash["_tokens"] = words

      words = tokenize(input, options)
      translations = translate_words(words, options)

      # Typical Point to test missing translation 
      # binding.pry

      # Preparing Output Hash and String
      output_hash = {}
      translations.each do |item|
        wd = item[0]
        trn = item[1]
        output_hash[wd] = trn
      end

      output_hash["_translations"] = translations
      output_hash["_tokens"] = words

      # We are not reversing as html rtl attribute will reverse while displaying
      # --------------------------------------------------------------------------

      # if options[:output_language].upcase == "ARABIC"
      #   output = translations.map{|x| x[1].nil? ? x[0] : x[1]}.reverse.join('')
      # else
      #   output = translations.map{|x| x[1].nil? ? x[0] : x[1]}.join('')
      # end

      output = translations.map{|x| x[1].nil? ? x[0] : x[1]}.join('')
      output_hash["_output"] = output

      if options[:return_in_hash]
        return output_hash
      else
        return output        
      end
    end

    # translate_words accept an array of words and return their translation with score
    def translate_words(words, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # Initialize Outout Array
      output = []

      # Output Array
      # [
      #   ["Word 1", "Word 1 Translation"]
      #   ["Word 2", "Word 2 Translation"] 
      #   ["Word 3", "Word 3 Translation"] 
      # ]

      words.each do |word|
        cleaned_word = word.strip.gsub("\u00A0", "")
        if (cleaned_word == "" || cleaned_word == " ")
          t_score = { word => {score: 0, translation: word} }
          t_word = word
        elsif cleaned_word.match(Regexp.union(Translation::DELIMITERS))
          t_score = { word => {score: 0, translation: word} }
          t_word = word
        else
          if cleaned_word.split(' ').size > 1 || (cleaned_word.match(UNIT_REGEX) || Translation::UNITS.include?(cleaned_word))
            t_score = translate_token(cleaned_word, options)
            t_word = stitch_token(t_score, options)
          else
            t_score = {cleaned_word => translate_word_with_score(cleaned_word, options)}
            t_word = stitch_token(t_score, options)
          end
        end
        translation = (t_score.any? && t_score.values.map{|x| x[:translation]}.compact.empty?) ? nil : t_word.to_s
        output << [word, translation]
      end
      output
    end

    # tokenize accept an input and tokenize them and return the list of words
    def tokenize(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!
      
      # Cleaning the input text
      input = sanitize(input)

      # Spliting the words based on delimitters and conjunctions
      unprocessed_words = input.split(Regexp.union(Translation::DELIMITERS))
      # unprocessed_words = input.split(Regexp.union(Translation::DELIMITERS + Translation::CONJUNCTIONS))

      # Initialize final_words array which will also have the delimitters and conjunctions
      final_words = []

      # Identifying the words which starts or ends with empty string and manually spliting the space as a token
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

    # translate_token will accept an token input and will translate it 
    # it considers conjunction and units
    # internally calls translate_word_with_score and split_method method
    def translate_token(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # Create an array like the following by spliting the input by space:
      # [
      #   {:word=>"10", :type=>"word"},
      #   {:word=>"grams", :type=>"unit"},
      #   {:word=>"of", :type=>"conjunction"},
      #   {:word=>"Sodium", :type=>"word"},
      #   {:word=>"Chloride", :type=>"word"}
      # ]

      input_words = []
      input.split(" ").each_with_index do |word, idx|
        if word.match(Regexp.union(Translation::CONJUNCTIONS))
          type = "conjunction"
        # elsif word.match(/[0-9]+/) || Translation::UNITS.include?(word)
        elsif word.match(UNIT_REGEX) || Translation::UNITS.include?(word)
          type = "unit"
        else
          type = "word"
        end
        input_words << {word: word, type: type }
      end

      reduced_words = []
      current_word = ""
      idx = 0

      while idx < input_words.length
        ip = input_words[idx]
        word = ip[:word]
        wtype = ip[:type]
        if wtype == "conjunction"
          reduced_words << {word: word, type: wtype }
          idx += 1
        elsif wtype == "unit"
          # If type == unit
          while wtype == "unit" and idx < input_words.length
            ip = input_words[idx]
            word = ip[:word]
            wtype = ip[:type]
            if wtype == "unit"
              current_word += word
            else
              break
            end
            idx += 1
          end
          reduced_words << {word: current_word, type: "unit" }
          current_word = ""
        else
          # If type == word
          while wtype == "word" and idx < input_words.length
            ip = input_words[idx]
            word = ip[:word]
            wtype = ip[:type]
            if wtype == "word"
              current_word += word
            else
              break
            end
            idx += 1
          end
          reduced_words << {word: current_word, type: "word" }
          current_word = ""
        end
      end

      # Create a scores list of all word combinations
      # including units, conjunctions
      # e.g: [
      #        {"10" => {score: nil}, "grams" => {score: 0}}, 
      #        {"of" => {score: 0}}, 
      #        {"Sodium Chloride" => {score: nil, translation: 'كلوريد الصوديوم'}}
      #      ]
      scores_hash = Translation.translate_token_words(reduced_words, options)
      return scores_hash
    end

    # This method is only called form translate_token method
    # If you have a string like '10 grams of sodium chloride'
    # translate token create 2 arrays one with all conjunctions and units
    # other with just words
    # both arrays needs to be translated
    # this method 
    def translate_token_words(words, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # Conjunctions needs to be avoided while doing ngrams of 2 to split units
      scores_hash = {}

      words.each do |val|
        word = val[:word]
        type = val[:type]

        if type == "conjunction"
          translation = translate_word_from_database(word, options)
          conjunction_scores = {word => {score: 0, translation: translation}}
          scores_hash.merge!(conjunction_scores){|key, oldval, newval| newval.nil? ? oldval : newval}
        elsif type == "unit"
          unit_scores = Translation.split_units(word, options)
          if unit_scores
            scores_hash.merge!(unit_scores){|key, oldval, newval| newval.nil? ? oldval : newval}
          else
            # FIXME - need to handle this case
          end
        else
          # Handle normal words. Calcuate score & add to scores_hash
          word_scores = {word => Translation.translate_word_with_score(word, options)}
          # Translation.translate_word_from_database(word)
          scores_hash.merge!(word_scores){|key, oldval, newval| newval.nil? ? oldval : newval}
        end
      end

      return scores_hash
    end

    def stitch_token(score, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      t_word_list = score.map{|word, val| val[:translation] ? val[:translation] : word}

      # if options[:output_language].upcase == "ARABIC"
      #   return t_word_list.reverse.join(' ')
      # else
      #   return t_word_list.join(' ')
      # end
      return t_word_list.join(' ')
    end

    # split_units will accept an input and will extract units with amount and return its score
    def split_units(input, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      # input = "0.5l of Milk with 10gm Sugar"
      # input = "0.5l of Milk"

      matches = input.scan(UNIT_REGEX)
      # e.g: [["0.5", "l"]]
      return nil if matches.empty?

      # e.g: [["0.5", "l"]].first.first => "0.5"
      amount = matches[0][0] #.try(:strip)
      return nil unless amount

      possible_unit = matches[0][2] #.try(:strip)
      return nil unless possible_unit

      # FIXME - need to populate the dict for units from database
      # Right now it is hardcoded at the top of this module
      possible_units = Translation::UNITS.map{|u| [MarkovChainTranslatorAlgo2.probability_match(possible_unit, u), u]}

      # Sorting the Score List
      sorted_possible_units = possible_units.sort_by {|x| x[0]}

      score_hash = {}
      translation = translate_word_from_database(possible_unit, options)
      unit_score = sorted_possible_units[0].first # the score of the unit word

      # if options[:input_language].upcase == "ARABIC"
      #   unit_word = [possible_unit, ' ', amount].compact.join('').strip
      # else
      #   unit_word = [amount, ' ', possible_unit].compact.join('').strip
      # end
      unit_word = [amount, ' ', possible_unit].compact.join('').strip

      # if options[:output_language].upcase == "ARABIC"
      #   unit_translation = [translation, ' ', amount].compact.join('').strip
      # else
      #   unit_translation = [amount, ' ', translation].compact.join('').strip
      # end
      unit_translation = [amount, ' ', translation].compact.join('').strip

      score_hash[unit_word] = {score: unit_score, translation: unit_translation}

      # e.g of score_hash = {"grams"=>{:score=>0, :translation=>"جرامات"}, "10"=>{:score=>0}, "Corn"=>{:score=>0, :translation=>"ذرة"}}

      return score_hash
    end

    # sanitize removes unnecessary characters and replaces them with spaces
    def sanitize(input)
      input.gsub!("&nbsp;", " ")
      return input
    end

    # translate_word_from_database will simple look in database for a translation
    # currently used only while translating units and conjunctions
    def translate_word_from_database(word, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      return "" if word == ""

      where(input_language: options[:input_language].upcase, 
            output_language: options[:output_language].upcase).
      where("LOWER(input_phrase) = LOWER(?)", word.strip).
      select(:output_phrase).
      first.try(:output_phrase)
    end

    # translate_word_with_score accept a single sentence (multiple word) and translate them
    # this is the lowest level translator method in this module
    # typically a tokenized word after spliting units and conjunction is passed to this method as word for final translation
    def translate_word_with_score(word, **options)
      options.reverse_merge!({
        input_language: "ENGLISH",
        output_language: "ARABIC"
      })
      options.symbolize_keys!

      return "" if word == ""
      return " " if word == " "

      il = options[:input_language].upcase
      ol = options[:output_language].upcase

      cap = 2
      min_size = word.strip.gsub(" ", "").size - cap
      max_size = word.strip.gsub(" ", "").size + cap

      ### improve this- get all phrases where phrases have size + or - 2 chars that of input word
      dict = Rails.cache.fetch("master-#{il}-#{ol}-#{word.size}", :expires_in => 24.hours) { 
        Translation.where(input_language: il, output_language: ol).
        where("input_length >= ? AND input_length <= ?", min_size, max_size).
        select(:id, :input_phrase, :output_phrase).all
      }

      # dict.select{|x| x.input_phrase.starts_with?("Sodium")}.pluck(:input_phrase)
      # score_list.select{|a, b, c| b.starts_with?("Sodium")}

      # Getting the Probabilty Scores with their translations from MarkovChainTranslator
      # score_list = MarkovChainTranslatorAlgo1.translate_word(word, dict)
      if word.size <= 2
        translation = dict.select{|x| x.input_phrase == word}.try(:first).try(:output_phrase) || nil
        score_list = [[0, word, translation]]
      else
        score_list = MarkovChainTranslatorAlgo2.translate_word(word, dict)
      end

      # Sorting the Score List
      sorted_score_list = score_list.sort_by {|x| x[0]}

      # sorted_score_list[0..10].each {|x| puts x[0].to_s + " "; print x[1].to_s + " "}
      # sorted_score_list[0..10].each do |x|
      #   puts x
      # end

      if sorted_score_list && sorted_score_list[0] && sorted_score_list[0][0] <= 2
        score = {
          score: sorted_score_list.try(:[], 0).try(:[], 0),
          translation: sorted_score_list.try(:[], 0).try(:[], 2)
        }
      else
        score = {score: nil, translation: nil}
      end

      return score
    end

    def format_translation(hash, **options)
      options.reverse_merge!({
        return_string: false,
      })

      # Hash will have vaules with nil if any of them have missing translation
      if hash.values.select{|x| x.nil?}.empty?
        output = hash["_output"]
      else
        output = ""
        tokens = hash["_tokens"]
        tokens.each do |tk|
          translated_text = hash[tk.strip]
          if translated_text
            output += translated_text
          else
            # tk.strip gives "" if tk == "\n" or those characters, hence handling them separately
            tk_match = tk.match(Regexp.union(Translation::DELIMITERS + Translation::CONJUNCTIONS))
            if tk_match || tk.strip.blank?
              output += tk
            else
              dir_attr = options[:output_language].upcase == "ARABIC" ? 'rtl' : 'ltr'
              output += "<span class='its-tran-not-found' dir='#{dir_attr}' data-output-language='#{options[:output_language].upcase}'><i class=\"icon-question mr-2\"></i>#{tk}</span>"
            end
          end
        end
      end

      # NOTE: the translate method actually reverses the words.
      # however, to display them in html we dont need the reversal as they would reverse it while displaying.
      # final reversal is required hence to show them properly in arabic.
      if options[:output_language].upcase == "ARABIC"
        final_words = []
        output.split(' ').each do |wd|
          final_words << wd.split(Regexp.union(Translation::DELIMITERS)).join()
        end
        display_text = final_words.join(' ')
      else
        display_text = output
      end

      if options[:return_string]
        return display_text
      else
        return Nokogiri::HTML::DocumentFragment.parse(display_text)
      end
    end

    # Depcrecated Methods
    def old_format_translation(hash, **options)
      options.reverse_merge!({
        return_string: false,
      })
      display_text = ""
      tokens = hash["_tokens"]

      tokens.each do |tk|

        translated_text = hash[tk.strip]
        if translated_text
          display_text += translated_text
        else
          # tk.strip gives "" if tk == "\n" or those characters, hence handling them separately
          tk_match = tk.match(Regexp.union(Translation::DELIMITERS + Translation::CONJUNCTIONS))
          if tk_match || tk.strip.blank?
            display_text += tk
          else
            dir_attr = options[:output_language].upcase == "ARABIC" ? 'rtl' : 'ltr'
            display_text += "<span class='its-tran-not-found' dir='#{dir_attr}' data-output-language='#{options[:output_language].upcase}'><i class=\"icon-question mr-2\"></i>#{tk}</span>"
          end
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

      rtl = options[:output_language].upcase == "ARABIC"

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
          translated_weight = Translation.translate_word(weight, input_language: options[:input_language], output_language: options[:output_language].upcase) || weight
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

  end
  
end
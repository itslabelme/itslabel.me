class MarkovChainTranslatorAlgo3

  def self.print_result(score_list)
    score_list.each do |s|
      puts s[0], s[1]
    end
  end

  def self.translate_word(word, records)
    score_list = []
    records.each do |record|
      score = probability_match(word, record.input_phrase)
      score_list << [score, record.input_phrase, record.output_phrase]
    end
    score_list
  end

  def split_units()
    # regexp = re.compile(r"([0-9]+)\s?([a-zA-Z]+)")
    # matches = regexp.match(s)
    # amount = matches.group(1)
    # possible_unit = matches.group(2)
    # possible_units = [(probability_match(possible_unit, s), s) for s in units]
    # possible_units.sort(key=lambda k: k[0])
    # return (amount, possible_units[0][1])
  end

  def self.probability_match(seq1, seq2)
    seq1 = seq1.gsub(" ","")
    seq2 = seq2.gsub(" ","")
    size_x = seq1.size + 1
    size_y = seq2.size + 1 
    matrix = Array.new(size_x){Array.new(size_y,0)}

    size_x.times do |x|
      matrix[x][0] = x
    end

    size_y.times do |y|
      matrix[0][y] = y
    end

    (1...size_x).each do |x|
      (1...size_y).each do |y|
        # printf("%d %d %s %s\n",x, y, seq1[x-1], seq2[y-1])
        if seq1[x-1] == seq2[y-1]
          matrix[x][y] = [
            matrix[x-1][y] + 1,
            matrix[x-1][y-1],
            matrix[x][y-1] + 1
          ].min
        else
          matrix[x][y] = [
            matrix[x-1][y] + 1,
            matrix[x-1][y-1] + 1,
            matrix[x][y-1] + 1
          ].min
        end
      end
    end

    return matrix[size_x - 1][size_y - 1]
  end

  # ngrams("abcde") returns ["abc", "bcd", "cde"]
  def self.ngrams(s, n=3)
    # s = ''.join([c for c in s if c.isalnum()])  # Maybe we need this?
    # ngrams = zip(*[s[i:] for i in range(n)])
    # return [''.join(ngram) for ngram in ngrams]

    s = s.scan(/[ˆ0-9a-z ]/i).join("").gsub(" ", "")
    ngram = NGram.new(size: 3, word_separator: " ", padchar: "")
    ngram.parse(s)
  end

  # Generate ngrams_matrix for the word with the records passed
  # records is the dictionary of translations
  def self.tdf_matrix(word, records)
    ngrams_matrix = []
    records.each do |record|
      if record.input_phrase.size > (word.size - 2) && record.input_phrase.size <= (word.size + 2)
        ngrams_matrix += [ngrams(record.input_phrase), record.input_phrase, record.output_phrase]
      end
    end
    ngrams_matrix
  end

  def self.translate_word(word, records)
    ngram_word = ngrams(word)
    ngrams_matrix = tdf_matrix(word, records)

    # print("Tree entries: {} {}".format(word, ngrams_matrix.size))
    # puts("word: #{word}").green
    # puts("ngrams_matrix:").green
    # ngrams_matrix.each do |x, y, z|
    #   puts "#{x}, #{y}, #{z}"
    # end
    # puts " "

    # generating scores
    scores = {}

    rand_idx_ng = []
    query_ngrams = []
    4.times { rand_idx_ng << rand(0..(word.size-1)); query_ngrams << ngram_word[rand_idx_ng] }
    
    puts "query_ngrams:".green
    puts "#{query_ngrams.join(', ')}"
    puts " "

    query_ngrams.each do |qngram|
      ngrams_matrix.each do |ngram_ip, ip, op|
        m_ngms = rand_idx_ng.select { |item| ngram_ip[item] if ngram_ip.size > item }
        score = m_ngms.select { |m_ngm| probability_match(qngram, m_ngm) }
        qualified_scores = score.select{|x| x < 2.0}
        scores[ip] = op if qualified_scores.size > 10
      end
    end

    puts("potential matches:", scores.size)
    puts "scores:"
    scores.each {|x, y| puts "#{x} => #{y}"}
    puts " "

    final_scores = []
    scores.each do |ip, op|
      final_scores << probability_match(word, ip)
    end
    
    return final_scores
  end

end
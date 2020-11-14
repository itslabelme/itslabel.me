class MarkovChainTranslatorAlgo2

  def self.print_result(score_list)
    score_list.each do |s|
      puts s[0], s[1]
    end
  end

  def self.probability_match(seq1, seq2)
    seq1 = seq1.gsub(" ","").downcase
    seq2 = seq2.gsub(" ","").downcase
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
    s = s.scan(/[ˆ0-9a-z\u0600-\u06FF ]/i).join("").gsub(" ", "")
    ngram = NGram.new(size: 3, word_separator: " ", padchar: "")
    ngram.parse(s)
  end

  # Generate ngrams_matrix for the word with the records passed
  # records is the dictionary of translations
  def self.tdf_matrix(word, records)
    ngrams_matrix = []
    records.each do |record|
      ngrams_matrix.push([ngrams(record.input_phrase), record.input_phrase, record.output_phrase])
    end
    ngrams_matrix
  end

  def self.translate_word(word, records)

    # records.select{|x| x.input_phrase.starts_with?("Sodium Chloride")}.pluck(:input_phrase)

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

    4.times do |x|
      rand_idx_ng << rand(0..(word.size-1))
    end

    rand_idx_ng.each do |x|
      query_ngrams << ngram_word[x] if x < ngram_word.size
    end

    # puts "query_ngrams:".green
    # puts "#{query_ngrams.join(', ')}"
    # puts " "

    query_ngrams.each do |qngram|
      ngrams_matrix.each do |ngm_item|
        ngram_ip = ngm_item[0]
        ip = ngm_item[1]
        op = ngm_item[2]
        m_ngms = rand_idx_ng.map { |item| ngram_ip[item] if ngram_ip.size > item }
        m_ngms.compact!
        begin
          score = m_ngms.map { |m_ngm| probability_match(qngram, m_ngm) }
        rescue
          #binding.pry
          raise
        end

        qualified_scores = score.select{|x| x < 2.0}
        scores[ip] = op if qualified_scores.size > 0
      end
    end


    # puts("potential matches:", scores.size)
    # puts "scores:"
    # scores.each {|x, y| puts "#{x} => #{y}"}
    # puts " "

    final_scores = []
    scores.each do |ip, op|
      final_scores << [probability_match(word, ip), ip, op]
    end

    return final_scores
  end

end
class MarkovChainTranslatorAlgo1

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

end
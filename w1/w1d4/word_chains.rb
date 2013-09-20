class WordChains

  def initialize
    @dictionary = []
    @current_words = []
    @visited_words = []
    @end_word = []
    @target = ""
    File.foreach("dictionary.txt") do |line|
      @dictionary << line.chomp
    end
    nil
  end

  def adjacent_words(word)
    adj_words = []
    filter_by_length(word)
    word.length.times do |index|
      pattern = word.dup
      pattern[index] = '\w'
      adj_words += @dictionary.select{|word| word =~ /#{pattern}/}
    end
    adj_words
  end

  def filter_by_length(word_to_compare)
    @dictionary.select!{|word|word.length == word_to_compare.length}
  end

  def find_chain(start_word, end_word)

    @visited_words = [start_word]
    @current_words << start_word
    @end_word = end_word
    found = false
    until found do
      new_words = []

      @current_words.each do |word|
        adj_words =  adjacent_words(word)
        new_words = new_words + (adj_words.select{|adj_word|!@visited_words.include?(adj_word)})
      end

      if(new_words.include?(@end_word))
        puts "found word chain!"
        found = true
        puts "#{@current_words.sort}"
      else
        @visited_words += new_words
        @current_words = new_words
        puts "#{@current_words[0..30]}"
      end

    end

  end
end


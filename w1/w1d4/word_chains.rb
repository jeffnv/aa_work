require 'set'
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

  def build_chain
    chain = [@end_word]
    chain_complete = false
    current_word = @end_word

    until chain_complete do
      word_is_from = @visited_words[current_word]
      chain << word_is_from
      current_word = word_is_from
      chain_complete = true if current_word == @start_word
    end

    p chain.reverse
  end

  def find_chain(start_word, end_word)
    beginning_time = Time.now

    @start_word = start_word
    @visited_words = {start_word => nil}
    @current_words << start_word
    @end_word = end_word
    found = false
    until found do
      new_words = []

      @current_words.each_with_index do |word, index|
        adj_words =  adjacent_words(word)
        adj_words_not_yet_visited = (adj_words.select{|adj_word|!@visited_words.include?(adj_word)})
        new_words = new_words + adj_words_not_yet_visited
        adj_words_not_yet_visited.each do |adj_word_nyv|
          @visited_words[adj_word_nyv] = word
        end
      end

      if(new_words.include?(@end_word))
        puts "found word chain!"

        found = true

      else
        @current_words = new_words

      end

    end
    build_chain
    end_time = Time.now
    puts "Time elapsed #{(end_time - beginning_time)*1000} milliseconds"
  end
end


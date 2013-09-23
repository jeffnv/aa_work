require 'set'
class WordChains
  def initialize
    @dictionary = Set.new
    @current_words = []
    @visited_words = Hash.new
    @searched_words = Set.new
    @start_word = ""
  end
  

  
  def find_chain(start_word, end_word, dictionary)
    @start_word = start_word
    @current_words << start_word
    @visited_words = Hash.new
    
    build_dictionary(dictionary)
    @dictionary.select!{|word|word.length == start_word.length}
    
    found = false
    until found do
      new_words = []
      @current_words.each do |current_word|
        if(@searched_words.include?(current_word))
          puts "already searched for #{current_word}****"
        else
          @searched_words << current_word
          adj_words = find_adjacent_words(current_word)
          
          new_words = adj_words.reject{|word|@current_words.include?(word)}
          new_words = new_words.reject{|word|@visited_words.has_key?(word)}
          
          new_words.each do |word|
            @visited_words[word] = current_word
            if(word == end_word)
              found = true
              puts "end word must be in the following"
              p new_words
              break
            end
          end
        end
      end
      @current_words = deep_dup(new_words)
      # p @current_words[0..10]
    end
      
    p build_chain(end_word)
  end
  
  private
  
  def deep_dup(array_to_dup)
    [].tap do |duplicated_array|

      array_to_dup.each do |item|

        if item.is_a?(Array)
          duplicated_array << deep_dup(item)
        else
          duplicated_array << item
        end
      end
    end
  end
  
  def build_chain(end_word)
    parent_word = ""
    chain = [end_word]
    child_word = end_word
    until parent_word == @start_word do
      parent_word = @visited_words[child_word]
      chain << parent_word.dup
      child_word = parent_word
    end
    chain.reverse
  end
  
  def build_dictionary(path)
    @dictionary = File.readlines(path)
    @dictionary = @dictionary.map{|word|word.chomp}
  end
  
  def find_adjacent_words(word)
    adj_words = []
    
    word.split('').each_with_index do |char, index_to_replace|
      potential_adjacent = word.dup
      ('a'..'z').each do |letter|
        potential_adjacent[index_to_replace] = letter
        
        if(@dictionary.include?(potential_adjacent))
          adj_words << potential_adjacent.dup
        end
      end
    end
    adj_words
  end
  
  
end
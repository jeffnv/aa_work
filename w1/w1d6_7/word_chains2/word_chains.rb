class WordChains
  def initialize
    @dictionary = []
  end
  
  def build_dictionary(path)
    @dictionary = File.readlines(path)
    @dictionary = @dictionary.map{|word|word.chomp}
  end
  
  def find_chain(start_word, end_word, dictionary)
    build_dictionary(dictionary)
    puts @dictionary[0..10]
  end
end
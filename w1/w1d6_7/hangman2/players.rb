class ComputerPlayer
  DICTIONARY = 'dictionary.txt'
  def initialize
    @name = "RoboHangPlayer Series: " << (0..100).to_a.sample
    @secret_word = ''
    @dictionary = nil
    @secret_word = ''
    load_dictionary
    pick_secret_word
  end
  
  def get_word_length
    @secret_word.length
  end
  
  def get_guess(board)
    letters = ('a'..'z').to_a
    letters.select!{|letter|!board.guessed_letters.include?(letter)}
    letters.sample
  end
  
  def check_guess(guess)
    [].tap do |matching_indexes|
      @secret_word.split('').each_with_index do |secret_word_char, index|
        if (secret_word_char == guess)
          matching_indexes << index 
        end
      end
    end
  end
  
  
  private
  
  def load_dictionary
    @dictionary = []
    @dictionary = File.readlines(DICTIONARY)
    @dictionary = @dictionary.map{|word|word.chomp}
    @dictionary.select!{|word|(!word.include?('-')) && word.length > 1}
  end
  
  def pick_secret_word
    @secret_word = @dictionary.sample
  end
end

class HumanPlayer
  HUMAN_NAMES = %w(Allen Jimmy Sarah Homer Euclid Frank Brian Samantha Aubrey)
  
  def initialize(name = HUMAN_NAMES.sample)
    @name = name
  end
  
  def get_word_length
    print "Enter length of word:"
    gets.chomp.to_i
  end
  
  def get_guess(board)
    print "Enter new letter: "
    letter = gets.chomp.downcase
    if(('a'..'z').include?(letter) && !board.guessed_letters.include?(letter))
      return letter
    else
      return get_guess(board)
    end
  end
  
  def check_guess(guess)
    puts "Enter matching indexes if #{guess} appears in word. Else just press return."
    matches = gets.chomp
    
    if(matches.length > 0)
      matches.split(',').map{|num|num.to_i}
    else
      []
    end
  end
  
  private
  
end
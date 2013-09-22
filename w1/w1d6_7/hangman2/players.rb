require 'set'
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
    #if they are all blanks, guess a random letter
    if(board.word.all?{|letter|letter == '_'})
      ('a'..'z').select{|letter|!board.guessed_letters.include?(letter)}.to_a.sample
    else 
      get_intelligent_guess(board)
    end  
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
  
  def get_secret_word
    @secret_word
  end
  
  private
  
  def get_intelligent_guess(board)
    #then filter to just those matching the pattern
    #then pick the most common letter, not yet guessed, from the remaining words
    sub_dict = @dictionary.select{|word|word.length == board.word.length}
    sub_dict = get_words_matching_pattern(board.word, sub_dict)
    get_most_common_letter(sub_dict, board.guessed_letters)
  end
  
  def get_words_matching_pattern(word_array_to_match, sub_dict)
    pattern = word_array_to_match.join.gsub('_', '\w')
    matching_words = sub_dict.select{|word| word =~ /#{pattern}/}
  end
  
  def get_most_common_letter(sub_dict, guessed_letters)
    letter_freq = Hash.new(0)
    sub_dict.each do |word|
      word.each_char do |char|
        letter_freq[char] +=1
      end
    end
    freq_array = letter_freq.to_a
    freq_array.sort!{|freq_pair1, freq_pair2| freq_pair2[1] <=> freq_pair1[1]}
    most_common_letters = freq_array.map{|freq_pair|freq_pair[0]}
    most_common_letters.find{|letter| !guessed_letters.include?(letter)}
  end
  
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
  
  def get_secret_word
    puts "what was your secret word?"
    gets.chomp
  end
  
  private
  
end
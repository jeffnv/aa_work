
class Player
  def initialize(options = {})
    set_up_player(options)
  end

  def set_up_player(options)
    defaults = {:mode => :hangman}
    @options = defaults.merge(options)
    set_up_secret_word
  end

  def guess_letter
    puts "You guessed a letter!"
  end

  def confirm_guess(guess)
  end

  def get_word_length

  end

  def secret_word

  end

  def set_up_secret_word

  end

end

class HumanPlayer < Player

  def initialize(options = {})
    set_up_player(options)
  end

  def guess_letter(display_word, guessed_letters)
    print "Enter guess: "
    gets.chomp

  end

  def secret_word
    puts "What was the secret word?"
    gets.chomp
  end

  def confirm_guess(guessed_letter)
    matches = {}
    if(word_contains_letter?(guessed_letter))
      puts "At which indexes does '#{guessed_letter}' appear?"
      puts "Separate using commas. i.e. (0,4,5)"
      string_of_matching_indexes = gets.chomp
      matching_indexes = string_of_matching_indexes.split(',')
      matching_indexes.map!{|index|index.to_i}
      matching_indexes.each do |index|
        matches[index] = guessed_letter
      end
    end
    #get index of the guessed letter
    #return a hash of matches {'a' => 0, 'b' => 1}
    #an empty hash is a miss
    matches
  end

  def get_word_length
    print "How long is your secret word: "
    gets.chomp.to_i
  end

  private

  def word_contains_letter?(guessed_letter)
    puts "Does the word contain #{guessed_letter}? (enter y or n)"
    response = gets.chomp[0].downcase
    if(response == 'y')
      true
    elsif(response == 'n')
      false
    else
      word_contains_letter?(guessed_letter)
    end
  end
end

class ComputerPlayer < Player

  def initialize(options = {})
    @dictionary = []

    File.open('dictionary.txt').each do |line|
      @dictionary << line.chomp
    end

    set_up_player(options)
  end

  def get_random_word
    @dictionary.sample
  end

  def set_up_secret_word
    if(@options[:mode] == :hangman)
      @secret_word = get_random_word
    end
  end

  def guess_letter(display_word, guessed_letters)
    filtered_words = @dictionary
    filtered_words = WordHelper.filter_by_length(filtered_words, display_word.length)
    puts "filtered by length"
    p filtered_words[0..10]
    filtered_words = WordHelper.filter_by_pattern(filtered_words, display_word.pattern)
    puts "filtered by pattern"
    p filtered_words[0..10]
    common_letters = WordHelper.find_most_common_letters(filtered_words)
    puts "common letters"
    p common_letters
    common_letters.each do |letter_and_frequency|
      letter = letter_and_frequency[0]
      return letter if !guessed_letters.include?(letter)
    end
  end

  def get_words_matching_length(words_to_filter, length)
    words_to_filter.select{|words| word.length == length}
  end

  def get_words_matching_pattern(words_to_filter, pattern)
    pattern
  end


  def confirm_guess(guess)
    matches = {}
    secret_word_array = @secret_word.split('')
    if(@secret_word.include?(guess))
      secret_word_array.each_with_index do |char, index|

        matches[index] = char if (guess == char)
      end
    end
    matches
  end

  def get_word_length
    @secret_word.length
  end

  def secret_word
    @secret_word
  end

end

class WordHelper
  def self.filter_by_length(words_to_filter, length)
    words_to_filter.select{|word| word.length == length}
  end

  def self.filter_by_pattern(words_to_filter, pattern)
    p pattern
    words_to_filter.select{|word| word =~ /#{pattern}/}
  end

  def self.find_most_common_letters(words)
    most_common_letters = Hash.new(0)
    words.each do |word|
      word.each_char do |char|
        most_common_letters[char] += 1
      end
    end

    common_letter_array = most_common_letters.to_a
    common_letter_array.sort {|a, b| b[1] <=> a[1]}
  end
end
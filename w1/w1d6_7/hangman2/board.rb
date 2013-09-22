class Board
  MISSES_ALLOWED = 10
  attr_reader :guessed_letters, :word
  def initialize(word_length)
    @guessed_letters = []
    @word = Array.new(word_length, '_')
    @guesses_left = MISSES_ALLOWED
  end
  
  def display
    display_word = @word.join(' ')
    display_word << "\n"
    display_word << @guessed_letters.sort.join(', ')
    display_word << "\n\n"
    display_word << "Guesses remaining: #{@guesses_left}\n"
    puts display_word
  end
  
  def won?
    !@word.include?('_')
  end
  
  def lost?
    @guesses_left == 0
  end
  
  def update_board(letter, matching_indexes)
    if(matching_indexes.empty?)
      @guesses_left -= 1
    else
      matching_indexes.each do |index|
        @word[index] = letter
      end
    end
    @guessed_letters << letter unless @guessed_letters.include?(letter)
  end
  
end
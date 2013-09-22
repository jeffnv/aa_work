class Board
  MISSES_ALLOWED = 10
  attr_reader :guessed_letters
  def initialize(word_length)
    @guessed_letters = []
    @word_to_display = Array.new(word_length, '_')
    @guesses_left = MISSES_ALLOWED
  end
  
  def display
    display_word = @word_to_display.join(' ')
    display_word << "\n"
    display_word << @guessed_letters.sort.join(', ')
    display_word << "\n\n"
    display_word << "Guesses remaining: #{@guesses_left}\n"
    puts display_word
  end
  
  def won?
    !@word_to_display.include?('_')
  end
  
  def lost?
    @guesses_left == 0
  end
  
  def update_board(letter, matching_indexes)
    matching_indexes.each do |index|
      @word_to_display[index] = letter
    end
    
    @guessed_letters << letter unless @guessed_letters.include?(letter)
  end
  
end
class Game
  def initialize
    @board = Board.new
    @computer = Codemaker.new
  end

  def play_game
    until @board.game_over? do
      play_turn
    end
  end

  def get_valid_guess
    input_guess = ""

    until Code.valid_code?(input_guess) do
      print "Enter valid guess: "
      input_guess = gets.chomp.upcase!
    end

    input_guess
  end

  def play_turn
    guess = get_valid_guess
    # pass guess to computer to get keycode
    # pass guess & keycode to board



    # prompt user for guess
    # checks validity
    # checks correctness
  end
end

class Board
  def initialize
    #do anything
  end

  # board checks for all asterisks or full board
end

class  CodeMaker
  def initialize
    @code
  end

  def check_guess(guess)
    code_copy = @code.dup
    keycode = ""

    code_copy.each_with_index do |code_char, i|
      guess_char = guess[i]

      if guess_char == code_char
        keycode << "*"
        code_copy[i] = guess[i] = nil
      end

    end

    code_copy.compact!
    guess.compact!

    guess.each_with_index do |guess_char, i|
      if code_copy.include?(guess_char)
        keycode << "."
        code_copy[i] = guess[i] = nil
      end
    end
    keycode
  end
end



class Code
  VALID_PEGS = %w(R G B Y O P)
  def initialize(input_code = nil)
    @pegs = input_code || get_random_code

  end

  def get_random_code
    rand_code = []
    4.times do
      rand_code << VALID_PEGS.sample
    end
  end

  def self.valid_code?(guess)
    return false if guess.length != 4
    guess.each do |peg|
      return false unless VALID_PEGS.include?(peg)
    end
    true
  end

end
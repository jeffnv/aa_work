class Game
  def initialize
    @board = Board.new
    @player = Codebreaker.new
    @computer = Codemaker.new
  end

  def play_game
    until @board.game_over? do
      play_turn
    end
  end

  def play_turn
    guess = @player.get_guess

    # pass guess to computer to get keycode
    # pass guess & keycode to board



    # prompt user for guess
    # checks validity
    # checks correctness
  end
end

class Board
  def initialize
  end

    # board checks for all asterisks or full board
end

class  CodeMaker
  def initialize
    @code = Code.new
  end

  def check_guess(guess)

    # returns keycode
  end
end

class CodeBreaker
  def initialize
  end

  def get_guess
    puts "Enter guess:"
    g

  end
end

class KeyCode
end

class Code

end
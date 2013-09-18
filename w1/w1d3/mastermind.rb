class Game
  def initialize
    @board = Board.new
    @computer = CodeMaker.new
  end

  def play_game
    until @board.game_over? do
      play_turn
    end
  end

  def get_valid_guess
    input_guess = []

    until @computer.valid_code?(input_guess) do
      print "Enter valid guess: "
      input_guess = gets.chomp.upcase!.split("")
    end

    input_guess
  end

  def play_turn
    @board.display
    guess = get_valid_guess
    keycode = @computer.check_guess(guess)
    @board.add_row(guess, keycode)
  end
end

class Board
  def initialize
    @game_rows = []
  end

  def add_row(guess, keycode)
    @game_rows << [guess, keycode]
  end

  def game_over?
    return false if @game_rows.empty?
    if @game_rows.size == 10
      puts "YOU LOSE"
      return true
    else
      if @game_rows.last[1] == "****"
        puts "YOU DIDN'T LOSE"
        return true
      end
    end
    false
  end

  def display
    @game_rows.each do |row|
      puts "#{row[0].inspect} #{row[1].inspect}"
    end
  end
end

class CodeMaker
  VALID_PEGS = %w(R G B Y O P)

  def initialize
    @code = get_random_code
  end

  def check_guess(guess)
    code_copy = @code.dup
    guess_copy = guess.dup
    keycode = ""

    code_copy.each_with_index do |code_char, i|
      guess_copy_char = guess_copy[i]

      if guess_copy_char == code_char
        keycode << "*"
        code_copy[i] = guess_copy[i] = nil
      end

    end

    code_copy.compact!
    guess_copy.compact!

    guess_copy.each_with_index do |guess_copy_char, i|
      if code_copy.include?(guess_copy_char)
        keycode << "."
        guess_copy[i] = nil
        code_copy[code_copy.index(guess_copy_char)] = nil
      end
    end
    keycode
  end


  def get_random_code
    rand_code = []
    4.times do
      rand_code << VALID_PEGS.sample
    end
    rand_code
  end

  def valid_code?(guess)
    return false if guess.length != 4
    guess.each do |peg|
      return false unless VALID_PEGS.include?(peg)
    end
    true
  end

end
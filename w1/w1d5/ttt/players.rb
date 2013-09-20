
class Player
  attr_reader :name, :mark

  def initialize
  end

  def choose(board)
    [-1, -1]
  end
end


class HumanPlayer < Player
  def initialize(name, mark)
    @name = name
    @mark = mark
  end

  def choose(board)
    choice = []
    puts "Please enter row."
    choice << gets.chomp.to_i
    puts "Please enter column."
    choice << gets.chomp.to_i
    choice
  end

end

class ComputerPlayer < Player

  def initialize(name="Computer Player", mark)
    @name = name
    @mark = mark
  end

  def choose(board)
    board.available_moves.sample
  end
end

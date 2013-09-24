require './board.rb'
class Chess

  def play

    #while
    # => display board
    #
    #end while

  end
end

class Piece
  attr_reader :color, :location
  def initialize(location, color, board)
    @location = location
    @color = color
    @board = board
  end
  #color

  def move(coords)
    #=> throws exception if coords is not in valid_moves?
    #check if moves are valid
    #eliminates enemy piece if exist in location
    #reassigns location variable of piece itself
  end

  def valid_moves
    moves = get_moves
  end




  private
  #move filters
  def on_board?(location) # [row,col]
    return location.all?{|coord| coord.between?(0,7)}
  end

  def hits_friendly?(location)
    #return true this location contains a piece of same color
    false
  end

  def hits_enemy?(location)
    #return true this location contains a piece of opposite color
    false
  end
end

module SlidingPiece
  def get_moves
    moves = []

    MOVE_DIRS.each do |dir|
      temp_location = @location.dup
      slide_stopper_encountered = false

      while on_board?(temp_location) do
        temp_location = [temp_location[0] + dir[0], temp_location[1] + dir[1]]

        break if hits_friendly?

        moves << temp_location

        break if hits_enemy?
      end
    end
    moves
  end


end

module SteppingPiece
  def get_moves
    moves = []
    MOVE_OFFSETS.each do |row,col|
      new_move = [row + @location[0], col + @location[1]]
      next if  hits_friendly?(new_move) || !on_board?
      moves << new_move
    end
    moves
  end

end

class Pawn < Piece
  BLACK_MOVES = [[2,0],[1,0],[1,1],[1,-1]]
  WHITE_MOVES = [[-2,0],[-1,0],[-1,-1],[-1,1]]

  def initialize(location, color, board)
    super(location, color, board)
    @has_moved = false
  end

  def get_moves
    moves = []
    offsets = @color == :black ? BLACK_MOVES :  WHITE_MOVES

    offsets.each do |row,col|
      new_move = [row + @location[0], col + @location[1]]
      next if  hits_friendly?(new_move) || !on_board?
      moves << new_move
    end

    if @has_moved
      #only the first move of a pawn can be two squares!
      moves.reject!{|coords|coords[0].abs > 1}
    end

    diags = moves.select{|coords| coords[1] != 0}
    invalid_diags = []

    diags.each do |coords|
      #invalid if empty, also invalid if containing friendly piece,
      #but this has already been filtered in line 98
      invalid_diags << coords if @board.piece_at(coords).nil?
    end

    invalid_diags.each do |invalid_diag|
      moves.delete(invalid_diag)
    end

    moves
  end


  def move(location)
    super(location)
    @has_moved = true
  end

  def mark
    if @color == :white
      "\u2659"
    else
      "\u265F"
    end
  end

end

class Rook < Piece
  include SlidingPiece
  MOVE_DIRS = [[-1,0],[0,-1],[1,0],[0,1]]

  def mark
    if @color == :white
      "\u2656"
    else
      "\u265C"
    end
  end

end

class Knight < Piece
  include SteppingPiece
  MOVE_OFFSETS = [[-2, -1], [-1, -2], [-2, 1], [1, -2],
  [2, -1], [-1, 2], [2, 1], [1, 2]]
  def mark
    if @color == :white
      "\u2658"
    else
      "\u265E"
    end
  end

end

class Bishop < Piece
  include SlidingPiece
  MOVE_DIRS = [[-1,-1],[-1,1],[1,1],[1,-1],]

  def mark
    if @color == :white
      "\u2657"
    else
      "\u265D"
    end
  end

end

class Queen < Piece
  include SlidingPiece
  MOVE_DIRS = [[-1,-1],[-1,1],[1,1],[1,-1],[-1,0],[0,-1],[1,0],[0,1]]
  def mark
    if @color == :white
      "\u2655"
    else
      "\u265B"
    end
  end

end

class King < Piece
  include SteppingPiece
  MOVE_OFFSETS = [[-1,-1],[-1,1],[1,1],[1,-1],[-1,0],[0,-1],[1,0],[0,1]]
  def mark
    if @color == :white
      "\u2654"
    else
      "\u265A"
    end
  end
end

if __FILE__ == $PROGRAM_NAME
  chessboard = Board.new
  chessboard.display

end
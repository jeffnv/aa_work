class Chess

end

class Board
  def initialize
    #build the board Array(8) { Array(8) {" "}}

  end

  #hits piece


end

class Piece
  attr_reader :marker, :color, :location
  def initialize(location, board, color)
    @location = location
    @board = board
    @color = color
  end
  #color

  #def move(coords)
  # => throws exception if coords is not in valid_moves?
  #end


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
  def generate_slides
    moves = []

    MOVE_DIRS.each do |dir|
      temp_location = @location.dup
      slide_stopper_encountered = false
      while on_board?(temp_location) do
        temp_location = [temp_location[0] + dir[0], temp_location[1] + dir[1]]

        break if @board.hits_friendly?

        moves << temp_location

        break if @board.hits_enemy?
      end
    end
    moves
  end


end

module SteppingPiece
  def generate_steps

  end

end

class Pawn < Piece
  MOVE_OFFSETS = []

end

class Rook < Piece
  include SlidingPiece
  MOVE_DIRS = [[-1,0],[0,-1],[1,0],[0,1]]

  def valid_moves
    moves = generate_slides
    moves = moves.reject{|move| @board.causes_self_check(@location, move)}
    #filter moves beyond friendly piece

    #filter moves that are BEYOND enemy square
    #filter moves that would place piece in check
  end

end

class Knight < Piece
include SteppingPiece
  MOVE_OFFSETS = []
end

class Bishop < Piece
include SlidingPiece
  MOVE_DIRS = [[-1,-1],[-1,1],[1,1],[1,-1]]

  #call generate_slides again. Maybe have Piece class call this


end

class Queen < Piece
include SlidingPiece
  MOVE_DIRS = []
end

class King < Piece
include SteppingPiece
  MOVE_OFFSETS = []
end
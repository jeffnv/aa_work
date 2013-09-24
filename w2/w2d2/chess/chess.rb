class Chess

end

class Board
  PIECE_STARTING_LOCATIONS =
  def initialize
    generate_board
  end

  def generate_board
    @board = Array.new(8) do
      Array.new(8) do
        nil
      end
    end

    init_color(:black)
    init_color(:white)
    @board
  end

  def init_color(color)

    if(color == :black)
      royal_row_idx = 0
      pawn_row_idx = 1
    else
      royal_row_idx = 7
      pawn_row_idx = 6
    end

    8.times do |col_index|
      location = [royal_row_idx, col_index]
      case col_index
      when 0, 7
        @board[royal_row_idx][col_index] = Rook.new(location, color, self)
      when 1, 6
        @board[royal_row_idx][col_index] = Knight.new(location, color, self)
      when 2, 5
        @board[royal_row_idx][col_index] = Bishop.new(location, color, self)
      when 3
        @board[royal_row_idx][col_index] = King.new(location, color, self)
      when 4
        @board[royal_row_idx][col_index] = Queen.new(location, color, self)
      end

      @board[pawn_row_idx][col_index] = Pawn.new(location, color, self)
    end
  end

  def display
    display_string = ""
    @board.each_index do |row_idx|

      @board[row_idx].each do |chess_piece|
        if chess_piece
          display_string << chess_piece.mark + " "
        else
          display_string << '  '
        end
      end
      display_string << "\n"
    end
    puts display_string
  end

  def piece_at(location)
    @board[location[0]][location[1]]
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

  #def move(coords)
  # => throws exception if coords is not in valid_moves?
  #end
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
  MOVE_OFFSETS = []

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
  MOVE_OFFSETS = [[-2, -1], [-1, -2], [-2, 1], [1, -2], [2, -1], [-1, 2], [2, 1], [1, 2]]
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
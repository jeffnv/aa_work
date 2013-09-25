class Piece

  attr_reader :color
  def initialize(color)
    @color = color
  end

  def my_location(board)
    board.loc_of_piece(self)
  end

  def valid_moves(board)
    moves = get_moves(board)
  end

  private
  def on_board?(location)
    return location.all?{|coord| coord.between?(0,7)}
  end

  def hits_friendly?(board, location)
    target_piece = board.piece_at(location)
    if(target_piece)
      target_piece.color == @color
    else
      false
    end
  end

  def hits_enemy?(board, location)
      target_piece = board.piece_at(location)
      if(target_piece)
        target_piece.color != @color
      else
        false
      end
  end
end

module SlidingPiece
  def get_moves(board)
    moves = []

    get_move_dirs.each do |dir|
      temp_location = my_location(board).dup
      slide_stopper_encountered = false

      while on_board?(temp_location) do
        temp_location = [temp_location[0] + dir[0], temp_location[1] + dir[1]]

        break if !on_board?(temp_location) || hits_friendly?(board, temp_location)

        moves << temp_location

        break if hits_enemy?(board, temp_location)
      end
    end
    moves
  end


end

module SteppingPiece
  def get_moves(board)
    moves = []
    get_move_dirs.each do |row,col|
      new_move = [row + my_location(board)[0], col + my_location(board)[1]]
      next if  !on_board?(new_move) || hits_friendly?(board, new_move)
      moves << new_move
    end
    moves
  end

end

class Pawn < Piece
  BLACK_MOVES = [[2,0],[1,0],[1,1],[1,-1]]
  WHITE_MOVES = [[-2,0],[-1,0],[-1,-1],[-1,1]]


  def has_moved?(board)
    if @color == :black
      my_location(board)[0] != 1
    else
      my_location(board)[0] != 6
    end
  end

  def get_moves(board)
    moves = []
    offsets = @color == :black ? BLACK_MOVES :  WHITE_MOVES


    offsets.each do |row,col|
      new_move = [row + my_location(board)[0], col + my_location(board)[1]]
      next if  hits_friendly?(board, new_move) || !on_board?(new_move)
      moves << new_move
    end

    if has_moved?(board)
      #only the first move of a pawn can be two squares!
      my_row = my_location(board)[0]
      moves.reject!{|coords|(my_row - coords[0]).abs > 1}
    end

    diags = moves.select{|coords| coords[1] != my_location(board)[1]}
    invalid_diags = []

    diags.each do |coords|
      invalid_diags << coords if board.piece_at(coords).nil?
    end

    verticals = moves.select{|coords| coords[1] == my_location(board)[1]}
    invalid_verts = []

    verticals.each do |coords|
      invalid_verts << coords unless board.piece_at(coords).nil?
    end

    (invalid_diags + invalid_verts).each do |invalid_move|
      moves.delete(invalid_move)
    end

    moves
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

  def get_move_dirs
    [[-1,0],[0,-1],[1,0],[0,1]]
  end

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

  def get_move_dirs
    [[-2, -1], [-1, -2], [-2, 1], [1, -2],
    [2, -1], [-1, 2], [2, 1], [1, 2]]
  end

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
  def get_move_dirs
    [[-1,-1],[-1,1],[1,1],[1,-1]]
  end

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

  def get_move_dirs
    [[-1,-1],[-1,1],[1,1],[1,-1],[-1,0],[0,-1],[1,0],[0,1]]
  end

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

  def get_move_dirs
    [[-1,-1],[-1,1],[1,1],[1,-1],[-1,0],[0,-1],[1,0],[0,1]]
  end
  def mark
    if @color == :white
      "\u2654"
    else
      "\u265A"
    end
  end
end
require './board.rb'
require 'yaml'
class Chess

  def play

    #while
    # => display board
    # => ask for current player input
    # => Board evaluates enemy piece collision
    # => Board evaluates check
    # => break if game_over, Board declares checkmate
    #end while

  end
end

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
  #move filters
  def on_board?(location) # [row,col]
    return location.all?{|coord| coord.between?(0,7)}
  end

  def hits_friendly?(board, location)
    target_piece = board.piece_at(location)
    if(target_piece)
      board.piece_at(location).color == @color
    else
      false
    end
  end

  def hits_enemy?(board, location)
      target_piece = board.piece_at(location)
      if(target_piece)
        board.piece_at(location).color != @color
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

        break if !on_board?(temp_location)
        break if hits_friendly?(board, temp_location)

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
      next if  hits_friendly?(board, new_move) || !on_board?(new_move)
      moves << new_move
    end
    moves
  end

end

class Pawn < Piece
  BLACK_MOVES = [[2,0],[1,0],[1,1],[1,-1]]
  WHITE_MOVES = [[-2,0],[-1,0],[-1,-1],[-1,1]]

  def initialize(color)
    super(color)
    @has_moved = false
  end

  def get_moves(board)
    moves = []
    offsets = @color == :black ? BLACK_MOVES :  WHITE_MOVES


    offsets.each do |row,col|
      new_move = [row + my_location(board)[0], col + my_location(board)[1]]
      next if  hits_friendly?(board, new_move) || !on_board?(new_move)
      moves << new_move
    end

    puts "Possible moves after filtering hits_friendly? & !on_board?: #{moves.inspect}"

    if @has_moved
      #only the first move of a pawn can be two squares!
      moves.reject!{|coords|coords[0].abs > 1}
    end

    puts "Possible moves after checking has_moved: #{moves.inspect}"

    diags = moves.select{|coords| coords[1] != my_location(board)[1]}
    invalid_diags = []

    diags.each do |coords|
      #invalid if empty, also invalid if containing friendly piece,
      #but this has already been filtered in line 98
      invalid_diags << coords if board.piece_at(coords).nil?
    end

    invalid_diags.each do |invalid_diag|
      moves.delete(invalid_diag)
    end

    puts "Possible moves after filtering out diagonal moves (w/o enemies):"
    p moves

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

if __FILE__ == $PROGRAM_NAME
  # f2, f3
  # e7, e5
  # g2, g4
  # d8, h4
  chessboard = Board.new
  chessboard.display

  chessboard.move([6,5],[5,5])
  chessboard.display
  puts "\n\n"

  chessboard.move([1,4],[3,4])
  chessboard.display
  puts "\n\n"

  chessboard.move([6,6],[4,6])
  chessboard.display
  puts "\n\n"

  chessboard.move([0,3],[4,7])
  chessboard.display
  puts "\n\n"

  puts "CHECK!" if chessboard.in_check?(:white)

  # chessboard = Board.new
  # chessboard.display
  # puts "\n\n"
  # chessboard.move([1,0],[2,0])
  # chessboard.display
  # puts "\n\n"
  # chessboard.move([0,1],[2,2])
  # chessboard.display
  # puts "\n\n"
  # chessboard.move([6,0],[5,0])
  # chessboard.display
  # puts "\n\n"
  # chessboard.move([1,3],[2,3])
  # chessboard.display
  # puts "\n\n"
  # chessboard.move([0,2],[5,7])
  # chessboard.display
end
require './pieces'
require 'colorize'
class Board
  def initialize
    @board = build_game_board
  end
  
  def build_game_board
    @board = Array.new(8){Array.new(8)}
    add_color_pieces(:white)
    add_color_pieces(:black)
    #create and place the pieces on the squares
  end
  
  def display
    display_string = ""
    color = [:white, :black]
    string_builder = Proc.new do |row_idx, col_idx, piece|
      if dark_square?(row_idx, col_idx)
        if(piece)
          #there is something on this square
          display_string << piece.mark.on_blue
        else
          display_string << "  ".on_blue
        end
      else
        #draw magenta
        display_string << "  ".on_magenta
      end
      display_string << "\n" if col_idx == 7
    end
    do_for_every_square(&string_builder)
    puts display_string
  end
  

  def dark_square?(row_idx, col_idx)
    (row_idx.even? && col_idx.odd?)||(row_idx.odd? && col_idx.even?)
  end
  
  def move(start_loc, end_loc)
    @board[start_loc[0]][start_loc[1]].get_valid_moves(self)
    #find piece at location
    #throw errors if invalid, not your piece, off board,etc
    #move piece
    #note: jumps are forced if available
  end
  
  def get_loc(piece_to_find)
    location = nil
    piece_finder = Proc.new do |row_idx, col_idx, piece|
      if piece.object_id == piece_to_find.object_id
        location = [row_idx, col_idx]
      end
    end
    do_for_every_square(&piece_finder)
    location
  end
  
  def get_piece(location)
    @board[location[0]][location[1]]
  end
  
  def move_raw(start_loc, end_loc)
    piece_to_move = get_piece(start_loc)
    @board[start_loc[0]][start_loc[1]] = nil
    @board[end_loc[0]][end_loc[1]] = piece_to_move
  end
  private
  
  def do_for_every_square(&prc)
    @board.each_with_index do |row, row_index|
      row.each_with_index do |square, col_index|
        prc.call(row_index, col_index, square)
      end
    end
  end
  
  def add_color_pieces(color)
    rows_of_pieces = color == :white ? (0..2) : (5..7)
    
    piece_setter = Proc.new do |row_idx, col_idx, square|
      if(dark_square?(row_idx, col_idx) && rows_of_pieces.include?(row_idx))
        @board[row_idx][col_idx] = Piece.new(color)
      end
      
    end
    
    do_for_every_square &piece_setter
  end
  
end
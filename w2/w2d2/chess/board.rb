require 'yaml'
class Board
  def initialize(custom_board = nil)
    @board = nil
    unless custom_board
      generate_board
    else
      @board = custom_board
    end
  end

  def generate_board
    @board = Array.new(8) do
      Array.new(8) do
        nil
      end
    end

    init_color(:black)
    init_color(:white)
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
        @board[royal_row_idx][col_index] = Rook.new(color)
      when 1, 6
        @board[royal_row_idx][col_index] = Knight.new(color)
      when 2, 5
        @board[royal_row_idx][col_index] = Bishop.new(color)
      when 3
        @board[royal_row_idx][col_index] = Queen.new(color)
      when 4
        @board[royal_row_idx][col_index] = King.new(color)
      end

      @board[pawn_row_idx][col_index] = Pawn.new(color)
    end
  end

  def display
    display_string = ""
    @board.each_index do |row_idx|

      @board[row_idx].each do |chess_piece|
        if chess_piece
          display_string << chess_piece.mark + " "
        else
          display_string << "\u2218 "
        end
      end
      display_string << "\n"
    end
    puts display_string
  end

  def piece_at(location)
    @board[location[0]][location[1]]
  end

  def loc_of_piece(piece_to_locate)
    @board.each_index do |row_index|
      @board[row_index].each_index do |col_index|
        return [row_index, col_index] if piece_to_locate == @board[row_index][col_index]
      end
    end
    nil
  end

  def move(start_loc, end_loc)
    piece_to_move = piece_at(start_loc)

    raise "No piece to move at start location!" unless piece_to_move

    #raise exception if not your piece

    moves = piece_to_move.valid_moves(self)
    puts "I am #{piece_to_move.color} #{piece_to_move.class} directed to move from #{start_loc} to #{end_loc}"
    puts "Valid moves are: #{moves.inspect}"

    #check for check...
    moves.reject! do |destination|
      move_causes_check?(start_loc, destination, piece_to_move.color)
    end

    if (moves.include?(end_loc))
      move_raw(start_loc, end_loc)
    else
      raise "Move is invalid"
    end
  end

  def move_raw(start_loc, end_loc)
    piece = @board[start_loc[0]][start_loc[1]]

    @board[start_loc[0]][start_loc[1]] = nil

    @board[end_loc[0]][end_loc[1]] = piece
  end

  def move_causes_check?(start_loc, end_loc, color)
      test_board = self.dup

      test_board.move_raw(start_loc, end_loc)
      #puts "****************************COPIED BOARD"
      #test_board.display
      # puts "#{[start_loc, end_loc]} causes check!" if result
      #puts "****************************END COPIED BOARD"
      result = test_board.color_in_check?(color)
      #puts "Test board results in check? #{result}\n\n\n"
      if result
      #  puts "****************************COPIED BOARD"
      #  test_board.display
        puts "#{[start_loc, end_loc]} causes check!" if result
       # puts "****************************END COPIED BOARD"
      end

      result
  end

  def dup
    Board.new(dup_board_array)
  end

  def dup_board_array
    new_board = []

      @board.each do |row|
        new_row = []

        row.each do |tile_element|
          if tile_element.is_a? Piece
            new_row << (tile_element.class).new(tile_element.color)
          else
            new_row << tile_element
          end
        end
        new_board << new_row
      end
      new_board
  end

  def color_in_check?(color)
    all_opponent_pieces = @board.flatten.compact.select { |piece| piece.color != color }
    all_opponent_pieces.each do |opponent_piece|
      opponent_piece.valid_moves(self).each do |opponent_valid_move|
        if piece_at(opponent_valid_move).is_a?(King)
          puts "King is within sight!\n\n"
          return true
        end
      end
    end
    false
  end

  def checkmate?

  end

end

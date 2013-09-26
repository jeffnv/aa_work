
class Board
  attr_accessor :cursor
  def initialize(custom_board = nil)
    @cursor  = [0,0]
    unless custom_board
      generate_board
    else
      @board = custom_board
    end
  end

  def bg_color(row_i, tile_i)
    if row_i.even? && tile_i.even?
      :light_white
    elsif row_i.even? && tile_i.odd?
      :white
    elsif row_i.odd? && tile_i.even?
      :white
    elsif row_i.odd? && tile_i.odd?
      :light_white
    end
  end

  def display
    display_string = "\n  " << (0..7).to_a.join(' ') << "\n"
    @board.each_index do |row_idx|
      display_string << "#{row_idx} "
      @board[row_idx].each_with_index do |chess_piece, col_idx|
        square_to_print = ""
        if([row_idx, col_idx] == @cursor)
          square_to_print << "\u261d ".colorize({:color => :green, :background => bg_color(row_idx, col_idx)})
        else
          square_to_print = ""

          if chess_piece
            square_to_print << chess_piece.mark + " "
          else
            square_to_print << "  "
          end
        end
        display_string << square_to_print.colorize({:background => bg_color(row_idx, col_idx)})

      end
      display_string << "\n"
    end
    puts display_string << "\n"
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
  #
  # def cursor_loc=(coords)
  #   @cursor = coords
  # end
  # def cursor_loc
  #   @cursor
  # end


  def move(start_loc, end_loc, color)

    [start_loc, end_loc].each do |location_pair|
      raise OutsideBoundsError.new unless location_pair.all? { |coord| coord.between?(0,7)}
    end

    piece_to_move = piece_at(start_loc)

    raise NoPieceSelectedError.new unless piece_to_move
    raise NotYourPieceError.new if piece_to_move.color != color

    moves = piece_to_move.valid_moves(self)
    cause_check_moves = moves.select do |destination|
      move_causes_check?(start_loc, destination, piece_to_move.color)
    end

    raise MoveIntoCheckError.new if cause_check_moves.include?(end_loc)

    moves = moves - cause_check_moves

    puts "I am #{piece_to_move.color} #{piece_to_move.class} ordered to move from #{start_loc} to #{end_loc}"
    puts "My valid moves are: #{moves.inspect}"

    if (moves.include?(end_loc))
      move_raw(start_loc, end_loc)
    else
      raise IllegalMove.new
    end
  end

  def move_raw(start_loc, end_loc)
    piece = @board[start_loc[0]][start_loc[1]]

    @board[start_loc[0]][start_loc[1]] = nil

    @board[end_loc[0]][end_loc[1]] = piece
  end

  def dup
    Board.new(dup_board_array)
  end

  def checkmate?(color)
    checkmate = true
    friendly_pieces = @board.flatten.compact.select { |piece| piece.color == color }
    friendly_pieces.each do |friendly|
      lmc = get_legal_moves(friendly).count
      return false if lmc > 0

    end
    true
  end

  def color_in_check?(color)
    all_opponent_pieces = @board.flatten.compact.select { |piece| piece.color != color }
    all_opponent_pieces.each do |opponent_piece|
      opponent_piece.valid_moves(self).each do |opponent_valid_move|
        if piece_at(opponent_valid_move).is_a?(King)
          return true
        end
      end
    end
    false
  end

  private

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

        show_board_for_animation
        @board[pawn_row_idx][col_index] = Pawn.new(color)
        show_board_for_animation
      end
    end

    def show_board_for_animation
      puts "Setting up chess board..."
      display
      sleep(0.06)
      system("clear")
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

    def move_causes_check?(start_loc, end_loc, color)
        test_board = self.dup
        test_board.move_raw(start_loc, end_loc)
        test_board.color_in_check?(color)
    end

    def get_legal_moves(piece)
      cause_check_moves = []

      start = loc_of_piece(piece)
      moves = piece.valid_moves(self)
      moves.reject do |destination|
        cause_check_moves << destination if move_causes_check?(start, destination, piece.color)
        move_causes_check?(start, destination, piece.color)
      end
    end

end

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

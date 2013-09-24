class Board
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
        @board[royal_row_idx][col_index] = King.new(color)
      when 4
        @board[royal_row_idx][col_index] = Queen.new(color)
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
    puts "I am #{piece_to_move.class} directed to move from #{start_loc} to #{end_loc}"
    p moves
    if (moves.include?(end_loc))
      @board[start_loc[0]][start_loc[1]] = nil
      @board[end_loc[0]][end_loc[1]] = piece_to_move
    end
    #ask piece if end_loc is valid
    #if valid, move piece
    #raise invalid move excption





  end

end

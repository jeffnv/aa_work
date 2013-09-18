class Board
  attr_reader :game_rows
  def initialize
    @game_rows = [[:b, :b, :b],[:b, :b, :b],[:b, :b, :b]]
  end


  def mark(coord, mark)
    @game_rows[coord[0]][coord[1]] = mark
  end

  def space_blank?(coord)
    @game_rows[coord[0]][coord[1]] == :b
  end

  def display
    @game_rows.each do |row|
      p row
    end
  end

  def cats_game?
    #if there are NO more available spaces to play
    @game_rows.flatten.none?{|el|el == :b}
  end

  def gameover?(choice, mark)
    row = choice[0]
    col = choice[1]

    return true if horizontal_victory?(row, mark)
    return true if vertical_victory?(col, mark)
    return true if diagonal_victory?(mark)
    false
  end

  def horizontal_victory?(row, current_mark)
    # Horizontal victory!
    @game_rows[row].all? {|el| el == current_mark }
  end

  def vertical_victory?(col, current_mark)
    column = []
    @game_rows.each do |row|
      column << row[col]
    end

    column.all? { |el| el == current_mark }
  end

  def available_moves
    open_coords = []
    (0..2).each do |row|
      (0..2).each do |col|
        open_coords << [row, col] if space_blank?([row,col])
      end
    end
    open_coords
  end

  def diagonal_victory?(current_mark)
    # Using the helper function check_diagonal,
    # diagonal_victory evaluates whether a player
    # has completely filled a diagonal with his mark.
    diagonal1_coords = [[0,0], [1,1], [2,2]]
    diagonal2_coords = [[0,2], [1,1], [2,0]]

    diag1 = check_diagonal(diagonal1_coords, current_mark)
    diag2 = check_diagonal(diagonal2_coords, current_mark)

    diag1 || diag2
  end

  def check_diagonal(diagonal_coords, current_mark)
    # Examines element values at given coordinates
    # returns true if all elements are equal to
    # current player's mark
    diagonal_elements = []

      diagonal_coords.each do |coord|
        diagonal_elements << @game_rows[coord[0]][coord[1]]
      end
    diagonal_elements.all? { |el| el == current_mark }
  end
end
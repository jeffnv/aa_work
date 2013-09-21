class HumanPlayer
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def move(game, mark)
    game.show
    while true
      puts "#{@name}: please select your space"
      x, y = gets.chomp.split(",").map(&:to_i)
      if HumanPlayer.valid_coord?(x, y)
        return [x, y]
      else
        puts "Invalid coordinate!"
      end
    end
  end

  private
  def self.valid_coord?(x, y)
    [x, y].all? { |coord| (0..2).include?(coord) }
  end
end

class ComputerPlayer
  attr_reader :name
  def initialize
    @name = "Tandy 400"
    @move_tree = nil
  end

  def move(game, mark)
    @move_tree = nil
    grow_move_tree(game.board.rows, mark)

    winner_move(game, mark) || random_move(game, mark)

  end

  def get_available_moves(board)
    open_spaces = []
    board.each_with_index do |row, row_index|
      row.each_with_index  do |space, col_index|
        if space.nil?
          open_spaces << [row_index, col_index]
        end
      end
    end
    open_spaces
  end

  def grow_move_tree(current_grid, mark)
    current_node = TreeNode.new({current_grid: current_grid, turn: mark})
    open_moves = get_available_moves(current_grid)
    open_moves.each do |open_move|
      test_grid = current_grid.dup
      test_grid[open_move[0]][open_move[1]] = mark

      p test_grid[0]
      p test_grid[1]
      p test_grid[2]
      puts "\n-------------------------------------"
      test_grid[open_move[0]][open_move[1]] = nil
    end
  end

  private
  def winner_move(game, mark)
    (0..2).each do |x|
      (0..2).each do |y|
        board = game.board.dup
        pos = [x, y]

        next unless board.empty?(pos)
        board[pos] = mark

        return pos if board.winner == mark
      end
    end

    # no winning move
    nil
  end

  def random_move(game, mark)
    board = game.board
    while true
      range = (0..2).to_a
      pos = [range.sample, range.sample]

      return pos if board.empty?(pos)
    end
  end
end
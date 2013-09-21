class Board
  attr_reader :rows

  def self.blank_grid
    (0...3).map { [nil] * 3 }
  end

  def initialize(rows = self.class.blank_grid)
    @rows = rows
  end

  def dup
    duped_rows = rows.map(&:dup)
    self.class.new(duped_rows)
  end

  def empty?(pos)
    self[pos].nil?
  end

  def []=(pos, mark)
    raise "mark already placed there!" unless empty?(pos)

    x, y = pos[0], pos[1]
    @rows[x][y] = mark
  end

  def [](pos)
    x, y = pos[0], pos[1]
    @rows[x][y]
  end

  def cols
    cols = [[], [], []]
    @rows.each do |row|
      row.each_with_index do |mark, col|
        cols[col] << mark
      end
    end

    cols
  end

  def diagonals
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diag|
      # Note the `x, y` inside the block; this unpacks, or
      # "destructures" the argument. Read more here:
      # http://tony.pitluga.com/2011/08/08/destructuring-with-ruby.html
      diag.map { |x, y| @rows[x][y] }
    end
  end

  def over?
    # style guide says to use `or`, but I (and many others) prefer to
    # use `||` all the time. We don't like two ways to do something
    # this simple.
    won? || tied?
  end

  def won?
    !winner.nil?
  end

  def tied?
    return false if won?

    # no empty space?
    @rows.all? { |row| row.none? { |el| el.nil? }}
  end

  def winner
    (rows + cols + diagonals).each do |triple|
      return :x if triple == [:x, :x, :x]
      return :o if triple == [:o, :o, :o]
    end

    nil
  end
end

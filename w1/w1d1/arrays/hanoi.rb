class Hanoi
  def initialize(size = 5)
    @size = size
    @stacks = [(1..size).to_a.reverse, [], []]
  end

  def update
    @stacks.each do |stack|
      p stack
    end
  end

  def get_input
    puts "Enter stack from which to take disk"
    @from = gets.chomp
    puts "Enter stack to put disk"
    @to = gets.chomp
  end

  def check_move(disc, to_stack)
    result = true

    return false if disc.nil?

    last_item = @stacks[to_stack].last

    if (!last_item.nil?)
      result = false if last_item < disc
    end

    return result
  end

  def process_move
    from_stack = @from.to_i
    to_stack = @to.to_i
    disc = @stacks[from_stack].last
    if self.check_move(disc, to_stack)
      @stacks[to_stack] << disc
      @stacks[from_stack].pop
    else
      puts "Illegal move"
    end
  end

  def won?
    @stacks[2].size == @size
  end

  def start
    @from = 'a'
    @to = 'a'
    while @from.downcase != 'q' do
      self.update
      self.get_input
      self.process_move
      if self.won?
        puts "Congratulations, you won!!"
        break
      end
    end
  end
end
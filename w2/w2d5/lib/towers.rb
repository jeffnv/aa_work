class Towers
  attr_accessor :state
  def initialize
    @state = [[4,3,2,1],[],[]]
  end

  def move(start_pile, end_pile)

    circle = @state[start_pile].last
    raise "Empty Stack" if circle.nil?

    if @state[end_pile].empty?
      @state[end_pile] << @state[start_pile].pop
    else
      raise "Size Error" if @state[end_pile].last < circle
      @state[end_pile] << circle
    end

  end

  def won?
    @state[1] == [4,3,2,1] || @state[2] == [4,3,2,1]
  end


end



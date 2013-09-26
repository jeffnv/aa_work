class Piece
  attr_accessor :color
  def initialize(color)
    @color = color
  end
  
  def mark
    @color == :white ? "\u263a ".white : "\u263b ".cyan
  end
  
  def offsets
    #get location
    #add offsets
    #remove invalid moves
    #if next to a piece, jump
    #if that results in another jump, must take it
    #white on top, row increases
    offsets = [[1, -1], [1, 1]]
    if @color == :black
      offsets.map{|offset|[offset[0] * -1, offset[1]]}
    else
      offsets
    end
  end
  
  def get_valid_moves(board)
    #rules: 
      #1.if a jump is available(enemy with opening behind), must take jump
      #2.can move into an unoccupied square
      
      loc = board.get_loc(self)
      puts "I am a #{@color} piece at #{loc.inspect}!"
      
      jumps = forced_jumps(board, loc)
      puts "I am forced to make jumps at #{jumps.inspect}"
      #check adjacent squares, contain enemy?
      #if not, then can choose
  end
  
  def forced_jumps(board, my_loc)
    offs = offsets
    p offs
    neighbor_squares = offsets.map do |offset| 
      [my_loc[0] + offset[0], my_loc[1] + offset[1]]
    end
    #get_locations of squares containing enemies
    enemies = neighbor_squares.select do |neighbor_square| 
      piece = board.get_piece(neighbor_square)      
      if piece
        piece.color != @color
      else #empty
      end
    end
    
    enemies.select do |enemy_loc|
      enemy_dir = [enemy_loc[0] - my_loc[0], enemy_loc[1] - my_loc[1]]
      loc_beyond_enemy = add_offset(enemy_loc, enemy_dir)
      on_board?(loc_beyond_enemy) && board.get_piece(loc_beyond_enemy).nil?
    end
  end
  
  private
  
  def on_board?(location)
    location.all?{|coord|coord.between?(0, 7)}
  end
  
  def add_offset(start, offset, multiplier = 1)
    multiplier.times do
      start[0] += offset[0]
      start[1] += offset[1]
    end
    start
  end

end



class King < Piece
  def offsets
    super + super.map{|offset|[offset[0] * -1, offset[1]]}
  end
  
  def mark
    @color == :white ? "\u2654 ".white : "\u265a ".cyan
  end
end
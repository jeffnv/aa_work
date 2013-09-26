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
  
  def get_valid_slides(board)
    loc = board.get_loc(self)
      
    puts "I am a #{@color} piece at #{loc.inspect}!"
      
    return [] unless jumps = board.has_forced_jumps?(@color)
      
    moves = offsets.map{|offset|add_offset(loc, offset)}
    moves.select do |move|
      on_board = on_board?(move)
      empty = board.get_piece(move).nil?
      on_board && empty
    end
  end
  
  def get_valid_jumps(board)
    offs = offsets
    my_loc = board.get_loc(self)
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
    
    #valid jumps require a safe landing on the other side!
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
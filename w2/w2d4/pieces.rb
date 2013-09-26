class Piece
  
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
    offsets.map{|offset|[offset[0] * -1, offset[1]]} if color == :black
    

    
  end
  
  def get_valid_moves(board)
    #rules: 
      #1.if a jump is available, must take jump
      #2.can move into an unoccupied square
      
      loc = board.get_loc(self)
      puts "I am a #{@color} piece at #{loc.inspect}!"
      
      #check adjacent squares, contain enemy?
      #if not, then can choose
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
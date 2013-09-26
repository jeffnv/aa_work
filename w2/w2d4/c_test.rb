require './board'

b = Board.new
b.display

b.move_raw([5, 0], [3, 2])
b.display
b.move([2, 1], [3, 0])
b.display
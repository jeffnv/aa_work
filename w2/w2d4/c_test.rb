require './board'

b = Board.new
b.display

b.move_raw([5, 0], [3, 2])
b.move_raw([5,2], [4,3])
b.move_raw([5,6], [3,6])
b.display
#b.slide([2, 1], [3, 0])
b.jump([2,3], [4,1])
b.display
#b.slide([2, 1], [3, 0])

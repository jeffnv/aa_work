load 'tic_tac_toe.rb'


#game = TicTacToe.new(ComputerPlayer.new, ComputerPlayer.new)
game = TicTacToe.new(ComputerPlayer.new, HumanPlayer.new("Einstein"))
game.run
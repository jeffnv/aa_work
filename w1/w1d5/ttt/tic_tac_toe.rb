load './board.rb'
load './players.rb'
class TicTacToe

  def initialize
    @board = Board.new
    @players = []
    @turn = 0
  end

  def current_player
    @players[@turn]
  end

  def update_game(coord)

    row = coord[0]
    col = coord[1]
    if(@board.space_blank?(coord))
      @board.mark(coord, current_player.mark)
    else
      puts "Invalid location"
      # Ask for a new choice
      update_game(current_player.choose(@game_rows))
    end
  end

  def create_players
    if(@humans == 0)
      @players << ComputerPlayer.new('Computer 1', :x)
      @players << ComputerPlayer.new('Computer 2', :o)
    elsif (@humans == 1)
      @players << HumanPlayer.new('player1', :x)
      @players << ComputerPlayer.new('Computer 2', :o)
    else
      @players << HumanPlayer.new('player1', :x)
      @players << HumanPlayer.new('player2', :o)
    end
  end

  def play
    puts "How many humans?"

    @humans = gets.chomp.to_i

    create_players

    while true do
      @board.display
      puts "\nCurrent player: #{current_player.name}"
      choice = current_player.choose(@board)
      update_game(choice)
      if(@board.cats_game?)
        puts "Cat's game! :("
        break
      elsif(@board.gameover?(choice, current_player.mark))
        puts "#{current_player.name} wins!!!"
        break
      end
      @turn = (@turn + 1) % 2
    end
  end

end


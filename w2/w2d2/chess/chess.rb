require './board.rb'
require './pieces.rb'
require './chess_errors.rb'

class Chess

  def initialize
    @board = Board.new
    @player_colors = [:black, :white]

  end

  def play
    current_color = @player_colors.first
    error_message = ""
    until @board.checkmate?(current_color)

      system("clear")

      puts error_message unless error_message.empty?
      @board.display
      player_input = get_input
      error_message = play_move(player_input)

      if error_message.empty?
        @player_colors.rotate!
        current_color = @player_colors.first
      end
    end
  end

  def play_move(player_input)
    begin
      start_loc, end_loc = player_input
      @board.move(start_loc, end_loc, @player_colors.first)
      return ""
    rescue MoveIntoCheckError => e
      return "Move would leave YOUR KING IN CHECK!"
    rescue NotYourPieceError => e
      return "That is NOT your piece!"
    rescue OutsideBoundsError => e
      return "Move off bounds of board!"
    rescue NoPieceSelectedError => e
      return "No piece selected!"
    rescue IllegalMove => e
      return "That is an illegal move!"
    end
  end


  def get_input
    begin
      puts "#{@player_colors.first} player, enter location of what you want to move (row,col)"
      source_loc = gets.chomp.scan(/-?\d/).map(&:to_i)

      puts "#{@player_colors.first} player, enter destination location (row,col)"
      dest_loc = gets.chomp.scan(/-?\d/).map(&:to_i)
      [source_loc, dest_loc]
    rescue
      puts "Wrong input. Learn to type."
      retry
    end
  end
end



if __FILE__ == $PROGRAM_NAME
  game = Chess.new
  game.play
end
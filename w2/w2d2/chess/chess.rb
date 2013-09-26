require './board.rb'
require './pieces.rb'
require './chess_errors.rb'
require 'colorize'

class Chess

  def initialize
    @board = Board.new
    @player_colors = [:black, :white]
    @error_message = ""
    @input_status = ""
  end

  def update_display
    system("clear")
    puts @error_message.colorize(:red) unless @error_message.empty?
    @board.display
    puts @input_status unless @input_status.empty?

  end

  def play
    current_color = @player_colors.first
    error_message = ""
    until @board.checkmate?(current_color)
      update_display

      player_input = get_input

      @error_message = play_move(player_input)

      if @error_message.empty?
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
      # puts "Move would leave YOUR KING IN CHECK!"
      # sleep(2)
      return "Move would leave YOUR KING IN CHECK!"
    rescue NotYourPieceError => e
      # puts "That is NOT your piece!"
      # sleep(2)
      return "That is NOT your piece!"
    rescue OutsideBoundsError => e
      # puts "Move off bounds of board!"
      # sleep(2)
      return "Move off bounds of board!"
    rescue NoPieceSelectedError => e
      # puts "No piece selected!"
      # sleep(2)
      return "No piece selected!"
    rescue IllegalMove => e
      # puts "That is an illegal move!"
      # sleep(2)
      return "That is an illegal move!"
    end
  end

  def get_char
    # Thanks to http://stackoverflow.com/questions/8142901/ruby-stdin-getc-does-not-read-char-on-reception
    begin
      system("stty raw -echo")
      str = STDIN.getc
    ensure
      system("stty -raw echo")
    end
    str.chr
  end

  def get_location_from_cursor
    system('clear')
    while true
      update_display
      input = get_char
      cursor_row = @board.cursor[0]
      cursor_col = @board.cursor[1]
      case input
      when 'a'
        cursor_col -= 1 unless cursor_col <= 0
      when 's'
        cursor_row += 1 unless cursor_row >= 7
      when 'd'
        cursor_col += 1 unless cursor_col >= 7
      when 'w'
        cursor_row -= 1 unless cursor_row <= 0
      when 'k'
        exit
      when ' '
        return @board.cursor
      end

      @board.cursor = [cursor_row, cursor_col]
      system('clear')
    end
  end

  def get_input
    begin
      @input_status = "#{@player_colors.first}: select a piece"
      source_loc = get_location_from_cursor
      @input_status = "#{@board.piece_at(source_loc).mark} at #{source_loc.inspect} selected\n#{@player_colors.first}: select destination"
      dest_loc = get_location_from_cursor
      @input_status = ""
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
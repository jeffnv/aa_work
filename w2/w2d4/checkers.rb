require './pieces'
require './checker_errors'
require './board'
require 'colorize'
class Checkers
  def initialize
    @board = Board.new
    @quit = false
    @turn = [:black, :white]
    @error_msg = ""
  end

  
  def game_over?
    false
  end
  
  def play
    until game_over? || @quit do
      update_display
      get_char
      sequence = get_sequence_from_cursor
  
      @turn.rotate! if play_turn(sequence)
    end
  end
  
  private
  
  def play_turn(sequence)
    begin
      @board.sequence_valid?(sequence, @turn.first)
      @board.play_sequence(sequence, @turn.first)
      @error_msg = ""
    rescue InvalidSlideError => e
      @error_msg =  "Invalid slide!"
      return false
    rescue PendingJumpsError => e
      @error_msg =  "Must take jump!"
      return false
    rescue OffBoardError => e
      @error_msg =  "Move off board!"
      return false
    rescue InvalidJumpError => e
      @error_msg =  "Invalid jump"
      return false
    rescue InvalidSequenceError
      @error_msg = "Invalid sequence"
      return false
    end
  end
  def update_display
    system("clear")
    #instructions = "to play, move cursor around screen. Use spacebar to select"
    #instructions << " a piece to move. Select a destination and press space"
    #puts instructions
    puts @error_msg.red unless @error_msg.empty?
    
    @board.display
  end
  
  def get_sequence_from_cursor
    #system('clear')
    sequence = []
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
        sequence << @board.cursor
      when "\r"
        return sequence
        
      else 'entered'
      end

      @board.cursor = [cursor_row, cursor_col]
      #system('clear')
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
  
end


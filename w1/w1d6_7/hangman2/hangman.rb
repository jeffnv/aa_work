load 'board.rb'
load 'players.rb'
class Hangman 
  def initialize
    @guesser = nil
    @hangman = nil
    @board = nil
  end
  
  def game_over?
    
    won = @board.won?
    lost = @board.lost?
    if won
      puts "#{@hangman.get_secret_word} guessed correctly!"
    elsif lost
      puts "Word was not guessed correctly! Word was #{@hangman.get_secret_word}"
    end 
    
    won || lost
  end
  

  
  
  def set_up_players
    print "How many human players? Enter 0 - 2:"
    humans = gets.chomp.to_i
    if humans == 0
      @hangman = ComputerPlayer.new
      @guesser = ComputerPlayer.new
    elsif humans == 1
      print "Guesser or Hangman. Enter 'g' or 'h':"
      if(gets.chomp == 'g')
        @hangman = ComputerPlayer.new
        @guesser = HumanPlayer.new
      else
        @hangman = HumanPlayer.new
        @guesser = ComputerPlayer.new
      end
    elsif humans == 2
      @hangman = HumanPlayer.new
      @guesser = HumanPlayer.new
    end
  end
  
  def set_up_game
    word_length = @hangman.get_word_length
    @board = Board.new(word_length)
  end
  
  def play_turn
    @board.display
    guess = @guesser.get_guess(@board)
    matches = @hangman.check_guess(guess)
    @board.update_board(guess, matches)
  end
  
  def play
    set_up_players
    set_up_game
    
    #play game
    until game_over? do
      play_turn
    end
  end
  
  
end
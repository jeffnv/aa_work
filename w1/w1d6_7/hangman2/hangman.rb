class Hangman 
  def initialize
    @guesser = nil
    @hangman = nil
    @board = nil
  end
  
  def game_over?
    puts "good game"
    true
    
  end
  
  def play_turn
    
  end
  
  def play
    #set up play mode
    #get word length from hangman
    #set up board
    #play game
    until game_over? do
      play_turn
    end
  end
  
  
end
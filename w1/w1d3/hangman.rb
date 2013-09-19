load 'player.rb'
class Hangman
  GUESSES_ALLOWED = 10
  def initialize
    @guessed_letters = []
    @guesser=nil
    @hangman=nil
    @display_word = nil
    @guesses_remaining = GUESSES_ALLOWED
  end

  def play
    set_up_game_mode
    set_up_display(@hangman.get_word_length)
    system('clear')
    until game_over? do
      update_display
      puts "already guessed: #{@guessed_letters.inspect}"
      guess = @guesser.guess_letter(@display_word, @guessed_letters)
      matches = @hangman.confirm_guess(guess)
      if(matches.empty?)
        #there was no match, decrement remaining turns
        @guesses_remaining -= 1
      else
        @display_word.update_with_correct_guess(matches)
        #should we move the public secret word to the game class?
        #if so we could do this:
        #@secret.update_with_guess(matches)
        #also we could remove the @hangman.display
        #and do like
      end
      @guessed_letters << guess unless @guessed_letters.include? guess
      @guessed_letters.sort!
    end
  end



  private

  def set_up_display(length)
    @display_word = DisplayWord.new(length)
  end

  def update_display
    @display_word.display
    puts "Guesses remaining: #{@guesses_remaining}"
  end

  def game_over?
    over = false
    if (@guesses_remaining.zero?)
      puts "YOU LOST, IT WAS #{@hangman.secret_word}"
      over = true
    elsif @display_word.complete?
      puts "YOU DIDN'T LOSE"
      over = true
    end

    over
  end

  def set_up_players(play_mode)

    if(play_mode == 'g')
      @guesser = HumanPlayer.new({:mode => :guesser})
      @hangman = ComputerPlayer.new({:mode => :hangman})
    elsif(play_mode == 'h')
      @guesser = ComputerPlayer.new({:mode => :guesser})
      @hangman = HumanPlayer.new({:mode => :hangman})
    else
      get_game_mode
    end
  end

  def set_up_game_mode
    puts "How many human players (0, 1, 2)?"
    num_humans = gets.chomp.to_i

    case num_humans
    when 0
      @guesser = ComputerPlayer.new({:mode => :guesser})
      @hangman = ComputerPlayer.new({:mode => :hangman})
    when 1
      puts "Would you like to be the guesser or hangman? (enter g or h)"
      play_mode = (gets.chomp[0])
      set_up_players(play_mode.downcase)
    when 2
      @guesser = HumanPlayer.new({:mode => :guesser})
      @hangman = HumanPlayer.new({:mode => :hangman})
    end
  end

end

class DisplayWord
  def initialize(length)
    @word = Array.new(length, '_')
  end

  def display
    p @word
  end

  def update_with_correct_guess(update_hash)
    update_hash.each do |index, letter|
      @word[index] = letter
    end
  end

  def complete?
    @word.none?{|char|char == '_'}
  end

  def length
    @word.length
  end

  def pattern
    @word.map do |letter|
      letter == '_' ? '\w' : letter
    end.join('')
  end
end

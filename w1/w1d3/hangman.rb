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
      guess = @guesser.guess_letter
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
      @guesser = HumanPlayer.new({:guesser => :human})
      @hangman = ComputerPlayer.new({:guesser => :human})
    elsif(play_mode == 'h')
      @guesser = ComputerPlayer.new({:guesser => :machine})
      @hangman = HumanPlayer.new({:guesser => :machine})
    else
      get_game_mode
    end
  end

  def set_up_game_mode
    puts "Would you like to be the guesser or hangman? (enter g or h)"
    play_mode = (gets.chomp[0])
    set_up_players(play_mode.downcase)
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
    p update_hash
    update_hash.each do |index, letter|
      @word[index] = letter
    end
  end

  def complete?
    @word.none?{|char|char == '_'}
  end
end

class Player
  def initialize(options = {})
    set_up_player(options)
  end

  def set_up_player(options)
    defaults = {:guesser => :human}
    @options = defaults.merge(options)
    set_up_secret_word
  end

  def guess_letter
  end

  def confirm_guess(guess)
  end

  def get_word_length

  end

  def secret_word

  end

end

class HumanPlayer < Player

  def initialize(options = {})
    set_up_player(options)
  end

  def set_up_secret_word
    if(@options[:guesser] == :machine)
      print "How long is your secret word: "
      gets.chomp.to_i
    end
  end

  def guess_letter
    print "Enter guess: "
    gets.chomp
  end

  def confirm_guess
    #get index of the guessed letter
    #return a hash of mathes {'a' => 0, 'b' => 1}
    #an empty hash is a miss
  end

  def get_word_length
    print "How long is your secret word: "
    gets.chomp.to_i
  end


end

class ComputerPlayer < Player

  def initialize(options = {})
    set_up_player(options)
  end

  def get_random_word
    words = File.readlines("dictionary.txt")
    words.sample.chomp
  end

  def set_up_secret_word
    if(@options[:guesser] == :human)
      @secret_word = get_random_word
    end
  end

  def guess_letter
    (a..z).to_a.sample
  end

  def confirm_guess(guess)
    matches = {}
    secret_word_array = @secret_word.split('')
    if(@secret_word.include?(guess))
      secret_word_array.each_with_index do |char, index|

        matches[index] = char if (guess == char)
      end
    end
    matches
  end

  def get_word_length
    @secret_word.length
  end

  def secret_word
    @secret_word
  end

end
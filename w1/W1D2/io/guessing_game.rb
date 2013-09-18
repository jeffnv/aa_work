class GuessingGame

  FEEDBACK_MESSAGES = {
    :too_high => "Your guess was too high",
    :too_low => "Your geuss was too low",
    :win => "You win!!!!!!!!111"
  }

  def initialize
    @target = (1..100).to_a.sample
    @guess = -1
  end

  def start
    until won?
      get_player_choice
      if won?
        puts FEEDBACK_MESSAGES[:win]
      else
        puts (too_high? ? FEEDBACK_MESSAGES[:too_high] : FEEDBACK_MESSAGES[:too_low])
      end
    end
  end

  def get_player_choice
    puts "Please enter your guess."
    @guess = gets.chomp.to_i
  end

  def won?
    @guess == @target
  end

  def too_high?
    @guess > @target
  end

end
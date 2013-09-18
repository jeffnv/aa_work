def rps(player_move)
  choices = [ 'rock', 'paper', 'scissors']

  if choices.include?(player_move.downcase)
    computer_move = choices.sample
    puts "Computer move was #{computer_move}"
    puts determine_winner(player_move.downcase, computer_move)
  end

end

def determine_winner(player_move, computer_move)
  outcomes = [ 'Player wins', 'Player loses', 'Draw']

  if player_move == computer_move
    return outcomes[2]
  end

  if player_move == 'rock'
    computer_move == 'scissors' ? outcomes[0] : outcomes[1]
  elsif player_move == 'scissors'
    computer_move == 'paper' ? outcomes[0] : outcomes[1]
  else # player = paper
    computer_move == 'rock' ? outcomes[0] : outcomes[1]
  end
end
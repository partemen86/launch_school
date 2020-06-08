VALID_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'l' => 'lizard', 'sp' => 'spock' }
WINNING_COMBOS = { 'rock'     => ['lizard', 'scissors'],
                   'paper'    => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'spock'    => ['rock', 'scissors'],
                   'lizard'   => ['spock', 'paper'] }

def prompt(msg)
  puts "=> #{msg}"
end

def win?(first_player_choice, second_player_choice)
  WINNING_COMBOS[first_player_choice].include?(second_player_choice)
end

def determine_winner(player, computer)
  if win?(player, computer)
    "You won!"
  elsif win?(computer, player)
    "Computer won!"
  else
    "Its a tie!"
  end
end

loop do
  prompt("Welcome to Rock Paper Scissors! First to 5 wins is the winner!")
  game_scores = { player: 0, computer: 0 }

  loop do
    choice_short = ''

    loop do
      prompt("Choose one: #{VALID_CHOICES.values.join(', ')}\
      (#{VALID_CHOICES.keys.join(', ')})")
      choice_short = gets.chomp

      if VALID_CHOICES.keys.include?(choice_short)
        break
      else
        prompt("That is not a valid choice.")
      end
    end

    player_choice   = VALID_CHOICES[choice_short]
    computer_choice = VALID_CHOICES.values.sample

    prompt("You chose: #{player_choice}; Computer chose #{computer_choice}")

    round_result = determine_winner(player_choice, computer_choice)
    if round_result == "You won!"
      game_scores[:player] += 1
    elsif round_result == "Computer won!"
      game_scores[:computer] += 1
    end
    prompt(round_result)

    if game_scores[:player] >= 5
      prompt("You win the game! Final score is: \
      #{game_scores[:player]} to #{game_scores[:computer]}")
      break
    elsif game_scores[:computer] >= 5
      prompt("You lose the game! Final score is: \
      #{game_scores[:player]} to #{game_scores[:computer]}")
      break
    end
    prompt("Score is: #{game_scores[:player]} to #{game_scores[:computer]}")
  end

  prompt("Do you want to play again?")
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")

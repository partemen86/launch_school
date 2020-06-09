VALID_CHOICES = { 'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
                  'l' => 'lizard', 'sp' => 'spock' }
WINNING_COMBOS = { 'rock'     => ['lizard', 'scissors'],
                   'paper'    => ['rock', 'spock'],
                   'scissors' => ['paper', 'lizard'],
                   'spock'    => ['rock', 'scissors'],
                   'lizard'   => ['spock', 'paper'] }
ROUND_AMOUNT = 5

def prompt(msg)
  puts "=> #{msg}"
end

def prompt_for_choice
  prompt("Choose one: #{VALID_CHOICES.values.join(', ')}\
      (#{VALID_CHOICES.keys.join(', ')})")
end

def play_again?
  prompt("Do you want to play again?")
end

def update_scores(score_hash, hash_key)
  score_hash[hash_key] += 1
end

def win?(first_player_choice, second_player_choice)
  WINNING_COMBOS[first_player_choice].include?(second_player_choice)
end

def determine_winner(player, computer)
  if win?(player, computer)
    player
  elsif win?(computer, player)
    computer
  end
end

loop do
  system "clear"
  prompt("Welcome to Rock Paper Scissors! First to 5 wins is the winner!")
  game_scores = { player: 0, computer: 0 }

  loop do
    choice_short = ''

    loop do
      prompt_for_choice
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
    if round_result == player_choice
      update_scores(game_scores, :player)
      prompt("You won!")
    elsif round_result == computer_choice
      update_scores(game_scores, :computer)
      prompt("Computer won!")
    else
      prompt("It's a tie!")
    end

    if game_scores[:player] >= ROUND_AMOUNT
      prompt("You win the game! Final score is: \
      #{game_scores[:player]} to #{game_scores[:computer]}")
      break
    elsif game_scores[:computer] >= ROUND_AMOUNT
      prompt("You lose the game! Final score is: \
      #{game_scores[:player]} to #{game_scores[:computer]}")
      break
    end
    prompt("Score is: #{game_scores[:player]} to #{game_scores[:computer]}")
  end

  play_again?
  answer = gets.chomp

  break unless answer.downcase == 'yes' || answer.downcase == 'y'
end

prompt("Thank you for playing. Good bye!")

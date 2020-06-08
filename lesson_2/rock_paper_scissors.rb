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
    @player_score += 1
    "You won!"
  elsif win?(computer, player)
    @computer_score += 1
    "Computer won!"
  else
    "Its a tie!"
  end
end

loop do
  @player_score = 0
  @computer_score = 0

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
    # computer_choice_long = VALID_CHOICES[computer_choice_short]

    prompt("You chose: #{player_choice}; Computer chose #{computer_choice}")

    prompt(determine_winner(player_choice, computer_choice))

    if @player_score >= 5
      prompt("You win the game! Final score is: \
      #{@player_score} to #{@computer_score}")
      break
    elsif @computer_score >= 5
      prompt("You lose the game! Final score is: \
      #{@player_score} to #{@computer_score}")
      break
    end
    prompt("Score is: #{@player_score} to #{@computer_score}")
  end

  prompt("Do you want to play again?")
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for playing. Good bye!")

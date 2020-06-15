def prompt(str)
  puts "=> #{str}"
end

def display_final_score(player1, player2)
  prompt "Final score is: #{player1} to #{player2}"
end

def joinor(array, delimiter = ', ', word = 'and')
  case array.size
  when 0 then ''
  when 1 then array[0]
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array[-1]}"
    array.join(delimiter)
  end
end

def play_again?
  prompt("Play again? (y or n)")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def initialize_deck
  {
    Diamonds: [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
    Spades:   [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
    Hearts:   [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace'],
    Clubs:    [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']
  }
end

def draw_card(deck)
  suit = deck.keys.sample
  # card as an array of suit and value
  [suit, deck[suit].delete(deck[suit].sample)]
end

def initialize_hand(deck)
  hand = []
  hand << draw_card(deck)
  hand << draw_card(deck)
end

def stay?
  answer = ''
  loop do
    prompt "Do you want to hit or stay?"
    answer = gets.chomp.downcase
    break if answer == 'hit' || answer == 'stay'
    prompt "That is not a valid choice."
  end

  answer == 'stay'
end

def return_card_values(hand)
  card_values = hand.map do |card|
    card[1]
  end
  joinor(card_values)
end

def add_values(hand)
  total = 0
  card_values = hand.map do |card|
    card[1]
  end
  card_values.each do |value|
    case value
    when (2..10) then total += value
    when 'Jack', 'Queen', 'King' then total += 10
    when 'Ace' then total += 11
    end
  end
  card_values.select { |value| value == 'Ace' }.count.times do
    total -= 10 if total > 21
  end
  total
end

def bust?(hand)
  add_values(hand) > 21
end

loop do
  # initializing
  system 'clear'
  current_deck  = initialize_deck
  computer_hand = initialize_hand(current_deck)
  player_hand   = initialize_hand(current_deck)
  computer_score = add_values(computer_hand)
  prompt "Dealer has #{computer_hand[0][1]} of #{computer_hand[0][0]} \
and an unknown card."
  prompt "You have #{player_hand[0][1]} of #{player_hand[0][0]} \
and #{player_hand[1][1]} of #{player_hand[1][0]}"
  prompt "You have #{add_values(player_hand)} in total"
  # player turn
  loop do
    break if bust?(player_hand) || stay?
    new_card = draw_card(current_deck)
    prompt "You were dealt #{new_card[1]} of #{new_card[0]}."
    player_hand << new_card
    prompt "You have #{return_card_values(player_hand)}"
    prompt "You now have: #{add_values(player_hand)}."
  end

  player_score = add_values(player_hand)

  # if player busts, the game is over
  if bust?(player_hand)
    prompt "You bust! Dealer wins!"
  # if player did not bust, computer turn  
  else
    prompt "Dealer shows his hand"
    prompt "Dealer has #{computer_hand[0][1]} of #{computer_hand[0][0]} \
and #{computer_hand[1][1]} of #{computer_hand[1][0]}."
    prompt "Dealer has: #{add_values(computer_hand)}."
    prompt "Enter any key to continue"
    gets
    loop do
      break if bust?(computer_hand) || add_values(computer_hand) >= 17
      prompt "Dealer hits."
      new_card = draw_card(current_deck)
      prompt "Dealer was dealt #{new_card[1]} of #{new_card[0]}."
      computer_hand << new_card
      prompt "Dealer now has #{return_card_values(computer_hand)}"
      prompt "Dealer now has: #{add_values(computer_hand)} in total."
      prompt "Enter any key to continue."
      gets
    end

    computer_score = add_values(computer_hand)
    prompt bust?(computer_hand) ? "Dealer busts! You win!" : "Dealer stays."

    if player_score > computer_score
      prompt "You win!"
    elsif player_score == computer_score
      prompt "It's a tie!"
    else
      prompt "Dealer wins!"
    end
  end

  display_final_score(player_score, computer_score)
  break unless play_again?
end

MAX_SCORE = 21
DEALER_STAYS_AT = 17
SUITS = ['Diamonds', 'Spades', 'Hearts', 'Clubs']
VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

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
  deck = {}
  SUITS.map do |suit|
    deck[suit] = VALUES.dup
  end
  deck
  # {
  #   Diamonds: VALUES.dup,
  #   Spades:   VALUES.dup,
  #   Hearts:   VALUES.dup,
  #   Clubs:    VALUES.dup
  # }
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
    prompt "Do you want to hit(h) or stay(s)?"
    answer = gets.chomp.downcase
    break if answer == 'h' || answer == 's'
    prompt "That is not a valid choice. Please enter 'h' or 's'."
  end

  answer == 's'
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
    total -= 10 if total > MAX_SCORE
  end
  total
end

def bust?(hand)
  add_values(hand) > MAX_SCORE
end

loop do
  # initializing
  system 'clear'
  prompt "Welcome to Twenty-One!"
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
      break if bust?(computer_hand) || add_values(computer_hand) >= DEALER_STAYS_AT
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
    if bust?(computer_hand)
      prompt "Dealer busts! You win!"
    else
      prompt "Dealer stays."
      if player_score > computer_score
        prompt "You win!"
      elsif player_score == computer_score
        prompt "It's a tie!"
      else
        prompt "Dealer wins!"
      end
    end
  end
p current_deck
  display_final_score(player_score, computer_score)
  break unless play_again?
end

prompt "Thank you for playing!"

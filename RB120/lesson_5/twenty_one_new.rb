class Participant
  MAX_SCORE = 21

  attr_accessor :hand
  def initialize
    @hand = []
  end

  def reset
    @hand = []
  end

  def return_hand
    hand.join(", ")
  end

  def determine_score
    total = 0
    @hand.each do |card|
      case card.value
      when (2..10) then total += card.value
      when 'Jack', 'Queen', 'King' then total += 10
      when 'Ace' then total += 11
      end
    end
    @hand.select { |card| card.value == 'Ace' }.count.times do
      total -= 10 if total > MAX_SCORE
    end
    total
  end

  def busted?
    determine_score > MAX_SCORE
  end
end

class Player < Participant
end

class Dealer < Participant
end

class Deck
  SUITS = %w(Hearts Spades Clubs Diamonds)
  CARD_VALUES = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @deck = []
    SUITS.each do |suit|
      CARD_VALUES.each do |value|
        @deck << Card.new(suit, value)
      end
    end
    @deck.shuffle!
  end

  def draw_card
    @deck.pop
  end
end

class Card
  attr_accessor :suit, :value

  def initialize(suit, value)
    @suit = suit
    @value = value
  end

  def to_s
    "#{@value} of #{@suit}"
  end
end

class Game
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    loop do
      reset
      clear
      deal_cards
      show_cards
      player_turn
      dealer_turn
      show_result
      break unless play_again?
    end
    puts "Thank you for playing 21!"
  end

  def clear
    system 'clear'
  end

  def deal_cards
    2.times { hit(@player) }
    2.times { hit(@dealer) }
  end

  def hit(player)
    player.hand << @deck.draw_card
  end

  def show_cards
    show_player_hand
    puts "Dealer has #{@dealer.hand[0]} and an unknown card"
  end

  def player_turn
    loop do
      answer = ''
      loop do
        puts "Do you wish to (h)it or (s)tay?"
        answer = gets.chomp
        break if answer.downcase == 'h' || answer.downcase == 's'
        puts "Sorry, that is not a valid choice."
      end
      clear
      hit(@player) if answer == 'h'
      show_player_hand
      break if answer == 's' || @player.busted?
    end
  end

  def dealer_turn
    puts "Dealer shows his hand:"
    show_dealer_hand
    if @player.busted?
      puts "You busted! Dealer wins!"
    elsif @dealer.determine_score >= 17
      puts "Dealer stays"
    elsif @dealer.determine_score < 17
      dealer_hits
    end
  end

  def dealer_hits
    until @dealer.determine_score >= 17
      puts "Dealer hits"
      sleep 2
      hit(@dealer)
      show_dealer_hand
    end
    puts "Dealer stays" if @dealer.determine_score < 22
  end

  def show_result
    if @dealer.busted?
      puts "Dealer busted! You win!"
    elsif @dealer.determine_score > @player.determine_score
      puts "Dealer has the higher score! You lose!"
    elsif @dealer.determine_score == @player.determine_score
      puts "Its a tie!"
    else
      puts "You have the higher score! You win!"
    end
  end

  def show_player_hand
    puts "You have #{@player.return_hand} for a score of #{@player.determine_score}"
  end

  def show_dealer_hand
    puts "Dealer has #{@dealer.return_hand} for a score of: #{@dealer.determine_score}"
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset
    @deck = Deck.new
    @player.reset
    @dealer.reset
  end
end

game = Game.new
game.start

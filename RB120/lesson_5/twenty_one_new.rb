class Participant
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
      case card.rank
      when (2..10) then total += card.rank
      when 'Jack', 'Queen', 'King' then total += 10
      when 'Ace' then total += 11
      end
    end
    @hand.select { |card| card.rank == 'Ace' }.count.times do
      total -= 10 if total > Game::MAX_SCORE
    end
    total
  end

  def busted?
    determine_score > Game::MAX_SCORE
  end
end

class Player < Participant
  attr_reader :name
  def initialize
    @name = get_player_name
  end

  def get_player_name
    name = ''
    loop do
      puts "What is your name?"
      name = gets.chomp
      break unless name.strip.empty?
      puts "Sorry must enter a name"
    end
    name.capitalize
  end
end

class Dealer < Participant
  DEALER_NAMES = %w(Number1 Number7 Sparky)
  attr_reader :name
  def initialize
    @name = DEALER_NAMES.sample
  end
end

class Deck
  SUITS = %w(Hearts Spades Clubs Diamonds)
  CARD_RANKS = [2, 3, 4, 5, 6, 7, 8, 9, 10, 'Jack', 'Queen', 'King', 'Ace']

  def initialize
    @deck = []
    SUITS.each do |suit|
      CARD_RANKS.each do |rank|
        @deck << Card.new(suit, rank)
      end
    end
    @deck.shuffle!
  end

  def draw_card
    @deck.pop
  end
end

class Card
  attr_reader :suit, :rank

  def initialize(suit, rank)
    @suit = suit
    @rank = rank
  end

  def to_s
    "#{@rank} of #{@suit}"
  end
end

class Game
  attr_reader :player, :dealer
  attr_accessor :deck
  MAX_SCORE = 21
  DEALER_HIT_UNTIL = 17
  def initialize
    @player = Player.new
    @dealer = Dealer.new
    @deck = Deck.new
  end

  def start
    puts "Welcome to 21!"
    play_game
    puts "Thank you for playing 21!"
  end

  def play_game
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
  end

  def clear
    system 'clear'
  end

  def deal_cards
    2.times { hit(player) }
    2.times { hit(dealer) }
  end

  def hit(player)
    player.hand << deck.draw_card
  end

  def show_cards
    show_hand(player)
    puts "#{dealer.name} has #{dealer.hand[0]} and an unknown card"
  end

  def player_turn
    loop do
      answer = hit_or_stay
      clear
      hit(player) if answer == 'h'
      show_hand(player)
      puts "#{dealer.name} has #{dealer.hand[0]} and an unknown card"
      break if answer == 's' || player.busted?
    end
  end

  def hit_or_stay
    answer = ''
    loop do
      puts "Do you wish to (h)it or (s)tay?"
      answer = gets.chomp
      break if answer.downcase == 'h' || answer.downcase == 's'
      puts "Sorry, that is not a valid choice."
    end
    answer
  end

  def dealer_turn
    puts "#{dealer.name} shows his hand:"
    show_hand(dealer)
    if player.busted? || dealer.determine_score >= DEALER_HIT_UNTIL
      puts "#{dealer.name} stays"
    elsif dealer.determine_score < DEALER_HIT_UNTIL
      dealer_hits
    end
  end

  def dealer_hits
    until dealer.determine_score >= DEALER_HIT_UNTIL
      puts "#{dealer.name} hits"
      sleep 2
      hit(dealer)
      show_hand(dealer)
    end
    puts "#{dealer.name} stays" if dealer.determine_score < 22
  end

  def show_result
    if player.busted?
      puts "#{player.name} busted! #{dealer.name} wins!"
    elsif dealer.busted?
      puts "#{dealer.name} busted! #{player.name} wins!"
    elsif @dealer.determine_score > @player.determine_score
      puts "#{dealer.name} has the higher score! #{player.name} loses!"
    elsif dealer.determine_score == player.determine_score
      puts "Its a tie!"
    else
      puts "#{player.name} has the higher score! #{player.name} wins!"
    end
  end

  def show_hand(person)
    puts "#{person.name} has #{person.return_hand} for a score of #{person.determine_score}"
  end

  def play_again?
    answer = ''
    loop do
      puts ''
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ['y', 'n'].include? answer
      puts "Sorry, must be y or n."
    end
    answer == 'y'
  end

  def reset
    self.deck = Deck.new
    player.reset
    dealer.reset
  end
end

game = Game.new
game.start

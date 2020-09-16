# Write an algorithm to pick the best poker hand(s) from a list.

# See wikipedia for an overview of poker hands. For this exercise,
# you don't have to consider wild cards.

# Focus to get the tests below to pass. We're using 2 letters to represent
# a poker card - the first letter is the rank of the card, represented by
# 2, 3, 4, 5, 6, 7, 8, 9, T, J, Q, K, and A. The second letter is the suit of
# the card, represented by S, H, C and D (Spades, Hearts, Clubs and Diamonds).
# For example, "8D" means eight of diamonds, "TH" means ten of hearts, and "AS"
# means ace of spades.exit

class Poker
  def initialize(hands)
    @hands = hands
  end

  def best_hand
    max = @hands.map { |a_hand| PokerRanks.new(a_hand).score }.max
    @hands.select { |hand| PokerRanks.new(hand).score == max }
  end
end

class PokerRanks
  RANKS = { 'T' => '10', 'J' => '11', 'Q' => '12', 'K' => '13', 'A' => '14' }
  HANDS = {
    royal_flush: 900,
    straight_flush: 800,
    four_of_a_kind: 700,
    full_house: 600,
    flush: 500,
    straight: 400,
    three_of_a_kind: 300,
    two_pair: 200,
    pair: 100,
    high_card: 0
  }.freeze

  def initialize(hand)
    @hand = hand
    @hand_by_value = hand.map { |card| (RANKS[card[0]] || card[0]).to_i }.sort
  end

  def score
    HANDS.each { |key, value| return value + send(key) if send(key) }
  end

  def royal_flush
    straight_flush && @hand_by_value.all? { |card| card >= 10 }
  end

  def straight_flush
    @hand_by_value.max if flush && straight
  end

  def four_of_a_kind
    n_of_a_kind(4)
  end

  def full_house
    n_of_a_kind(3) if n_of_a_kind(3) && n_of_a_kind(2)
  end

  def flush
    @hand_by_value.max if @hand.all? { |card| card[1] == @hand[0][1] }
  end

  def straight
    hand = @hand_by_value.include?(14) ? [1] + @hand_by_value : @hand_by_value
    count = 0
    hand.each_with_index do |card_val, idx|
      count += 1 if card_val + 1 == hand[idx + 1]
    end

    @hand_by_value.max if count == 4
  end

  def three_of_a_kind
    n_of_a_kind(3)
  end

  def two_pair
    pairs = @hand_by_value.select { |value| @hand_by_value.count(value) == 2 }
    pairs.max + (pairs.min / 10.0) if pairs.size == 4
  end

  def pair
    n_of_a_kind(2)
  end

  def n_of_a_kind(num)
    @hand_by_value.select { |value| @hand_by_value.count(value) == num }.first
  end

  def high_card
    @hand_by_value.max
  end
end

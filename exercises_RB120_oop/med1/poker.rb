class Card
  include Comparable
  attr_reader :rank, :suit

  VALUES = { "Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14 }

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value
  end

  def value
    VALUES.fetch(rank, rank)
    # find the rank in the values constant hash or use rank as default value
  end

  def <=>(other_card)
    value <=> other_card.value
  end

  def to_s
    "#{rank} of #{suit}"
  end #rannk suit
end

class Deck
  RANKS = ((2..10).to_a + %w(Jack Queen King Ace)).freeze
  SUITS = %w(Hearts Clubs Diamonds Spades).freeze

  def initialize
    new_deck
  end

  def draw
    new_deck if deck.empty?
    deck.pop
  end

  private

  attr_accessor :deck

  def new_deck
    @deck = RANKS.product(SUITS).map do |rank, suit|
      Card.new(rank, suit)
    end

    @deck.shuffle!
  end
end

class PokerHand
  attr_accessor :deck, :hand, :rank_hash, :suit_hash
  
  def initialize(deck)
    @deck = deck
    @hand = new_hand
    count_rank
    count_suit
  end
  
  def new_hand
    new_array = []
    5.times {new_array << deck.draw}
    new_array
  end

  def print
    hand.each { |card| puts card }
  end

  def evaluate
    case
    when royal_flush?     then 'Royal flush'
    when straight_flush?  then 'Straight flush'
    when four_of_a_kind?  then 'Four of a kind'
    when full_house?      then 'Full house'
    when flush?           then 'Flush'
    when straight?        then 'Straight'
    when three_of_a_kind? then 'Three of a kind'
    when two_pair?        then 'Two pair'
    when pair?            then 'Pair'
    else                       'High card'
    end
  end

  private

  def royal_flush?
    flush? && straight? && hand.min.value == 10
  end

  def straight_flush?
    flush? && straight?
  end

  def four_of_a_kind?
    rank_hash.value?(4)
  end

  def full_house?
    three_of_a_kind? && pair?
  end

  def flush?
    suit_hash.value?(5)
  end

  def straight?
    hand.sort!.each_with_index do |card, i|
      break if i == hand.size - 1
      return false if card.value.next != hand[i+1].value
    end
    true
  end

  def three_of_a_kind?
    rank_hash.value?(3)
  end

  def two_pair?
    rank_hash.select { |_, count| count == 2 }.size == 2
  end

  def pair?
    rank_hash.value?(2)
  end
  
  def count_rank
    @rank_hash = {}
    hand.each do |card|
      if rank_hash.key?(card.rank)
        rank_hash[card.rank] += 1
      else
        rank_hash[card.rank] = 1
      end
    end
  end
  
  def count_suit
    @suit_hash = {}
    hand.each do |card|
      if suit_hash.key?(card.suit)
        suit_hash[card.suit] += 1
      else
        suit_hash[card.suit] = 1
      end
    end
  end
end

hand = PokerHand.new(Deck.new)
hand.print
puts hand.evaluate

puts "-------"

# Danger danger danger: monkey
# patching for testing purposes.
class Array
  alias_method :draw, :pop
end

# Test that we can identify each PokerHand type.
# puts 'Royal flush'
hand = PokerHand.new([
  Card.new(10,      'Hearts'),
  Card.new('Ace',   'Hearts'),
  Card.new('Queen', 'Hearts'),
  Card.new('King',  'Hearts'),
  Card.new('Jack',  'Hearts')
])
puts hand.evaluate == 'Royal flush'


hand = PokerHand.new([
  Card.new(8,       'Clubs'),
  Card.new(9,       'Clubs'),
  Card.new('Queen', 'Clubs'),
  Card.new(10,      'Clubs'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight flush'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Four of a kind'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Full house'

hand = PokerHand.new([
  Card.new(10, 'Hearts'),
  Card.new('Ace', 'Hearts'),
  Card.new(2, 'Hearts'),
  Card.new('King', 'Hearts'),
  Card.new(3, 'Hearts')
])
puts hand.evaluate == 'Flush'

hand = PokerHand.new([
  Card.new(8,      'Clubs'),
  Card.new(9,      'Diamonds'),
  Card.new(10,     'Clubs'),
  Card.new(7,      'Hearts'),
  Card.new('Jack', 'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new('Queen', 'Clubs'),
  Card.new('King',  'Diamonds'),
  Card.new(10,      'Clubs'),
  Card.new('Ace',   'Hearts'),
  Card.new('Jack',  'Clubs')
])
puts hand.evaluate == 'Straight'

hand = PokerHand.new([
  Card.new(3, 'Hearts'),
  Card.new(3, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(3, 'Spades'),
  Card.new(6, 'Diamonds')
])
puts hand.evaluate == 'Three of a kind'

hand = PokerHand.new([
  Card.new(9, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(8, 'Spades'),
  Card.new(5, 'Hearts')
])
puts hand.evaluate == 'Two pair'

hand = PokerHand.new([
  Card.new(2, 'Hearts'),
  Card.new(9, 'Clubs'),
  Card.new(5, 'Diamonds'),
  Card.new(9, 'Spades'),
  Card.new(3, 'Diamonds')
])
puts hand.evaluate == 'Pair'

hand = PokerHand.new([
  Card.new(2,      'Hearts'),
  Card.new('King', 'Clubs'),
  Card.new(5,      'Diamonds'),
  Card.new(9,      'Spades'),
  Card.new(3,      'Diamonds')
])
puts hand.evaluate == 'High card'
class Card
  include Comparable
  attr_reader :rank, :suit
  
  VALUES = { "Jack" => 11, "Queen" => 12, "King" => 13, "Ace" => 14}
  SUITS  = { "Diamonds" => 1, "Clubs" => 2, "Hearts" => 3, "Spades" => 4}

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
    @value = value
  end
  
  def value
    VALUES.fetch(rank, rank)
    # if you can't find the rank in the values constant hash use rank as default value
  end
  
  def value_based_on_suit
    SUITS.fetch(suit)
  end
  
  def <=>(other_card)
    if (value <=> other_card.value) == 0
      value_based_on_suit <=> other_card.value_based_on_suit
    else
      value <=> other_card.value
    end
  end
  
  def to_s
    "#{rank} of #{suit}"
  end
end

cards = [Card.new(2, 'Hearts'),
        Card.new(10, 'Diamonds'),
        Card.new('Ace', 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Hearts')
puts cards.max == Card.new('Ace', 'Clubs')

cards = [Card.new(5, 'Hearts')]
puts cards.min == Card.new(5, 'Hearts')
puts cards.max == Card.new(5, 'Hearts')

cards = [Card.new(4, 'Hearts'),
        Card.new(4, 'Diamonds'),
        Card.new(10, 'Clubs')]
puts cards.min.rank == 4
puts cards.max == Card.new(10, 'Clubs')

cards = [Card.new(7, 'Diamonds'),
        Card.new('Jack', 'Diamonds'),
        Card.new('Jack', 'Spades')]
puts cards.min == Card.new(7, 'Diamonds')
puts cards.max.rank == 'Jack'

cards = [Card.new(8, 'Diamonds'),
        Card.new(8, 'Clubs'),
        Card.new(8, 'Spades')]
puts cards.min.rank == 8
puts cards.max.rank == 8

cards = [Card.new(2, 'Hearts'),
        Card.new(2, 'Diamonds'),
        Card.new(3, 'Clubs')]
puts cards
puts cards.min == Card.new(2, 'Diamonds')
puts cards.max == Card.new(3, 'Clubs')
=begin
extras
  # keep track of cards in play and still in the deck
  # display cards as ASCII art instead of a sentance
-------
|    A|
|     |
|     |
-------
=end

# breadcrumbs, working on a larger deck, fix array error
# sometimes card was nil, I think I fixed it by adding bounds cut card

GOAL = 21
NUM_DECKS = 4
NUM_PLAYERS = 2

require "pry"
class Hand
  include Comparable

  def initialize
    @cards = []
  end

  def reset
    initialize
  end

  def <<(card)
    cards << card
  end

  def total_value
    while total > GOAL && aces_as_elevens?
      ace_to_one
    end
    total
  end

  def show_hand
    cards.each(&:show_card)
  end

  def show_hidden_cards
    cards.each(&:show_hidden_card)
  end

  protected

  def <=>(other_hand)
    total_value <=> other_hand.total_value
  end

  private

  attr_accessor :cards
  attr_writer :total

  def total
    self.total = cards.reduce(0) { |sum,card| card.value + sum}
  end

  def ace_to_one
    cards.each do |card|
      if card.ace? && card.eleven?
        card.eleven_to_one
        break
      end
    end
  end

  def aces_as_elevens?
    cards.any?(&:eleven?)
  end
end

class Card
  attr_reader :value

  def initialize(name, suit)
    @name = name
    @suit = suit
    @hide = false
    @value = initial_value
  end

  def hide_card
    self.hide = true
  end

  def eleven_to_one
    self.value = 1
  end

  def ace?
    name == "A"
  end

  def eleven?
    value == 11
  end

  def to_s
    "   The #{name} of #{suit}."
  end

  def show_card
    puts hidden? ? "   Face Down Card" : self
    #FIX ME ^ work?
    # puts self unless hidden?
    # puts "   Face Down Card" if hidden?
  end

  def show_hidden_card
    puts self
  end

  def initial_value
    return name.to_i if (2..10).include?(name.to_i)
    name == "A" ? 11 : 10
  end

  private

  attr_writer :hide
  attr_reader :name, :suit
  attr_writer :value

  def hidden?
    @hide
  end
end

class Deck
  attr_accessor :deck, :known_cards

  CARD_NAMES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = %w(Spades Clubs Hearts Diamonds)

  def initialize
    self.known_cards = []
    new_deck
  end

  def new_deck
    self.deck = init_deck
    deck.shuffle!
    self.cut_card = cut_card_method
  end

  def init_deck
    array_cards = []
    self.known_cards = []
    NUM_DECKS.times do
      CARD_NAMES.each do |name|
        SUITS.each do |suit|
          array_cards << Card.new(name, suit)
        end
      end
    end
    array_cards
  end

  def check_cards_left_in_deck
    return unless cut_card_reached?
    puts "The dealer reached the cut card during the last hand."
    puts "A new shuffled deck will be used for the next round."
    new_deck
  end

  def deal_a_card
    card = deck.pop
    known_cards << card
    card
  end

  def deal_a_facedown_card
    card = deck.pop
    known_cards << card
    card.hide_card
    card
  end
  
  #the two methods above do a lot, simplify methods, split into more methods.

  private

  attr_accessor :cut_card

  def cut_card_method
    min = max_cards_one_round(NUM_DECKS, NUM_PLAYERS)
    (min..deck.size - min).to_a.sample
  end

  def cut_card_reached?
    deck.size <= cut_card
  end

  def max_cards_one_round(num_decks, num_players)
    num_of_same_value = 4 * num_decks
    num_cards = min_cards_one_hand(num_of_same_value)
    num_cards * num_players
  end

  def min_cards_one_hand(num_of_same_value)
    total = 0
    #might be able to use reduce method to shorten this method.
    num_cards = 0
    (1..10).to_a.each do |value|
      num_of_same_value.times do
        break if total > 21
        num_cards += 1
        total += value
      end
    end
    num_cards
  end
end

class Participant
  attr_reader :hand

  def initialize(deck)
    @hand = Hand.new
    @deck = deck
  end

  def hit
    hand << deck.deal_a_card
  end

  def busted?
    total > GOAL
  end

  def total
    hand.total_value
  end

  def new_card(card)
    hand << card
  end
  
  def show_total
    puts "The total is --- #{total}"
  end

  private

  attr_writer :hand
  attr_reader :deck
end

class Player < Participant
  def show_hand
    puts "You have the following cards:"
    hand.show_hand
    show_total
    puts 
  end
end

class Dealer < Participant
  HAND_DEALER_STOPS_AT = 17

  def show_hand
    puts "The Dealer has the following cards:"
    hand.show_hand
  end

  def strategy
    show_hidden_cards
    show_total
    loop do
      break if total >= HAND_DEALER_STOPS_AT || busted?
      puts "The dealer has less then #{HAND_DEALER_STOPS_AT}, so they hit."
      hit
      puts
      show_hidden_cards
      show_total
    end
  end

  private

  def show_hidden_cards
    puts "Dealer has these cards:"
    hand.show_hidden_cards
  end
end

class Game21
  def initialize
    @deck = Deck.new
    @player = Player.new(deck)
    @dealer = Dealer.new(deck)
    @choice = nil
  end

  def play
    welcome_message
    loop do
      round
      break unless keep_playing?
      reset_hands
      deck.check_cards_left_in_deck
    end
    goodbye_message
  end

  private

  attr_reader :dealer, :player, :deck

  def keep_playing?
    answer = nil
    loop do
      puts "Do you want to keep playing? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include?(answer)
      puts "I didn't understand that. Please type 'y' or 'n'."
    end
    puts "--------------------------"
    true unless answer == 'n'
  end

  def round
    deal_cards
    show_cards
    player_turn
    dealers_turn unless player.busted?
    determine_winner
    puts "--------------------------"
  end

  def reset_hands
    player.hand.reset
    dealer.hand.reset
  end

  def welcome_message
    puts "Welcome to Twenty-One. Let's play"
    puts
  end

  def deal_cards
    player.new_card(deck.deal_a_card)
    player.new_card(deck.deal_a_card)

    dealer.new_card(deck.deal_a_facedown_card)
    dealer.new_card(deck.deal_a_card)
  end

  def show_cards
    dealer.show_hand
    puts
    player.show_hand
    puts
  end

  def player_turn
    loop do
      answer = choice
      break if answer == "stay"
      player.hit
      puts
      player.show_hand
      puts
      break if player.busted?
    end
  end

  def choice
    answer = nil
    loop do
      puts "Do you want to (hit) or (stay)?"
      answer = gets.chomp.downcase
      break if %w(hit stay).include?(answer)
      puts "I am sorry you must choose betweeen hit and stay."
    end
    answer
  end

  def dealers_turn
    puts "---Dealer's Turn---"
    dealer.strategy
    puts
  end

  def determine_winner
    if player.busted?
      puts "You busted."
      dealer_won
    elsif dealer.busted?
      puts "The dealer busted."
      player_won
    elsif player.hand > dealer.hand
      player_won
    elsif dealer.hand > player.hand
      dealer_won
    else
      noone_won
    end
  end

  def goodbye_message
    puts "Thanks for playing."
  end

  def player_won
    puts "You won this game! The dealer's turn to pay."
  end

  def dealer_won
    puts "The dealer won, cough up the money!"
  end

  def noone_won
    puts "It's a tie. At least you don't have to pay."
  end
end

# deck1 = Deck.new
# p deck1.deck.size

game = Game21.new
game.play

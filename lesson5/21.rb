=begin
extras
  # keep track of cards in play and still in the deck
=end

GOAL = 21

require "pry"
class Hand
  include Comparable

  def initialize
    @cards = []
    @total = nil
  end
  
  def reset
    initialize
  end
  
  def <<(card)
    cards << card
  end
  
  def total_value
    total = sum
    while total > 21
      break unless has_aces_as_elevens?
      ace_to_one
    end
    total = sum
  end
  
  def show_hand
    cards.each do |card|
      card.show_card
    end
  end
  
  def show_hidden_cards
    cards.each do |card|
      card.show_hidden_card
    end
    puts "The total is --- #{total_value}"
  end
  
  protected
  
  def <=>(other_hand)
    total_value <=> other_hand.total_value
  end
  
  private
  attr_accessor :cards, :total
  
  def sum
    s = 0
    cards.each do |card|
      s += card.value
    end
    s
  end
  
  def ace_to_one
    cards.each do |card|
      if card.ace? && card.eleven?
        card.eleven_to_one
        break
      end
    end
  end
  
  def has_aces_as_elevens?
    cards.any?{|card| card.eleven?}
  end
  
end

class Card
  attr_accessor :value
  
  def initialize(name, suit)
    @name = name
    @suit = suit
    @hide = false
    @value = get_value
  end
  
  def hide_card
    self.hide = true
  end
  
  def eleven_to_one
    self.value = 1 if ace?
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
    puts self unless hidden?
    puts "   Face Down Card" if hidden?
  end
  
  def show_hidden_card
    puts self
  end
  
  private
  attr_writer :hide
  attr_reader :name, :suit
  
  def get_value
    if (2..10).include?(name.to_i)
      return name.to_i
    elsif name == "A"
      return 11
    else
      return 10
    end
  end
  
  def hidden?
    @hide
  end
end

class Deck
  attr_accessor :deck, :known_cards
  
  CARD_NAMES = %w(A 2 3 4 5 6 7 8 9 10 J Q K)
  SUITS = %w(Spades Clubs Hearts Diamonds)
  
  def initialize
    new_deck
    @known_cards = []
  end
  
  def new_deck
    array_cards = []
    CARD_NAMES.each do |name|
      SUITS.each do |suit|
        array_cards << Card.new(name, suit)
      end
    end
    @deck = array_cards
    shuffle
  end
  
  def show_deck
    deck.each do |card|
      card.show_card
    end
  end
  
  def shuffle
    deck.shuffle!
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
  
  private
  
  attr_writer :hand
  attr_reader :deck
end

class Player < Participant
  def show_hand
    puts "You have the following cards:"
    hand.show_hand
    puts "The total is --- #{total}"
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
    loop do
      break if total > HAND_DEALER_STOPS_AT || busted?
      puts "The dealer has less then #{HAND_DEALER_STOPS_AT}, so the dealer hits."
      hit
      puts
      show_hidden_cards
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
    
  end
  
  def play
    welcome_message
    loop do
      round
      break unless keep_playing?
      reset_hands
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
      answer = get_choice
      break if answer == "stay"
      player.hit
      puts
      player.show_hand
      puts
      break if player.busted?
    end
  end
  
  def get_choice
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
    else
      if player.hand > dealer.hand
        player_won
      elsif dealer.hand > player.hand
        dealer_won
      else
        noone_won
      end
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

game = Game21.new
game.play

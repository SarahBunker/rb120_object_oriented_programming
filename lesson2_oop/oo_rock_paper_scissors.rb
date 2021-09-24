VALUES = ['rock', 'paper', 'scissors']

class Move
  def initialize(value)
    @value = value
  end

  def rock?
    @value == "rock"
  end

  def paper?
    @value == "paper"
  end

  def scissors?
    @value == "scissors"
  end

  def to_s
    @value
  end

  def >(other_move)
    (rock? && other_move.scissors?) ||
      (paper? && other_move.rock?) ||
      (scissors? && other_move.paper?)
  end

  def ==(other_move)
    value == other_move.value
  end

  protected

  attr_reader :value
end

class Player
  attr_accessor :move, :name

  def initialize
    set_name
  end
end

class Human < Player
  def set_name
    n = nil
    loop do
      puts "What is your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value"
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose rock, paper, or scissors"
      choice = gets.chomp
      break if VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    self.move = Move.new(choice)
  end
end

class Computer < Player
  def set_name
    self.name = ["R2D2", "Hal", "Atom1", "Number 4"].sample
  end

  def choose
    self.move = Move.new(VALUES.sample)
  end
end

# Game Orchestration Engine
class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome
    puts
    puts "#{human.name}, welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thank you for playing. Good-bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move == computer.move
      display_tie
    elsif human.move > computer.move
      display_win
    else
      display_loss
    end
  end

  def display_tie
    puts "It's a tie"
  end

  def display_loss
    puts "I'm sorry, #{computer.name} won."
  end

  def display_win
    puts "Hey, you beat #{computer.name}. Nice job."
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)?"
      answer = gets.chomp.downcase
      break if ["y", "n"].include? answer
      puts "Sorry, must be y or n."
    end

    return true if answer == "y"
    false
  end

  def play
    display_welcome

    loop do
      puts
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play

class GuessingGame
  MAX_NUM = 100
  NUM_CHANCES = 7
  
  attr_accessor :guess, :num_guesses, :lower_limit, :upper_limit
  attr_reader :the_number
  attr_writer
  
  def initialize
    @lower_limit = 1
    @upper_limit = 100
    @guess = nil
    @the_number = rand(lower_limit+1...upper_limit)
    @num_guesses = NUM_CHANCES
  end
  
  def play
    loop do
      break if won? || out_of_guesses?
      show_num_guesses_remaining
      make_guess
      show_result
    end
  end
  
  def won?
    guess == the_number
  end
  
  def out_of_guesses?
    num_guesses == 0
  end
  
  def show_num_guesses_remaining
    if num_guesses > 1
      p "You have #{num_guesses} guesses remaining." 
    else
      p "You have 1 guess remaining."
    end
  end
  
  def make_guess
    num = nil
    p "Enter a number between #{lower_limit} and #{upper_limit}:"
    loop do
      num = gets.chomp.to_i
      break if (lower_limit+1...upper_limit).cover?(num) #change to array?
      p "Sorry that number is not between #{lower_limit} and #{upper_limit}"
      p "'Between' does not include the boundaries." if [lower_limit,upper_limit].include?(num)
      p "Please try again."
    end
    self.guess = num
    self.num_guesses -= 1
  end

  def show_result
    if guess == the_number
      p "That's the number!"
      puts
      p "You won!"
    elsif guess < the_number
      p "That's too low"
      self.lower_limit = guess
      puts
    else # guess > the_number
      p "That's too high"
      self.upper_limit = guess
      puts
    end
  end
end

game = GuessingGame.new
game.play
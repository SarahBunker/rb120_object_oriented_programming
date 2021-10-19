class GuessingGame
  NUM_CHANCES = 7
  
  attr_accessor :guess, :lower_limit, :upper_limit, :num_guesses
  attr_reader :the_number, :size_of_range
  attr_writer
  
  def initialize(low_bound,high_bound)
    @lower_limit    = low_bound
    @upper_limit    = high_bound
    @size_of_range  = high_bound- low_bound - 1
    @the_number     = rand(lower_limit+1...upper_limit)
    @guess          = nil
    @num_guesses    = Math.log2(size_of_range).to_i + 1
  end
  
  def play
    loop do
      break if won? || out_of_guesses?
      show_guesses_remaining
      make_guess
      show_result
      check_guesses_remaining
    end
  end
  
  def won?
    guess == the_number
  end
  
  def out_of_guesses?
    num_guesses == 0
  end
  
  def show_guesses_remaining
    if num_guesses > 1
      puts "You have #{num_guesses} guesses remaining"
    else
      puts "You have 1 guess remaining."
    end
  end 
  
  def make_guess
    num = nil
    loop do
      #print "Enter a number between #{MIN_LIMIT} and #{MAX_LIMIT}: "
      print "Enter a number between #{lower_limit} and #{upper_limit}: "
      num = gets.chomp.to_i
      #break if (MIN_LIMIT+1...MAX_LIMIT).cover?(num)
      break if (lower_limit+1...upper_limit).cover?(num)
      print "Invalid guess. "
    end
    self.guess = num
    self.num_guesses -= 1
  end 
  
  def show_result
    if guess == the_number
      puts "That's the number!"
      puts
      puts "You won"
    elsif guess < the_number
      puts "Your guess is too low."
      self.lower_limit = guess
    else # guess > the_number
      puts "Your guess is too high."
      self.upper_limit = guess
    end
    puts
  end
  
  def check_guesses_remaining
    puts "You have no more guesses. You Lost! The number was #{the_number}" if out_of_guesses? && !won?
  end
end

game = GuessingGame.new(501,1500)
game.play
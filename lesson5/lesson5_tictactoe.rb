=begin
In this game a player and a computer take turns choosing from unmarked spots on
a three by three grid and placing a marker on that spot. If either player lines
three of their markers in a row horizontally, vertically, or diagonaly they win.

Nouns: player, computer, board, marker, row, square
Verbs: play, mark

Board
Square
Player
- mark
- play
=end
require "pry"

class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      p "found winning line on #{line}." if two_identical_markers_plus_blank?(squares)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----|-----|-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength
  
  def two_identical_markers_plus_blank?(squares)
    blank_space = squares.any?(&:unmarked?)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 2
    markers.uniq.size == 1 && blank_space
  end
  
  def count_marks(squares)
    tally_hash = {}
    squares.collect(&:marker).each do |char|
      if tally_hash.key?(char)
        tally_hash[char] += 1
      else
        tally_hash[char] = 1
      end
    end
    tally_hash
  end
  
  def winnable_line
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if two_identical_markers_plus_blank?(squares)
        return line
      end
    end
    nil
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = " "

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker, :score

  def initialize(marker)
    @marker = marker
    @score  = 0
  end

  def reset_score
    @score = 0
  end
  
  def point
    @score += 1
  end
end

class TTTGame
  HUMAN_MARKER = "X"
  COMPUTER_MARKER = "O"
  FIRST_TO_MOVE = HUMAN_MARKER
  attr_reader :board, :human, :computer
  attr_accessor :current_marker

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
  end

  def play
    clear
    display_welcome_message
    main_game
    display_goodbye_message
  end

  private

  def main_game
    loop do
      match_game
      break unless match_winner? && play_another_match? 
      reset_scores
      reset
      puts "May the odds be ever in your favor."
    end
  end

  def match_game
    loop do
      display_board
      player_move
      display_result
      update_score
      if match_winner?
        display_match_winner
        break
      end
      break unless play_again?
      reset
      display_play_again_message
    end
  end

  def match_winner?
    human.score >= 5 || computer.score >= 5
  end

  def display_match_winner
    puts "You won this match." if human.score == 5
    puts "Sorry the computer won this match." if computer.score == 5
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board if human_turn?
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe"
    puts
  end

  def display_goodbye_message
    puts "Thank you for playing Tic Tac Toe! Goodbye!"
    puts
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def display_board
    puts "Lets play a match, first person to 5 game wins, wins the match."
    puts "You are a #{human.marker}. The computer is a #{computer.marker}."
    puts
    board.draw
    puts
  end

  def human_moves
    puts "Choose a square (#{display_choices(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, not a valid choice."
    end
    board[square] = human.marker
  end
  
  def display_choices(arr, delimiter = ', ', word='or')
    case arr.size
    when 0 then ''
    when 1 then arr.first
    when 2 then arr.join(" #{word} ")
    else
      arr[-1] = "#{word} #{arr.last}"
      arr.join(delimiter)
    end
  end

  def computer_moves
    board[board.unmarked_keys.sample] = computer.marker
  end

  def current_player_moves
    if @current_marker == HUMAN_MARKER
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when HUMAN_MARKER
      puts "You won!"
    when COMPUTER_MARKER
      puts "Computer won!"
    else
      puts "It's a tie."
    end
  end
  
  def update_score
    case board.winning_marker
    when HUMAN_MARKER
      human.point
    when COMPUTER_MARKER
      computer.point
    end

    display_score
  end

  def display_score
    puts "The score is #{human.score} : #{computer.score}."
  end

  def reset_scores
    human.reset_score
    computer.reset_score
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if ["y", "n"].include?(answer)
      puts "Sorry, must be 'y' or 'n'"
    end
    answer == "y"
  end
  
  def play_another_match?
    answer = nil
    loop do
      puts "Would you like to play another match? (y/n)"
      answer = gets.chomp.downcase
      break if ["y", "n"].include?(answer)
      puts "Sorry, must be 'y' or 'n'"
    end
    answer == "y"
  end

  def clear
    system "clear"
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts
  end
end

game = TTTGame.new
game.play

require "pry"
class Board
  INITIAL_MARKER  = " "
  
  def initialize
    reset
  end
  
  def reset
    @squares = [[INITIAL_MARKER,INITIAL_MARKER,INITIAL_MARKER],
                [INITIAL_MARKER,INITIAL_MARKER,INITIAL_MARKER],
                [INITIAL_MARKER,INITIAL_MARKER,INITIAL_MARKER]]
  end
  
  def display_board
    puts
    squares.each_with_index do |row,i|
      puts "     |     |     "
      puts "  #{row[0]}  |  #{row[1]}  |  #{row[2]}  "
      puts "     |     |     "
      break if i == 2
      puts "-----------------"
    end
    puts
  end
  
  def available_moves
    moves_marked_with(INITIAL_MARKER)
  end
  
  def moves_marked_with(marker)
    array = []
    squares.each_with_index do |row,i|
      row.each_with_index do |square,j|
        # binding.pry
        array << [i,j] if square == marker
      end
    end
    array
  end
  
  def place_marker(move, marker)
    row, column = move
    squares[row][column] = marker
  end
  
  def won?(marker)
    won = false
    squares.each do |row|
      won = true if row.all? {|square| square = marker}
    end
    won
  end
  
  private
  
  attr_accessor :squares
end

class Game
  def initialize
    board = Board
  end
end

board = Board.new()
board.display_board
board.place_marker([1,1], "x")
board.display_board
p board.available_moves
p board.moves_marked_with("x")
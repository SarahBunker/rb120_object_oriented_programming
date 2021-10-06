# class Game
#   def play
#     p "Start the game!"
#   end
# end

# class Bingo
#   include Game
#   def rules_of_play
#     #rules of play
#     p "rules of play"
#   end
# end

# new_bingo = Bingo.new
# new_bingo.rules_of_play
# new_bingo.play

class Cat
  def initialize(type)
    @type = type
  end
  
  def to_s
    "I am a #{@type}."
  end
end

puts Cat
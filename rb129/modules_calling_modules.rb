

module Noise
  
  def squak
    "squak"
  end
end

module Flight
  puts "#{self} meee"
  @@var = self
  
  include Noise
  
  # puts squak
  
  def fly
    "I can fly. #{squak}"
  end
  
  def fly_faster
    fly
  end
end

class Bird
  include Flight
  
  def self.var
    @@var
  end
end

puts Bird.new.fly_faster

# puts Bird.ancestors
puts Bird.var
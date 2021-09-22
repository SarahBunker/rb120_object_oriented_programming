
module Walkable
  def walk
    puts "Let's go for a walk"
  end
end

class Cat
  attr_accessor :name
  def initialize(name)
    @name = name
  end
  
  def greet
    puts "Hello! My name is #{name}!"
  end
  
  include Walkable
end


kitty = Cat.new("Sophie")
kitty.greet
kitty.name = "Luna"
kitty.greet
kitty.walk
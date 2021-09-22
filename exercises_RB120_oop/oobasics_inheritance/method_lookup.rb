# class Animal
#   attr_reader :color

#   def initialize(color)
#     @color = color
#   end
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new('Black')
# cat1.color

# #Cat,Animal

# class Animal
# end

# class Cat < Animal
# end

# class Bird < Animal
# end

# cat1 = Cat.new
# cat1.color

# #Cat, Animal, Object, Kernal, Basic Object

module Flyable
  def fly
    "I'm flying!"
  end
end

class Animal
  attr_reader :color

  def initialize(color)
    @color = color
  end
end

class Cat < Animal
end

class Bird < Animal
  include Flyable
end

bird1 = Bird.new('Red')
bird1.color

#Bird, Flyable, Animal
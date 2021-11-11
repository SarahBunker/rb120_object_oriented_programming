# 1  What is a fake operator and show an example?


# 2  List all of the real operators.


# 3  Which of the following conditional expressions can you use to determine whether str1 and str2 point to the same object?

str1 = "I'm a string"
str2 = str1

p str1 == str2
p str1.equal?(str2)
p str1.eql?(str2)
p str1.object_id == str2.object_id

# 4 Which of the following expressions are guaranteed to return true given the results shown below? Assume str1 and str2 are objects of the String class.

# > str1 = "I am a string"
# > str2 = "I am a string"
# > p str1
# "I am a string"
# > p str2
# "I am a string"

p str1 == str2
p str1.equal?(str2)
p str1 === str2
p (str1 <=> str2) == 0

# 5 Which of these code snippets will return true? Select all that apply.

class Thing
  attr_accessor :size

  def initialize(s)
    @size = s
  end

  def ==(other_thing)
    size == other_thing.size
  end
end

thing1 = Thing.new(5)
thing2 = Thing.new(5)
thing3 = thing1
thing1.size = 4

p thing1 == thing2
p thing2 == thing3
p thing3.equal? thing2
p thing3.equal? thing1

# 6 Which statements will return true?

class Circle
  attr_reader :radius

  def initialize(r)
    @radius = r
  end

  def >(other)
    radius > other.radius
  end

  def ==(other)
    radius == other.radius
  end
end

circle1 = Circle.new(5)
circle2 = Circle.new(3)
circle3 = Circle.new(5)

p circle1 > circle2
p circle2 < circle3
p circle1 == circle3
p circle3 != circle2

# 7 What method(s) does this case statement use to determine which when clause is executed? 

number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end


# 8  Which variables in the Person class are scope at the object level?

class Person
  TITLES = ['Mr', 'Mrs', 'Ms', 'Dr']

  @@total_people = 0

  def initialize(name)
    @name = name
  end

  def age
    @age
  end
end

# 9  What instance variables are initialized when the `grey` object is intialized?

module Speedy
  def run_fast
    @speed = 70
  end
end

class Animal
  def initialize(name, age)
    @name = name
    @age = age
  end
end

class Dog < Animal
  DOG_YEARS = 7

  def initialize(name, age)
    @dog_age = age * DOG_YEARS
  end
end

class Greyhound < Dog
  include Speedy
end

grey = Greyhound.new('Grey', 3)

# 10  What value(s) does Triangle.sides and Triangle.new.sides return? and Why?

class Shape
  @@sides = nil

  def self.sides
    @@sides
  end

  def sides
    @@sides
  end
end

class Triangle < Shape
  def initialize
    @@sides = 3
  end
end

class Quadrilateral < Shape
  def initialize
    @@sides = 4
  end
end
# 11  Fix the code so that it has the desired output.

module Describable
  def describe_shape
    "I am a #{self.class} and have #{SIDES} sides."
  end
end

class Shape
  include Describable

  def self.sides
    SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

Square.sides # => 4
Square.new.sides # => 4
Square.new.describe_shape # => "I am a Square and have 4 sides."
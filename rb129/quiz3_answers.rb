# 1  What is a fake operator and show an example?

# Fake operators are operators that look like operators but are actually methods from a class. An example of a fake operator is `==` which comes from the `BasicObject` class and compares if two objects are the object. Because fake operators are methods they can be overiden to provide different utility to the class. For example:

class Dog
  attr_reader :age
  def initialize(age)
    @age = age
  end
  
  def >(other_dog)
    age > other_dog.age
  end
end

dog1 = Dog.new(1)
dog2 = Dog.new(2)

p dog1 > dog2


# 2  List all of the real operators.

# The real operators that are not methods and can't be overiden are: . , => :: && || .. ... ? : =  *=, += (

# 3  Which of the following conditional expressions can you use to determine whether str1 and str2 point to the same object?

str1 = "I'm a string"
str2 = str1

p str1 == str2 #true (default compares if same object, string class overided to compare if same value)
p str1.equal?(str2) #true compares if same object
p str1.eql?(str2) # true compares if same value and class
p str1.object_id == str2.object_id #true  compares if same object

# str1.equal?(str2), str1.object_id == str2.object_id compare if same object

# 4 Which of the following expressions are guaranteed to return true given the results shown below? Assume str1 and str2 are objects of the String class.

> str1 = "I am a string"
> str2 = "I am a string"
> p str1
"I am a string"
> p str2
"I am a string"

str1 == str2 # true
str1.equal?(str2) #false
str1 === str2 #true (both objects from the string class)
(str1 <=> str2) == 0 #true

# 5 Which of these code snippets will return true? Select all that apply.

  attr_accessor :size

  def initialize(s)
    @size = s
  end

  def ==(other_thing)
    size == other_thing.size
  end
end

thing1 = Thing.new(5) 
thing2 = Thing.new(5) #thing2.size = 5
thing3 = thing1       #thing3.size = 4  #thing1 same object as thing3
thing1.size = 4       #thing1.size = 4

p thing1 == thing2 #false
p thing2 == thing3 #false
p thing3.equal? thing2 #false
p thing3.equal? thing1 #true

# thing3.equal? thing1 returns true

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

# circle1: r is 5
# circle2: r is 3
# circle3: r is 5
# all different objects
# == and > all compare based on radius

p circle1 > circle2 # true
p circle2 < circle3 # error
p circle1 == circle3 # true
p circle3 != circle2 # true

#  Although the radius of `circle2` is less then the radius of `circle3` the method `<` is not defined so this returns an error


# 7 What method(s) does this case statement use to determine which when clause is executed? 

number = 42

case number
when 1          then 'first'
when 10, 20, 30 then 'second'
when 40..49     then 'third'
end

#  Case Statments use `===` implicitly when determining which clause is executed.

# 8  Which variables in the Person class are scoped at the object level?

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

# The variables `@age`, `@name` are scoped at the object level. `TITLES` has a lexical scope and @@total_people has a class scope.

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

# The instance variables `dog_age` and `speed` are initialized when the object `grey` is initalized from the `Dog` class. `name` is not initialized because the `intialize` method in the `Animal` class is overidden by the `initialize method in the `Dog` class which `Greyhound` inherits from.


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

# The call `Triangle.sides` could return `nil`, `3`, or `4` depending on whether an `Triangle` or `Quadrilateral objects were initalized before calling the class method. `Triangle.new.sides` will always return 3. This code uses a class variable which is accessible from all instances of the class or subclass. Since the various `initialize` methods all change the value of this variable its return value is inconsitent and can't be trusted.
# 11  Fix the code so that it has the desired output.

module Describable
  def describe_shape
    "I am a #{self.class} and have #{self.class::SIDES} sides." #changed `SIDES` to `self.class::SIDES`
  end
end

class Shape
  include Describable

  def self.sides
    self::SIDES #changed ffrom `SIDES` to `self::SIDES`
  end
  
  def sides #added instance metheod similar to class method, but where `self` refers to the instance
    self.class::SIDES
  end
end

class Quadrilateral < Shape
  SIDES = 4
end

class Square < Quadrilateral; end

p Square.sides # => 4
p Square.new.sides # => 4
p Square.new.describe_shape # => "I am a Square and have 4 sides."

# This code had three errors. within the module we needed to add a class with a namespacing operator in front of the Constant to distinguish where besides the module the constant could be found. We also needed to add a similar set of code to the class method `sides` because within the `Shape` class there is no SIDE constant. Finally we also needed to add an instance method to access the SIDES constant because line `229` was calling an instance method.
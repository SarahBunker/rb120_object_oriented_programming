#1 Which problems led to the creation of OOP?


#2 what is the relationship between classes and objects?


#3 What are modules in Ruby?


#4 What is encapsulation?


#5 What is inheritance?


#6 What is polymorphism?


#7 What are the benefits of class inheritance?


#8 In the code below describe in relation to ==,
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new


#9  Examine the code below. Identify all the superclasses.

class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end

#10 Given the following code, select the method lookup path that Ruby will use as a result of the call to the fly method?

module Flight
  def fly; end
end

module Aquatic
  def swim; end
end

module Migratory
  def migrate; end
end

class Animal
end

class Bird < Animal
end

class Penguin < Bird
  include Aquatic
  include Migratory
end

pingu = Penguin.new
pingu.fly

#11 What will the following code output?

class Animal
  def initialize(name)
    @name = name
  end

  def speak
    puts sound
  end

  def sound
    "#{@name} says "
  end
end

class Cow < Animal
  def sound
    super + "moooooooooooo!"
  end
end

daisy = Cow.new("Daisy")
daisy.speak

#12 What is true about `max` and `molly`?

class Cat
  def initialize(name, coloring)
    @name = name
    @coloring = coloring
  end

  def purr; end

  def jump; end

  def sleep; end

  def eat; end
end

max = Cat.new("Max", "tabby")
molly = Cat.new("Molly", "gray")



# 13  What are @name and @age in the above code?

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

# 14  what are ways to code Person class to get the desired result?

kate = Person.new
kate.name = 'Kate'
kate.name # => 'Kate'

# 15 what code can replace omitted code and get the desired result?

class Person
  attr_writer :first_name, :last_name

  def full_name
    # omitted code
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
mike.full_name # => 'Michael Garcia'

# 16 What code can you add to Student class to get the desired result?

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
priya.grade # => "A"


# 17 On which lines in the following code does self refer to the instance of the MeMyselfAndI class referenced by i rather than the class itself?

class MeMyselfAndI
  self

  def self.me
    self
  end

  def myself
    self
  end
end

i = MeMyselfAndI.new

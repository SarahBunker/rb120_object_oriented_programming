#1 Which problems led to the creation of OOP?
# OOP was created to help solve the problem of large code that was interrealted and hard to maintain. It also allowed for more abstraction, where you could think about a collection of related methods by a name.

#2 what is the relationship between classes and objects?

# Objects are instantiated from classes. The class provides a model for the object defining methods avaible to the object. The object stores the state in instance variables.

#3 What are modules in Ruby?

# Modules are a collection of methods that we use in classes through mixins using the `include` method. Modules are also used for namespacing which is where similar classes are stored in the same module which makes it easier to identify related code. Here is an example of using a module for mixins.

module Packable
  def pack
    puts "the #{self.class} is packed"
  end
end

class Guitar
  include Packable
end

class Piano
end

class Shirt
  include Packable
end

shirt = Shirt.new
shirt.pack

# Here the module `Packable` is included in the `Guitar` and `Shirt` class, but not the `Piano` class because a `Piano` would be to large to pack.

#4 What is encapsulation?

# Encapsulation is restricting or limiting access to data and methods. Ruby does this by creating objects and exposing interfaces through method to them. If a state is created or method is defined but there is no public access then that is encapsulated in the object. For example:

class Guitar
  def initialize(name)
    @name = name
  end
end

bass = Guitar.new("bass")

# The object bass has a name, but there is no method to access it, so it is encapsulated.

#5 What is inheritance?

# Inheritance is a class getting methods from another class or module. This is done in Ruby through class or interface inheritance. When a class inherits from a parent class this is class inheritance and is best for "is-a" relationships. This is implemented by using `<` followed by the parent class. When a class inherits from a module this is interface inheritance and is implemented using the keyword `include`. This is an example of inheritance.
class Instrument
  def play
    puts @sound
  end
end

class Guitar < Instrument
  def initialize(name)
    @name = name
    @sound = "strum"
  end
end

bass = Guitar.new("bass")
bass.play
# The method `play` is inherited from the superclass `Instrument`.

#6 What is polymorphism?

# Polymorphism is when different data types respond to the same method invocation. An example of this is:

arr = ["123", [1,2,3], {1 => 23}]
arr.each {|item| puts item.empty?}
# This code outputs `false` for each iteration because every item is an object that has the method `empty?` defined and returns false if the string has characters, the array has elements, or the hash has key value pair(S). The implementation for each of these methods is different but we are able to use the same method invocation without needed to know which of the data types it is. The benefit is that code is more reusable and maintainable.

#7 What are the benefits of class inheritance?

# The benefit of class inheritance is that code is repeated less. We can create a general model and fine tune it for subclasses. For example.
class Human
  def speak
    puts @words
  end
end

class Student < Human
  def initialize
    @words = "sup"
  end
end

class Teacher < Human
  def initialize
    @words = "Hello Class"
  end
end

joe = Student.new
joe.speak

friz = Teacher.new
friz.speak
# `joe` and `friz` are both `Human`s that can speak, but this method is fine tuned for each of the subclasses.

#8 In the code below describe in relation to ==,
class Cat
end

whiskers = Cat.new
ginger = Cat.new
paws = Cat.new

# == is a method from the `BasicObject` class that compares if two objects are the same object. This method is often overiden to provide more appropriate comparison of two objects.


#9  Examine the code below. Identify all the superclasses.

class Thing
end

class AnotherThing < Thing
end

class SomethingElse < AnotherThing
end

# A superclass is a class that has at least one subclass. `Thing` has `AnotherThing` as a subclass which has `SomethingElse` as a subclass so `Thing` and `AnotherThing` are both superclasses.

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

# [Penguin, Migratory, Aquatic, Bird, Animal, Object, Kernel, BasicObject]

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

# This code outputs "Daisy says moooooooo!" because the cow class inherits from the Animal class which has the method `#speak`. This method calls the method `sound` which is found in the `Cow` class which calls the method super which looks for the method with the same name starting at the superclass in the method lookup path. The combination of these outputs "Daisy says moooooooooooo!" where `Daisy` was an interpolated instance variable.

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

# `max` and `molly` are both instances from the `Cat` class. `max` has an instance variable `name` with value "Max". He also has an instance variable with value "tabby". `molly` has `name` of "Molly" and `colloring` "gray". Both cats can `purr`, `jump`, `sleep`, and `eat. 

# 13  What are @name and @age in the following code?

class Person
  def initialize(name, age)
    @name = name
    @age = age
  end
end

# `@name` and `@age` are instance variables of the `Person` class.

# 14  what are ways to code Person class to get the desired result?

# class Person
#   attr_reader :name
#   attr_writer :name
# end

# class Person
#   attr_accessor :name
# end

class Person
  def name=(name)
    @name = name
  end
  
  def name
    @name
  end
end


kate = Person.new
kate.name = 'Kate'
kate.name # => 'Kate'

# To access and set an instance varaibles we need to create a getter and setter. The method `attr_accessor` creates both for a variable passed in as a symbol. You can also create them separatly. `attr_reader` only creates the getter method. `attr_writer` only creates the setter method. Or you could code them explicitly. Using attr_* allows you to reduce repeated code by using this shortcut.

# 15 what code can replace omitted code and get the desired result?

class Person
  attr_writer :first_name, :last_name

  def full_name
    # "#{@first_name} #{@last_name}"
    @first_name + " " + @last_name
    # @first_name << " " << @last_name
    # [@first_name, @last_name].join(" ")
  end
end

mike = Person.new
mike.first_name = 'Michael'
mike.last_name = 'Garcia'
p mike.full_name # => 'Michael Garcia'

# In each of these examples we are accessing the instance variables directly without using a getter method. This is not advised because it makes updating how a variable is displayed much harder.

# 16 What code can you add to Student class to get the desired result?

class Student
  attr_accessor :name, :grade

  def initialize(name)
    @name = name
    @grade = nil
  end
  
  def change_grade(new_grade)
    self.grade = new_grade
  end
end

priya = Student.new("Priya")
priya.change_grade('A')
p priya.grade # => "A"

# To fix this code we needed to add the instance method `change_grade`. This method uses the setter method for `grade` to change the instance variable to the new value.


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

# Within a class `self` refers to the instance within instance methods. Everywhere else it refers to the class. So on lines `291, 293 and 294 it is referencing the class `MeMyselfAndI`. However on line `298` it is referencing the instance `i`.
# 1 Examine the code and make the needed changes to return the desired statements
class Cat
  @@total_cats = 0

  attr_reader :name #new
  def initialize(name)
    @name = name
    @@total_cats += 1 #new
  end

  def jump
    "#{name} is jumping!"
  end

  def self.total_cats
    @@total_cats
  end
  
  def to_s #new
    name
  end
end

mitzi = Cat.new('Mitzi')
p mitzi.jump # => "Mitzi is jumping!"
p Cat.total_cats # => 1
p "The cat's name is #{mitzi}" # => "The cat's name is Mitzi"

# To get the require output on line `25` we are calling the method `#jump` which calls the getter method `#name`, so we need to add a getter method. We do this using `attr_reader` on line `5`. Line `26` would output `0` if we didn't add line `8` which increments the class variable `@@total_cats`. Line `27` uses interpolation which automatically calls the `to_s` method. We can overide this method to output `@name` using the getter method.

# 2  Examine the Code and add code so the student object's state matches the shown state
class Student
  def initialize(name)
    @name = name
    @grade = nil
  end
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">

# In this example we are adding an intialize method which initializes the instance variable `@name` to the value of the `name` variable. We also initialize the instance variable `grade` to `nil`.

# 3 We now want to add some attr_* methods to our Student class so that we can access and update the state of a Student object. Examine the following Ruby code, add appropriate code to define getters and setters to make examples run as expected.

class Student
  attr_accessor :name, :grade
  def initialize(name, age)
    @name = name
    @age = age
    @grade = nil
  end
  
  
end

jon = Student.new('John', 22)
p jon.name # => 'John'
jon.name = 'Jon'
jon.grade = 'B'
p jon.grade # => 'B'

# Lines `58-59` are using getters and setters for the instance variable `@name`. We can create both by using the `attr_accessor` method. We do the same for `@grade` so that they can be used on lines `60-61`.

# 4 Fix the code so that the last two statements return the expected values

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{name} is speaking."
  end
end

class Knight < Character
  def name
    "Sir " + super
  end
end

sir_gallant = Knight.new("Gallant")
p sir_gallant.name # => "Sir Gallant"
p sir_gallant.speak # => "Sir Gallant is speaking."

# The problem is that on line `75` the code was using the instance variable directly instead of using the getter method defined on lines `80-82` which provides a cusom concocatination of `"Sir"` with the basic getter method provided in the super class. We fixed this by changing `@name` to `name`.


# 5 Let's add a Thief class as a subclass of Character. You must make some changes to the code so that the last two statements return the values shown in the comments. What changes do you need to make?

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Thief < Character
  def speak
    "#{name} is whispering"
  end
end

sneak = Thief.new("Sneak")
p sneak.name # => "Sneak"
p sneak.speak # => "Sneak is whispering..."

# The error in this code was the `#speak` method in `Character` class said speaking instead of whispering. We can fix this by overiding this method. We defined a method in the `Theif` class that overode the `Character#speak` method.


# 6 Make changes to the code to make the last staments return expected values

class FarmAnimal
  def speak
    "#{self.class} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    super + "baaaaaaa!"
  end
end

class Cow < FarmAnimal
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak # => "Sheep says baa!"
p Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
p Cow.new.speak # => "Cow says mooooooo!"

# In this code we want `FarmAnimal#speak` method to return the class, but `self` in this context returns the instance. We can fix this by using the `#class` method. Cow also needed to inherit from the FarmAnimal class which we did by adding `< FarmAnimal` after the class name. Within the `Lamb#speak` method we expected it to return what the `Sheep#speak` method returns with "baaaaaa!"" concatentated`. We can do this by used `super`.


# 7  What are collaborator objects in Ruby?

# Collaborator objects in Ruby are objects that are stored in the state of another object. This is done by setting an instance variable to another object. They can be objects from a custom class or from the standard and core libraries like a string or array object. Collaborator objects help to model real world applications like a human having a dog for a pet.

def Human
  attr_accessor :pet
end

def Dog
end

sarah = Human.new
sarah.pet = Dog.new

# In this example a `Dog` object is stored as `sarah`'s pet.


# 8  Identify all cusmtom collaborator objects in the example

class Person
  def initialize(name)
    @name = name
  end
end

class Cat
  def initialize(name, owner)
    @name = name
    @owner = owner
  end
end

sara = Person.new("Sara")
fluffy = Cat.new("Fluffy", sara)

# sarah is a custom collaborator object

# 9 What are the differences between classes and modules?

# Classes are used as molds for objects, so objects can be instantiated from classes. Objects can't be instantiated from modules. multiple modules can be included in a class, but a class can only inherit from one other class. 

# 10 create a spike for the following
# A restaurant has a head chef, 3 regular chefs, and a pastry chef. There are also 2 waiters and a MaitreD. The headchef and the MaitreD can supervise. All the chefs can cook. Waiters can speak to the customer and take food orders. The MaitreD can also speak to customers. (from RB 120 Quiz#2 Q10)

module Supervise
  def supervise
  end
end

class RestaurantStaff
end

class Chef < RestaurantStaff
  def cook
  end
end

class HeadChef < Chef
  include Supervise
end

class PastryChef < Chef
end

class FrontStaff < RestaurantStaff
  def speak_to_customer
  end
end

class Waiters < FrontStaff
  def take_food_orders
  end
end

class MaitreD < FrontStaff
  include Supervise
end

# 11- 14 info
# You're designing a Recipe Book application. You've identified some classes that you need:

# RecipeBook
# Recipe
# StarterRecipe
# MainCourseRecipe
# DessertRecipe
# Ingredient
# Each Recipe Book has one or more recipes. Starter recipes, main course recipes, and dessert recipes are all recipe types and share some characteristics but not others. Recipes have one or more ingredients.

# You decide that the application also needs a Conversion module that contains some temperature and measurement conversion methods required by Recipe and Ingredient objects.
# 11 What kind of Object Oriented relationship should exist between RecipeBook and MainCourseRecipe?
# collaborator

# 12 What kind of Object Oriented relationship should exist between Ingredient and Conversion?
# mixin

# 13 What kind of Object Oriented relationship should exist between Recipe and DessertRecipe?
# class inheritance

# 14 What kind of Object Oriented relationship should exist between RecipeBook and Ingredient?
# no relationship

# bonus: create a spike for the Recipe book application

module Conversion
  #temperature conversion method
  #measurement conversion method
end

class RecipeBook
  #includes collaborator recipes
end

class Recipe
  #includes collaborator Ingrediants
end

class StarterRecipe < Recipe
end

class MainCourseRecipe < Recipe
end

class DessertRecipe < Recipe
end

class Ingredient
end
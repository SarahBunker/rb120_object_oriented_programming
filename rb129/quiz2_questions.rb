# 1 Examine the code and make the needed changes to return the desired statements
class Cat
  @@total_cats = 0

  def initialize(name)
    @name = name
  end

  def jump
    "#{name} is jumping!"
  end

  def self.total_cats
    @@total_cats
  end
end

mitzi = Cat.new('Mitzi')
mitzi.jump # => "Mitzi is jumping!"
Cat.total_cats # => 1
p "The cat's name is #{mitzi}" # => "The cat's name is Mitzi"
# 2  Examine the Code and add code so the student object's state matches the shown state
class Student
  # class body
end

ade = Student.new('Adewale')
p ade # => #<Student:0x00000002a88ef8 @grade=nil, @name="Adewale">

# 3 We now want to add some attr_* methods to our Student class so that we can access and update the state of a Student object. Examine the following Ruby code, add appropriate code to define getters and setters to make examples run as expected.

class Student
  # assume that this code includes an appropriate #initialize method
end

jon = Student.new('John', 22)
p jon.name # => 'John'
jon.name = 'Jon'
jon.grade = 'B'
p jon.grade # => 'B'

# 4 Fix the code so that the last two statements return the expected values

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
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


# 5 Let's add a Thief class as a subclass of Character. You must make some changes to the above code so that the last two statements return the values shown in the comments. What changes do you need to make?

class Character
  attr_accessor :name

  def initialize(name)
    @name = name
  end

  def speak
    "#{@name} is speaking."
  end
end

class Thief < Character; end

sneak = Thief.new("Sneak")
sneak.name # => "Sneak"
sneak.speak # => "Sneak is whispering..."


# 6 Make changes to code to make last staments return expected values

class FarmAnimal
  def speak
    "#{self} says "
  end
end

class Sheep < FarmAnimal
  def speak
    super + "baa!"
  end
end

class Lamb < Sheep
  def speak
    "baaaaaaa!"
  end
end

class Cow
  def speak
    super + "mooooooo!"
  end
end

p Sheep.new.speak # => "Sheep says baa!"
p Lamb.new.speak # => "Lamb says baa!baaaaaaa!"
p Cow.new.speak # => "Cow says mooooooo!"


# 7  What are collaborator objects in Ruby?


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

# 9 What are the differences between classes and modules?


# 10 create a spike for the following
# A restaurant has a head chef, 3 regular chefs, and a pastry chef. There are also 2 waiters and a MaitreD. The headchef and the MaitreD can supervise. All the chefs can cook. Waiters can speak to the customer and take food orders. The MaitreD can also speak to customers. (from RB 120 Quiz#2 Q10)

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
# 12 What kind of Object Oriented relationship should exist between Ingredient and Conversion?
# 13 What kind of Object Oriented relationship should exist between Recipe and DessertRecipe?
# 14 What kind of Object Oriented relationship should exist between RecipeBook and Ingredient?

# bonus: create a spike for the Recipe book application

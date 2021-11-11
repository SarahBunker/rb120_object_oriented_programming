# 1 The output of this code is`nil` because the instance variable `@name` was not initialized since the method `set_name` was never called. This  is different then local variables because local variables are only accesible within the scope that they are intialized in.

# 2 the output is 'nil' because although the module `Swimming` is included in the `Dog` class, the method `enable_swimming` was not called which would have set the instance variable `@can_swim` to `true`. This shows that the method that initializes the instance variable must be called in order for the variable to be intialized.

# 3 The output is 4, 4, and an error. The error is because the module `Describable` does not have the constant `SIDES` within its scope. To fix this we can change this to `self.class::SIDES` which uses the namespace operator to tell the code where to find the constant. This demonstrates that constants have a lexical scope and if the constant is not defined within that scope then the code will through an error.

# The first two return 4 for similar reasons. The code uses the method lookup path to find the method. `sides` both as an instance and class method are not found in the classes `Square` or `Quadrilateral`, but they are found in the class `Shape`. In the instance method `self` refers to the instance and uses the `class` method to determine the class of the calling object. In the class method `self` refers to the class. Then both methods use the namespace operator to tell the code where to start the method lookup path for the method.
# The other `self` is in the `describe_shape` method and it refers to the instance.

# 4 This code outputs an array of `Animal` objects. Likely we expected this code to produce a new `AnimalClass` object with the `Animal` objects stored in the `@animal` instance variable. We can adjust the method to create a new `AnimalClass` object with the `Animal` objects stored.

# class AnimalClass
#   attr_accessor :name, :animals
  
#   def initialize(name)
#     @name = name
#     @animals = []
#   end
  
#   def <<(animal)
#     animals << animal
#   end
  
#   def +(other_class)
#     animal_array = animals + other_class.animals
#     temp_class = AnimalClass.new("temp")
#     animal_array.each {|ani| temp_class << ani}
#     temp_class
#   end
  
#   def to_s
#     animals.join(" ")
#   end
# end

# class Animal
#   attr_reader :name
  
#   def initialize(name)
#     @name = name
#   end
  
#   def to_s
#     name
#   end
# end

# mammals = AnimalClass.new('Mammals')
# mammals << Animal.new('Human')
# mammals << Animal.new('Dog')
# mammals << Animal.new('Cat')

# birds = AnimalClass.new('Birds')
# birds << Animal.new('Eagle')
# birds << Animal.new('Blue Jay')
# birds << Animal.new('Penguin')

# some_animal_classes = mammals + birds

# p some_animal_classes 

# # p [4,5,6] + [ 1,2,3,]

# 5 This method doesn't work because on lines 11-13 this code is interpreted as local variables being initialized instead of using the setter method for each of the instance variables. This can be fixed by prepending the variable with the keyword `self` like so:

  def change_info(n, h, w)
    self.name = n
    self.height = h
    self.weight = w
  end

# 6 The reason this returns an error is because on line `9` the code is initializing a local variable. After determing that `name` is a local variable it evaluates the right hand side and `name` hasn't been intialized so it returns `nil` which does not have an `upcase` method. This can be fixed by changing the code like so: `self.name = name.upcase`.

# 7 This code outputs `4` and then a bunch of `2`s. This is because there is only one copy of the class variable `@@wheels`. When the `Motorcycle` class is defined on lines `11-13` it sets `@@wheels` to `2`. This is why in most cases you should avoid class variables with inheritance because changing it for one subclass changes it for all subclasses.

# 8 Line `16` creates an object with two instance variables `@name` and `@color` where both have a value of "brown". This was likely an error that can be fixed by passing `super` the appropriate arguments. 

class Animal
  attr_accessor :name

  def initialize(name)
    @name = name
  end
end

class GoodDog < Animal
  def initialize(color,name)
    super(name)
    @color = color
  end
end

bruno = GoodDog.new("brown","bruno")       
p bruno

#<GoodDog:0x000055c5a3a5d0e8 @name="bruno", @color="brown">

# In this code we changed the `initialize` method to accept a `name` argument and then passed that argument to `initialize` method in the parent class. `super` called without parenthesissarguments (`super`) passes all the arugements passed to the method it is called in and would result in an error.  `super` called with empty parenthesiss would pass no arguments and result in an error.

# 9 This code outputs an error because the call `super` without parenthesises passes all arguments passed to method it is called in (`color`) to the superclass method (`initialize`) which takes no arguments. This can be fixed by adding empty parenthesis (`super()`).

# 10  The method lookup path is the order that classes and methods are looked in to find a method called on an object or class. In this example the method lookup path would be
# [GoodAnimals::GoodDog, Danceable, Swimmable, Animal, Walkable]
#  before the method `walk` is found. One thing shown in this example is that modules are looked at in the reverse order they are listed in. So `Danceable` was looked at before `Swimmable`. A useful method for finding the method lookup path for a class or method is the method `ancestors`.

# 11 The output is "I eat. I eat plankton. I eat kibble". This demonstrates polymorphism which is when different data types can respond to the same method invocation. `Animal`, `Fish` and `Dog` objects are all different data types but can all respond to the same method `eat`.

# 12 This code raises an error because on line `28` we are call the method `jump` on an array of `Pet` objects. The `Array class does not have a method `jump`. This was defined for the objects within the array. `kitty` and `bud` are collaborator objects of the `Person` object meaning they are objects of another class stored as the state of another object.

# 13 The output is "bark! bark!  bark! bark!" because the interpolation of `@name` returns nil. `@name` would have been initialized in the `Animal#initialize` method but this was overiden, seemingly needlesss in the subclass `Dog`. This can be fixed as follows.

class Animal
  def initialize(name)
    @name = name
  end
end

class Dog < Animal
  def dog_name
    "bark! bark! #{@name} bark! bark!"
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name  

# 14 `==` is a method from the `BasicObject` class that compares if two objects are the same object id. If we want this method to compare something else we can overide this method (commonly done). For this example we can overide the `==` method to compare the names of the two objects.

  def ==(other_person)
    name == other_person.name 
  end
  
# within this method we are using the `String#==` method which compares if the two objects have the same value, not if they are the same object. One way to prove this would be to use the method `.equal?` from the `BasicObject` class, but since that could also have been overidden (it wasn't) I will prove it using object ids.
  
p al.name.object_id # => 60
p alex.name.object_id # => 80

# the object id you get when running this code may be different, but they will be different for the two names because they are different objects.

# 15 This code outputs
# Bob
# My name is BOB.
# BOB
#  because `#upcase!` is a mutating caller that changes the value of the instance variable permenantly. The code likely meant to only upcase the name when using the `to_s` method. This can be fixed by using the nonmutating version as follows.

class Person
  attr_reader :name

  def initialize(name)
    @name = name
  end

  def to_s
    "My name is #{name.upcase}."
  end
end

bob = Person.new('Bob')
puts bob.name
puts bob
puts bob.name

# 16 One of the reasons we should use a setter method instead of referencing the instance variable directly from within the class is that we want our code to be scalable so hundreds of lines of code later when we decide that when we are changing that variable we actually need to check if this information is correct first then we only have to change one method instead of hundreds of hardcoded direct references to the instance variable. One small example of this is checking that the new value is of the correct data type and length.

# 17 An example of when we would want to write a custom getter method is showing only the last digits of a credit card number.

# 18
# 19 The attr_accessor method is a shortcut method to create a basic getter and setter method for the variable names passed in as comma seperated symbols. We don't use them for every variable because sometimes we need to create a custom getter and setter method like when we need data validation before changing a variable or we want to display the data differently like when we are displaying the last four of a card number. Also sometimes we don't need both a getter and setter. If we have a `Dog` class and the dog won't be changing names ever then we can set the `name` during initialization and only provide a getter to retrieve the `name` of the dog.

# 20 States are used to store attributes of an object. Behaviors are used to describe the behaviors of an object. In Ruby states are stored in an objects instance variables. Behaviors are defined through class and instance methods.

# 21 Class methods are called on the class itself where an instance object is called on an instance of the class. Instance methods can't be called without an object being first initialized. Within a class method the keyword `self` refers to the class. Whereas in an instance method `self` refers to the instance and cannot be replaced with the name of the instance because it is not within scope. Class methods are defined differently in that the method name is prepended with the keyword `self`. They are used for methods that don't deal with the state of the object.


# 22 Collaborator objects are objects from a different class that are part of the state of another object. They show real world interactions such as a person having a dog for a pet. Both the Person and the Dog could be objects from classes like so:

class Person
  def initialize(pet)
    @pet = pet
  end
end

class Dog
end

rocky = Dog.new
me = Person.new(rocky)

# Now `rocky` is a part of my state as a pet that my `Person` object can interact with. Collaborator objects can be from custom classes such as `rocky`, but they can also be from the standard and core library such as `String`s, `Array`s, `Integer`s... etc.
# 23
# 24
# 25


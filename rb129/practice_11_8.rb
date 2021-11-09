=begin
Why do we use object oriented programming?


############''



=end


=begin
classes are used to group similar methods together. Classes can have behaviors, in Ruby this is through methods. Classes can also have attributes or states. In Ruby this is stored in instance variables for an object or a class variable if it is a state of the class.

Objects are instantiated from classes. From the class they get the methods, or behaviors that the object can do. An object can also have a state which is stored in instance variables.

What are classes and objects? How do you create an object?
Classes are used to group common behaviors. In Ruby this is methods grouped together. An object is instantiated from a class using the class method `::new`. This calls the method `#initialize` if it has been defined. Objects are used to encapsulate states stored in instance variables. For example
=end

# class Dog
#   def initialize(name)
#     @name = name
#   end
# end

# todo = Dog.new("Todo")

=begin
In this example we defined a class `Dog` to group methods related to a dog. We instantiated an object `todo` that has an instance variable `name` with a value of `"Todo"`.
=end

=begin
How is a class defined?

A class is defined similar to a method except it starts with the keyword `class` instead. The class name is also in CamelCase.
=end

=begin
What are the att_* methods and what are they used for?
The attr_* methods are attr_accessor, attr_writer, attr_reader methods and they are shortcut methods for creating getter and setter methods for instance variables in a class. The attr_accessor method creates both a getter and setter method. The attr_writer method only creates a setter method and the attr_reader method only creates a getter method. For example
=end
  
# class Dog
#   attr_accessor :name
#   # attr_reader :name
#   # attr_writer :name
#   def initialize(name)
#     @name = name
#   end
# end

# todo = Dog.new("Todo")
# p todo.name
# todo.name = "Frodo"
# p todo.name

=begin
In this example we used a Dog class and created a getter and setter method for the instance variable `name`. This allows us to print the name on line `39` as well as change the name on line `40`. If we uncommented line `31` and commented line `30` then we would only have a getter method so we wouldn't be able to change the name on line `40`. Likewise uncommenting line `32` and commenting the other lines would only create a setter method so accessing the name variable on lines `39` and `41` would cause an error. 
=end

=begin
What are attr_*?

`attr_*` are methods used as a quick way to create getter and setter methods for an instance variables in a Ruby class. For example:
=end

# class Person
#   attr_accessor :name
#   attr_writer :secret
#   attr_reader :phone_number
#   def initialize(name, phone_number)
#     @name = name
#     @phone_number = phone_number
#   end
# end

# anne = Person.new("Anne", "1-223-786-8899")
# anne.secret = "I like Johnny"
# p anne.name
# p anne.name = "Annie"
# p anne.name
# p anne.phone_number

=begin
The attr_accessor method creates a getter and setter method. The attr_reader only creates a getter method and the attr_writer only creates a setter method. The Attr_* all take instance variables arguments as symbols.
=end

=begin
How do you call a setter and getter method?

Setter and getter methods are typically named with the name of the instance variable. So the setter method for the instance variable name is normally called `name=`. and the getter method is normall called `name`. To avoid setting a local variable instead of using the setter method, they are called with the self keyword when used within the class. `self.name=` would use the setter method for the instance variable `name`. These methods can also be called outside of the class definition on an instance of the class. A `Person` class might have a setter for the name and it could be called on the object `anne` if it is an instance of the Person class as follows. `anne.name = "Annie"`.
=end

=begin
What is an instance method vs a class method? with an example

Instance methods are methods that are called on objects of a class. The object must be instantiated in order to call the method. Class methods are methods that are called on the class without instantiating an object first. Class methods are defined differently by prepending the class name with the keyword `self`. For Example
=end

# class Cat
#   def self.i_am
#     puts "I am a Cat"
#   end
  
#   def i_am
#     puts "I am a Tabby Cat"
#   end
# end

# Cat.i_am
# tabby = Cat.new
# tabby.i_am

=begin
What is method access control

Access control is part of encapsulation where access to data and methods is limited. Method access control is a Ruby term because we limit access by creating and restricting access to methods of a class. `public`, `private`,and `protected` are methods that set the access level of other methods. Methods listed below these methods have different levels of access.

A public method is availble to the rest of the code. Methods by default are public.

A private method is only availble to other methods withign the object.

A protected method is only availble to other methods within the object or other objects from the same class or a subclass.

For example
=end

# class Account
#   include Comparable
  
#   def initialize(amount)
#     @amount = amount
#     @account_num = "0123-4567"
#   end
  
#   def <=>(other_account)
#     amount <=> other_account.amount
#   end
  
#   def show_last_four
#     puts "xxxx-#{account_num[-4,4]}"
#   end
  
#   private
  
#   attr_reader :account_num
  
#   protected
  
#   attr_reader :amount
# end

# check = Account.new(1500)
# save = Account.new(500)
# check.show_last_four
# puts check < save

=begin
This is a great example to show public, private and protected. We use public method to show only part of the account number to the rest of the code. We use a private method within the class to access the account number in the show_last_four method, but it is not avalible to the code outside of the class. When we are comparing if we have more in savings then checking we use a protected method to access the amount in each account and protect that data. But the amount in savings is avaible from with the check object because the amount getter method is protected.
=end

=begin
What is the difference between referencing and setting an instance method directly vs using getter and setter methods?

It is generally prefered to use a getter and setter method for accessing and setting instance variables rather then accessing the variable directly. For example using a getter method to access a variable makes any changes to how the variable is displayed easier because you only have to change the code in one place instead of many. Also using a setter method to change a variable makes data validation easier. For example to change a pin you might require them to provide the old pin first and then you might check that the pin is the correct length and an integer. 
=end

=begin
What is class inheritance?

Class inheritance is used for "is-a" type relationships. For example both a student and a teacher are humans so if we needed a class for students and teachers we could have them inherit common behavior from a human class like so.
=end
# class Human
#   def speak
#     "Hello"
#   end
# end

# class Student
#   def answer
#     "42"
#   end
# end

# class Teacher
#   def grade
#     "A+"
#   end
# end
=begin
In this example both a `Student` and `Teacher` know how to speak but the `Student` also knows how to answer a question and the `Teacher` knows how to grade a paper. The common behavior is inherited from the superclass `Human`.
The class inheritance model also allows for fine tuning a method for each subclass through overiding. Like so.
=end
# class Human
#   def speak
#     "Hello"
#   end
# end

# class Student
#   def speak
#     super + ". I am ready to learn."
#   end
  
#   def answer
#     "42"
#   end
# end

# class Teacher
#   def grade
#     "A+"
#   end
# end
=begin
We added some funtionality to the `#speak` method in the `Student` class.
=end

=begin
Explain what `super` is and how it is used.

`super` is a method that allows us to use a method with the same name as the current method defined earlier in the method lookup path. It can be used as `super`, `super()` or `super(arg1,arg2..). If it is called like `super` then all the arguements passed to the method in which super is called are passed to the method in the super class. Calling super with arguments in `()` allows us to only pass certain arguments to the super method. Calling `super()` passes no arguements to the super method. For example:
=end

# class Human
#   def speak
#     "Hello"
#   end
# end

# class Student < Human
#   def speak(words)
#     super() + words
#   end
  
#   def answer
#     "42"
#   end
# end

# mac = Student.new
# p mac.speak(" I am having a great day")

=begin
In this example the method `speak` defined in the `Human` class takes no arguments so super must be called with no arguments, `super()` on line `234`.
=end

=begin
What is encapsulation?

Encapsulation is rstricting or limiting access to data and methods. In Ruby this is done by creating objects and exposing interfaces through methods to interact with them. For example
=end
# class Fish
#   def initialize(name)
#     @name = name
#   end
# end

# dory = Fish.new("Dory")
# #dory.name
=begin
At this point we can't access the fish's name so we can expose that data by creating a getter method like so.
=end
# class Fish
#   attr_reader :name
#   def initialize(name)
#     @name = name
#   end
# end

# dory = Fish.new("Dory")
# p dory.name

=begin
What is polymorphism? Show an example.

Polymorphism is when different data types can respond to the same method invocation. For example
=end

# arr = [[1,2,3], "123", {1 => 3}]
# arr.each {|i| puts i.empty?}
=begin
The `Array`, `String`, and `Hash` objects all respond to the method `empty?`. There are three types of polymorphism in Ruby: Class inheriatance, Interface Inheritance, and Duck Typing.
=end

=begin
What are Modules? How are modules defined? Give an example of a module.

Modules are used for polymorphism when there is a "has-a" relationship. Sometimes our classes need methods that not all subclasses need so instead we add them using `include` followed by the module name. One of the benifits of modules is that a class can only inherit from one class, but it can include many modules. Here is an example of including a module in a class.
=end
# module Packable
#   def pack
#     puts "packing the #{self.class}"
#   end
# end

# class Guitar
#   include Packable
# end

# class Piano
# end
  
# class Shirt
#   include Packable
# end
  
=begin
The Guitar and Piano could both inherit from an instrument class, but the ability to be packed doesn't come from being an instrument and so we include this method through the module `Packable`.

Methods are also used for namespacing which is where we group similar methods in a module to prevent collisons between similarly named classes. This also helps with knowing the purpose of each class. For example:
=end
# module Sound
#   class Piano
#     #range
#     #pitch
#     #recording
#   end
  
#   class Drums
#   end
  
#   class GlassBreaking
#   end
# end

# module Instrument
#   class Piano
#     # tuning
#     # price
#   end
# end
=begin
namespacing allows us to separate`Sound::Piano` from `Instrument::Piano` which would likely have very different purposes but could be easily confused otherwise.
=end

=begin
What is a module method?

a module method is generally used for out of place methods. It is defined using the keyword `self` and can be called on the module directly. For example
=end

# module Spooky
#   def self.watching
#     puts "I am watching you!"
#   end
# end

# Spooky.watching

=begin
In this example we created a module method `watching` in the `Spooky` module that is then called on the module.
=end

=begin
What is the method lookup path. Provide an example.

The method lookup path is the order Ruby looks in classes and modules for a method starting with the current class. Modules in a method are looked at the the reverse order they are listed and are looked at before looking at super classes of the method. For example":
=end
# module Fishing
# end

# module Hunting
# end

# class Human
# end

# class Man < Human
#   include Fishing
#   include Hunting
# end

# p Man.ancestors
=begin
The ancestors method returns an array of the classes and modules in the method lookup path. In this example the classes and methods are [Man, Human, Fishing, Hunting, Object, Kernel, BasicObject].
=end

=begin
What is self and provide an example?

In a class definition the keyword `self` refers to either the instance of the class or the class itself. If `self` is used in an instance method than it is refering to the instance, otherwise it refers to the class. prepending a method name with `self` makes the method a class method and can be replaced with the class name instead, but is not recommmended because of maintainability. However, when `self` references the instance you cannot replace it with the instance name because within the class the instance is not defined. Here is an example showing the various uses of `self`.
=end

# class Cat
#   puts "I am #{self}"
  
#   def self.stand_for
#     puts "#{self}s stand for more lazy days."
#   end
  
#   def wants
#     puts "This #{self.class} wants more milk too."
#   end
# end

# Cat.stand_for
# taby = Cat.new
# taby.wants

=begin
Outside of the method self is the class. `self` is used to designate that `stand_for` is a class method. within the class method `self` returns the class name. Within `wants` the instance method, `self` returns the instance, and then the method `class` returns the class of the instance.
=end

=begin
Why does the following code return `false` and how can you fix it so that boxes with the same `num` are equal using the `==` operator?
=end

class Box
  def initialize(num)
    @num = num
  end
end

box1 = Box.new(4)
box2 = Box.new(4)

puts box1 == box2

=begin
`==` is inherited from the `BasicObject` class where it is defined to compare if the two objects are the same object, or in other words is the `object_id` the same? On line `419` the two objects are different instances of the same class, so even through they have the same value for the instance variable `num` they are not equal  
=end
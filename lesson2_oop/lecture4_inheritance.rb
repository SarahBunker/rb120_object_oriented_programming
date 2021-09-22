class Pet
  def speak
    'bark!'
  end

  def run
    'running!'
  end

  def jump
    'jumping!'
  end
end

class Dog < Pet
  def swim
    'swimming!'
  end

  def fetch
    'fetching!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

class Cat < Pet
  def speak
    "Meow!"
  end
end

teddy = Dog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"

luna = Cat.new
puts luna.speak
puts luna.run
puts luna.jump

pete = Pet.new
kitty = Cat.new
dave = Dog.new
bud = Bulldog.new

puts pete.run                # => "running!"
puts pete.speak              # => NoMethodError
puts 
puts kitty.run               # => "running!"
puts kitty.speak             # => "meow!"
#puts kitty.fetch             # => NoMethodError
puts 
puts dave.speak              # => "bark!"
puts 
puts bud.run                 # => "running!"
puts bud.swim                # => "can't swim!"
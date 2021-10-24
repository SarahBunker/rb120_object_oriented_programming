class Animal
  attr_reader :name
  def initialize(name)
    @name = name
  end
  
  # def dog_name
  #   "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  # end
end

class Dog < Animal
  # def initialize(name); end
  # def initialize(name)
  #   @name = name
  # end

  def dog_name
    "bark! bark! #{@name} bark! bark!"    # can @name be referenced here?
  end
end

teddy = Dog.new("Teddy")
puts teddy.dog_name                       # => bark! bark! bark! bark!
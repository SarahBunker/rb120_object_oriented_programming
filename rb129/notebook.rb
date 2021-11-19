class GoodDog
  def name(name)
  end
end
p GoodDog.class # => Class

dog = GoodDog.new
p dog.class     # => GoodDog
puts (dog.name("a name"))
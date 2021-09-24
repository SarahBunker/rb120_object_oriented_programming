module Walkable
  def walk
    "#{self} #{gait} forward"
  end
  
  def gait
    gait_style
  end
end

class Person
  include Walkable

  def initialize(name)
    @name = name
    @gait_style = "strolls"
  end

  private
  attr_reader :gait_style
  
  def to_s
    @name
  end
end

class Noble < Person
  attr_reader :name, :title
  def initialize(name, title)
    super(name)
    @title = title
    @gait_style = "struts"
  end
  
  private
  def to_s
    "#{title} #{name}"
  end
end

class Animal
  include Walkable

  def initialize(name)
    @name = name
    @gait_style = "goes"
  end
  
  private
  attr_reader :gait_style
  def to_s
    @name
  end
end

class Cat < Animal
  include Walkable

  def initialize(name)
    super
    @gait_style = "saunters"
  end
end

class Cheetah < Animal
  include Walkable

  def initialize(name)
    super
    @gait_style = "runs"
  end
end

mike = Person.new("Mike")
p mike.walk
# => "Mike strolls forward"

kitty = Cat.new("Kitty")
p kitty.walk
# => "Kitty saunters forward"

flash = Cheetah.new("Flash")
p flash.walk
# => "Flash runs forward"

byron = Noble.new("Byron", "Lord")
p byron.walk
# => "Lord Byron struts forward"

p byron.name
# => "Byron"
p byron.title
# => "Lord"
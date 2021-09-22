# class Person
#   attr_accessor :first_name, :last_name
#   def initialize(name)
#     self.first_name = name.split[0]
#     self.last_name = name.split[-1]
#     if self.first_name == self.last_name
#       self.last_name = ""
#     end
#   end
  
#   def name
#     if last_name == ""
#       @name = self.first_name
#     else
#       @name = "#{self.first_name} #{self.last_name}"
#     end
#   end
# end

class Person
  attr_accessor :first_name, :last_name

  def initialize(name)
    parse_full_name(name)
  end
  
  def name
    @name = "#{first_name} #{last_name}".strip
  end
  
  def name=(name)
    parse_full_name(name)
  end
  
  def parse_full_name(full_name)
    parts = name.split
    @first_name = parts.first
    @last_name = (parts.size > 1 ? parts.last : "")
  end
end

bob = Person.new('Robert')
p bob.name                  # => 'Robert'
p bob.first_name            # => 'Robert'
p bob.last_name             # => ''
bob.last_name = 'Smith'
p bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
p bob.first_name            # => 'John'
p bob.last_name             # => 'Adams'

bob = Person.new('Robert Smith')
rob = Person.new('Robert Smith')

p bob.object_id
p rob.object_id
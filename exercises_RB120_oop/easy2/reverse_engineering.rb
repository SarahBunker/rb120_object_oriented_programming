=begin
problem: Transform from lower to uppercase and vice versa
implement 
a new transform object stores the string
when the instance method #uppercase is called on it, it returns the string uppercase

when the class method lowercase is called on the Transform class it returns the string passed to the class method lowercase
=end
class Transform
  def initialize(string)
    self.string = string
  end
  
  def uppercase
    string.upcase
  end
  
  def self.lowercase(string)
    string.downcase
  end
  
  private; attr_accessor :string
end

my_data = Transform.new('abc')
puts my_data.uppercase
puts Transform.lowercase('XYZ')

# ABC
# xyz
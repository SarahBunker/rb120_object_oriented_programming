class Person
  
  def name=(name)
    split_name(name)
  end
  
  def name
    "#{first_name} #{last_name}"
  end
  
  private
  attr_accessor :first_name, :last_name
  def split_name(name)
    parts = name.split
    self.first_name = parts.first
    self.last_name = parts.last
  end
  
end

person1 = Person.new
person1.name = 'John Doe'
puts person1.name
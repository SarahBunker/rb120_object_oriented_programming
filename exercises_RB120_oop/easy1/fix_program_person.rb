class Person
  def initialize(first_name, last_name)
    self.first_name = first_name
    self.last_name = last_name
  end

  def to_s
    "#{@first_name} #{@last_name}"
  end
  
  def first_name=(fn)
    @first_name = fn.capitalize
  end
  
  def last_name=(ln)
    @last_name = ln.capitalize
  end
end

person = Person.new('john', 'doe')
puts person

person.first_name = 'jane'
person.last_name = 'smith'
puts person

# John Doe
# Jane Smith
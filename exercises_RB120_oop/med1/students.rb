class Student
  def initialize(name, year)
    @name = name
    @year = year
  end
end

class Graduate < Student
  def initialize(name, year, parking)
    super(name,year)
    @parking = parking
  end
end

class Undergraduate < Student
end

peter = Graduate.new("Peter","Senior",true)
sarah = Undergraduate.new("Sarah","Freshman")
p peter
p sarah
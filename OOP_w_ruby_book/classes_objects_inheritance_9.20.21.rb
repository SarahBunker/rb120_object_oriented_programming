# #1
# class Vehicle
#   attr_accessor :color, :speed
#   attr_reader :year, :model
  
#   @@num_of_vehicles = 0
  
#   def self.how_many?
#     "There are now #{@@num_of_vehicles} vehicle(s)"
#   end
  
#   def initialize(y,c,m)
#     @@num_of_vehicles += 1
#     @year  = y
#     @color = c
#     @model = m
#     @speed = 0
#   end
  
#   def speed_up(s_up)
#     self.speed += s_up
#     puts "You pressed on the gas. Now your current speed is #{speed}mph."
#   end
  
#   def brake(s_down)
#     if self.speed - s_down > 0
#       self.speed -= s_down
#     else
#       self.speed = 0
#     end
#     puts "You pressed on the break. Now your current speed is #{speed}mph."
#   end
  
#   def shut_down
#     self.speed = 0
#     puts "You turned of the car. Now your current speed is #{speed}mph."
#   end
  
#   def current_speed
#     puts "The speedometer says you are going #{speed}mph"
#   end
  
#   def spray_paint(new_color)
#     self.color = new_color
#     puts "You took your car to be painted and now it is #{color}"
#   end
  
#   def to_s
#     "This is a #{color}, #{year}, #{model}."
#   end
  
#   def self.gas_mileage(miles,gallon)
#     @@mpg = miles/gallon.to_f
#     puts "The gas mileage is #{@@mpg}mpg."
#   end
# end

# module Mudable
#   def mudding
#     "I am going mudding"
#   end
# end

# CURRENT_YEAR = 2021

# class MyCar < Vehicle
#   attr_accessor :years_owned, :year_bought
  
#   def initialize(y,c,m,year_bought)
#     super(y,c,m)
#     self.year_bought = year_bought
#   end
  
#   def to_s
#     super + " That you bought in #{year_bought} and have owned for #{age} years."
#   end
  
#   #--------------
#   private
    
#   def age
#     current_year = Time.now.year
#     self.years_owned = current_year - year_bought
#   end

# end

# class MyTruck < MyCar
  
#   def self.what_am_i
#     "I am a Truck!"
#   end
#   include Mudable
# end

# truck = MyTruck.new(1993,"green","Chevy", 2018)
# truck.speed_up(15)
# truck.brake(20)
# truck.speed_up(30)
# truck.brake(15)

# truck.spray_paint("blue")
# puts truck
# truck.shut_down()

# puts MyTruck.what_am_i
# puts truck.mudding

# project = MyCar.new(1985,"rust","Volvo", 2019)
# kids_mobile = MyCar.new(2010, "white","Blazer", 2019)
# puts Vehicle.how_many?

# p MyTruck.ancestors
# p MyCar.ancestors
# p Vehicle.ancestors

# p Time.now.year

class Student
  attr_accessor :name
  
  def initialize(name,grade)
    @name = name
    @grade = grade
  end
  
  def better_grade_than?(other_student)
    grade > other_student.grade
  end
  
  protected
  attr_accessor :grade
end

sarah = Student.new("Sarah",90)
collin = Student.new("Collin", 95)

puts sarah.better_grade_than?(collin)

puts "Well done!" if collin.better_grade_than?(sarah)



# lumina = MyCar.new(1997, 'chevy lumina', 'white')
# lumina.speed_up(20)
# lumina.current_speed
# lumina.speed_up(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.brake(20)
# lumina.current_speed
# lumina.shut_down
# lumina.current_speed

# puts "new car"

# truck = MyCar.new(1993,"green","chevy")
# truck.speed_up(15)
# truck.brake(20)
# truck.speed_up(30)
# truck.brake(15)
# truck.shut_down()
# truck.spray_paint("blue")

# class GoodDog
#   attr_accessor :name, :height, :weight, :age
  
#   # @@num_dogs = 0
#   DOG_YEARS = 7
  
#   def initialize(n,a)
#     self.name = n
#     self.age = a * DOG_YEARS
#   end
  
#   # def self.what_am_i
#   #   "I'm a GoodDog class!"
#   # end

#   # def initialize(n, h, w)
#   #   @name = n
#   #   @height = h
#   #   @weight = w
#   # end
  
#   # def initialize
#   #   @@num_dogs += 1
#   # end
  
#   # def self.total_number_of_dogs
#   #   @@num_dogs
#   # end

#   # def speak
#   #   "#{name} says arf!"
#   # end

#   # def change_info(n, h, w)
#   #   self.name = n
#   #   self.height = h
#   #   self.weight = w
#   # end

#   # def info
#   #   "#{self.name} weighs #{self.weight} and is #{self.height} tall."
#   # end
# end

# # p GoodDog.what_am_i

# # puts GoodDog.total_number_of_dogs   # => 0

# # dog1 = GoodDog.new
# # dog2 = GoodDog.new

# # puts GoodDog.total_number_of_dogs   # => 2

# sparky = GoodDog.new("Sparky", 4)
# puts sparky.age             # => 28

class MyCar
  attr_accessor :color, :speed
  #change, view: color,speed
  attr_reader :year, :model
  #view: color of car
  
  def initialize(y,c,m)
    @year  = y
    @color = c
    @model = m
    @speed = 0
  end
  
  def speed_up(s_up)
    self.speed += s_up
    puts "You pressed on the gas. Now your current speed is #{speed}mph."
  end
  
  def brake(s_down)
    if self.speed - s_down > 0
      self.speed -= s_down
    else
      self.speed = 0
    end
    puts "You pressed on the break. Now your current speed is #{speed}mph."
  end
  
  def shut_down
    self.speed = 0
    puts "You turned of the car. Now your current speed is #{speed}mph."
  end
  
  def spray_paint(new_color)
    self.color = new_color
    puts "You took your car to be painted and now it is #{color}"
  end
  
  def current_speed
    puts "The speedometer says you are going #{speed}mph"
  end
  
  def self.gas_mileage(miles,gallon)
    @@mpg = miles/gallon.to_f
    puts "The gas mileage is #{@@mpg}mpg."
  end
  
  def to_s
    "The #{year} #{model} that is #{color} is going #{speed}mph."
  end
  
end

MyCar.gas_mileage(312,16)

truck = MyCar.new(1993,"green","chevy")
truck.speed_up(15)
truck.brake(20)
truck.speed_up(30)
truck.brake(15)

truck.spray_paint("blue")
puts truck
truck.shut_down()

puts 

class Person
  attr_accessor :name
  def initialize(name)
    @name = name
  end
end

bob = Person.new("Steve")
bob.name = "Bob"

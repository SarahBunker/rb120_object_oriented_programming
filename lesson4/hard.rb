###FIX ME Problem 1

# class SecretFile
  
  
#   @@LOG_ENTRIES = []
  
#   def self.LOG_ENTRIES
#     @@LOG_ENTRIES
#   end

#   def initialize(secret_data, log_obj)
#     @data = secret_data
#     @log_obj = log_obj
#   end
  
#   def data
#     @@LOG_ENTRIES << security_log
#     @data
#   end
  
#   private
#   attr_reader :security_log
# end

# class SecurityLogger
#   def create_log_entry
#     # ... implementation omitted ...
#     "Data access on #Date, #Time, by #user."
#   end
# end

# zip = SecretFile.new(12345,SecurityLogger.new)
# p zip.data == 12345
# p SecretFile.LOG_ENTRIES

###Problem 2
# class Vehicle
#   attr_accessor :speed, :heading
#   attr_reader :fuel_efficiency, :fuel_capacity
  
#   def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
#     self.fuel_efficiency = km_traveled_per_liter
#     self.fuel_capacity = liters_of_fuel_capacity
#   end
  
#   def range
#     fuel_capacity * fuel_efficiency
#   end
  
#   private
#   attr_writer :fuel_efficiency, :fuel_capacity
  
# end

# class WheeledVehicle < Vehicle
  
#   attr_reader :tires

#   def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.tires = tire_array
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end

#   def tire_pressure(tire_index)
#     tires[tire_index]
#   end

#   def inflate_tire(tire_index, pressure)
#     tires[tire_index] = pressure
#   end
  
#   private
#   attr_writer :tires

# end

# class Auto < WheeledVehicle
#   def initialize
#     # 4 tires are various tire pressures
#     super([30,30,32,32], 50, 25.0)
#   end
# end

# class Motorcycle < WheeledVehicle
#   def initialize
#     # 2 tires are various tire pressures
#     super([20,20], 80, 8.0)
#   end
# end

# class Catamaran < Vehicle
#   attr_reader :propeller_count, :hull_count

#   def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
#     self.propeller_count = num_propellers
#     self.hull_count = num_hulls
#     super(km_traveled_per_liter, liters_of_fuel_capacity)
#   end
  
#   private
#   attr_writer :propeller_count, :hull_count
  
# end

# puts "car"
# car1 = Auto.new
# p car1.tires                    == [30,30,32,32]
# p car1.tire_pressure(3)         == 32
# p car1.fuel_efficiency          == 50
# p car1.fuel_capacity            == 25.0
# p car1.range                    == 1250.0

# puts "Motorcycle"
# moto = Motorcycle.new
# p moto.tires                    == [20,20]
# p moto.tire_pressure(1)         == 20
# p moto.fuel_efficiency          == 80
# p moto.fuel_capacity            == 8.0
# p moto.range                    == 640.0

# puts "Catamaran"
# cata= Catamaran.new(2,1,70,5.0)
# p cata.propeller_count          == 2
# p cata.hull_count               == 1
# p cata.fuel_efficiency          == 70
# p cata.fuel_capacity            == 5.0
# p cata.range                    == 350.0

##################### Problem 3

class Vehicle
  attr_accessor :speed, :heading
  attr_reader :fuel_efficiency, :fuel_capacity
  
  def initialize(km_traveled_per_liter, liters_of_fuel_capacity)
    self.fuel_efficiency = km_traveled_per_liter
    self.fuel_capacity = liters_of_fuel_capacity
  end
  
  def range
    fuel_capacity * fuel_efficiency
  end
  
  private
  attr_writer :fuel_efficiency, :fuel_capacity
  
end

class WheeledVehicle < Vehicle
  
  attr_reader :tires

  def initialize(tire_array, km_traveled_per_liter, liters_of_fuel_capacity)
    self.tires = tire_array
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end

  def tire_pressure(tire_index)
    tires[tire_index]
  end

  def inflate_tire(tire_index, pressure)
    tires[tire_index] = pressure
  end
  
  private
  attr_writer :tires

end

class Auto < WheeledVehicle
  def initialize
    # 4 tires are various tire pressures
    super([30,30,32,32], 50, 25.0)
  end
end

class Motorcycle < WheeledVehicle
  def initialize
    # 2 tires are various tire pressures
    super([20,20], 80, 8.0)
  end
end

class Motorboat < Vehicle
  def range
    super + 10
  end
end

class Catamaran < Motorboat
  attr_reader :propeller_count, :hull_count

  def initialize(num_propellers, num_hulls, km_traveled_per_liter, liters_of_fuel_capacity)
    self.propeller_count = num_propellers
    self.hull_count = num_hulls
    super(km_traveled_per_liter, liters_of_fuel_capacity)
  end
  
  private
  attr_writer :propeller_count, :hull_count
end

puts "Catamaran"
cata= Catamaran.new(2,1,70,5.0)
p cata.propeller_count          == 2
p cata.hull_count               == 1
p cata.fuel_efficiency          == 70
p cata.fuel_capacity            == 5.0
p cata.range                    == 350.0
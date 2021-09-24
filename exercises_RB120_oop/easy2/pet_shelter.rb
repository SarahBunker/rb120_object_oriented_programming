require "pry"
class Shelter
  def initialize(name)
    @list_adoptions = {}
    @shelter_name = name
  end
  
  def adopt(owner,pet)
    owner.add_pet(pet)
    add_adoption_list(owner,pet)
  end
  
  def print_adoptions
    list_adoptions.each do |owner, pets_adopted|
      puts "#{owner.name} has adopted the following pets at '#{shelter_name}':"
      pets_adopted.each do |pet_object|
        puts pet_object
      end
      puts
    end
  end
  #------------
  private
  attr_reader :list_adoptions, :shelter_name
  
  def add_adoption_list(owner,pet)
    if list_adoptions.key?(owner)
      list_adoptions[owner] << pet
    else
      list_adoptions[owner] = [pet]
    end
  end
  
end

class Pet
  def initialize(type,name)
    @type = type
    @name = name
  end
  
  def to_s
    "a #{type} name #{name}"
  end
  
  private; attr_reader :type, :name
end

class Owner
  attr_reader :name
  def initialize(name)
    @name = name
    @pets = []
  end
  
  def number_of_pets
    pets.size
  end
  
  def add_pet(pet)
    pets << pet
  end
  
  def print_pets
    puts pets
  end
  
  private; attr_reader :pets
end


butterscotch = Pet.new('cat', 'Butterscotch')
pudding      = Pet.new('cat', 'Pudding')
darwin       = Pet.new('bearded dragon', 'Darwin')
kennedy      = Pet.new('dog', 'Kennedy')
sweetie      = Pet.new('parakeet', 'Sweetie Pie')
molly        = Pet.new('dog', 'Molly')
chester      = Pet.new('fish', 'Chester')

phanson = Owner.new('P Hanson')
bholmes = Owner.new('B Holmes')

shelter = Shelter.new("Homes for Pets")
shelter.adopt(phanson, butterscotch)
shelter.adopt(phanson, pudding)
shelter.adopt(phanson, darwin)
shelter.adopt(bholmes, kennedy)
shelter.adopt(bholmes, sweetie)
shelter.adopt(bholmes, molly)
shelter.adopt(bholmes, chester)
shelter.print_adoptions

puts "#{phanson.name} has #{phanson.number_of_pets} adopted pets."
puts "#{bholmes.name} has #{bholmes.number_of_pets} adopted pets."
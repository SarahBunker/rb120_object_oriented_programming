module Flightable
  def fly
    @ability = 'fly'
    def initialize(name)
      @name = name
    end
    def name
      @name
    end
    puts "I am #{name}, I am a #{self.class}, and I can #{ability}!"
  end
end

class Superhero 
  include Flightable
  
  attr_accessor :ability
  
  def self.fight_crime
    puts "I am #{self}!"
    hero = Superhero.new('Superman')
    hero.ability = Ability.new('coding skills ability!').description
    hero.announce_ability

      
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability}"
  end
end

class LSMan < Superhero ; end

class Ability
  attr_reader :description

  def initialize(description)
    @description = description
  end
end

superman = Superhero.new('Superman')
superman.fly # => I am Superman, I am a superhero, and I can fly!
LSMan.fight_crime 
# => I am LSMan!
# => I fight crime with my coding skills ability!
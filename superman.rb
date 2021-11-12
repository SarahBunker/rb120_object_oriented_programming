module Flightable
  def fly
    puts "I am #{@name}, I am a #{self.class.to_s.downcase}, and I can fly!"
  end
end

class Superhero 
  include Flightable
  
  attr_accessor :ability
  
  def self.fight_crime
    puts "I am #{self}!"
    a_hero = Superhero.new("")
    a_hero.ability = Ability.new("coding skills").description
    a_hero.announce_ability
  end
  
  def initialize(name)
    @name = name
  end
  
  def announce_ability
    puts "I fight crime with my #{ability} ability!"
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


# Can only change 2 methods where you see #IMPLEMENTATION . I want you to use the Ability class. superman.fly and LSMan.fight_crime  should produce the commented outputs below them and the words LSMan, Superman, superhero and coding skills should be interpolated.
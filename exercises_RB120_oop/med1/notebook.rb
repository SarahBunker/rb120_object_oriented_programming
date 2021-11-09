module Fishing
end

module Hunting
end

class Human
end

class Man < Human
  include Fishing
  include Hunting
end

p Man.ancestors
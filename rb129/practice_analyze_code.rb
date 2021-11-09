# Why does the following code return `false` and how can you fix it so that boxes with the same `num` are equal using the `==` operator?

class Box
  def initialize(num)
    @num = num
  end
end

box1 = Box.new(4)
box2 = Box.new(4)

puts box1 == box2
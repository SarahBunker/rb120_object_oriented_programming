
#deal with exceptions?

class FixedArray
  attr_reader :length
  attr_accessor :array
  
  def initialize(num)
    @length = num
    @array = Array.new(length)
  end
  
  def [](index)
    array[index]
  end
  
  def []=(index,value)
    array[index] = value
  end
  
  def to_a
    array
  end
  
  def to_s
    temp_array = []
    array.each do |ele|
      if ele == nil
        temp_array << "nil"
      else 
        temp_array << "\"#{ele}\""
      end
    end
    "[#{temp_array.join(", ")}]"
  end
end

fixed_array = FixedArray.new(5)
puts fixed_array[3] == nil
puts fixed_array.to_a == [nil] * 5

fixed_array[3] = 'a'
puts fixed_array[3] == 'a'
puts fixed_array.to_a == [nil, nil, nil, 'a', nil]

fixed_array[1] = 'b'
puts fixed_array[1] == 'b'
puts fixed_array.to_a == [nil, 'b', nil, 'a', nil]

fixed_array[1] = 'c'
puts fixed_array[1] == 'c'
puts fixed_array.to_a == [nil, 'c', nil, 'a', nil]

fixed_array[4] = 'd'
puts fixed_array[4] == 'd'
puts fixed_array.to_a == [nil, 'c', nil, 'a', 'd']
puts fixed_array.to_s == '[nil, "c", nil, "a", "d"]'

puts fixed_array[-1] == 'd'
puts fixed_array[-4] == 'c'

puts

begin
  fixed_array[6]
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[-7] = 3
  puts false
rescue IndexError
  puts true
end

begin
  fixed_array[7] = 3
  puts false
rescue IndexError
  puts true
end
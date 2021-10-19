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

class CircularQueue
  def initialize(size)
    @max_queue = size
    @queue = []
  end
  
  def enqueue(object)
    queue << object
    queue.shift if queue.size > max_queue
  end
  
  def dequeue
    return nil if queue.size == 0
    queue.shift
  end
  
  # def show_queue
  #   queue
  # end
  private
  
  attr_accessor :queue, :max_queue
end

queue = CircularQueue.new(3)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

puts "---------"

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil

puts "---------"

queue = CircularQueue.new(4)
puts queue.dequeue == nil

queue.enqueue(1)
queue.enqueue(2)
puts queue.dequeue == 1

queue.enqueue(3)
queue.enqueue(4)
puts queue.dequeue == 2

puts "---------"

queue.enqueue(5)
queue.enqueue(6)
queue.enqueue(7)
puts queue.dequeue == 4
puts queue.dequeue == 5
puts queue.dequeue == 6
puts queue.dequeue == 7
puts queue.dequeue == nil
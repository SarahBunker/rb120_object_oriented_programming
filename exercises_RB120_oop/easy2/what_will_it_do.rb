class Something
  def initialize
    @data = 'Hello'
  end

  def dupdata
    @data + @data
  end

  def self.dupdata
    'ByeBye'
  end
end

thing = Something.new
#thing is a Something object with value "Hello" stored in the instance variable @data
puts Something.dupdata
#outputs "ByeBye", returns nil
puts thing.dupdata
#outputs "HelloHello", returns nil(because of puts)

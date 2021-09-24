class Banner
  def initialize(message)
    self.message = message
  end
  
  def to_s
    [horizontal_rule, empty_line, message_line, empty_line, horizontal_rule].join("\n")
  end
  
  private
  attr_accessor :message
  
  def message_length
    message.length
  end

  def horizontal_rule
    line = "".center(message_length,"-")
    "+-#{line}-+"
  end

  def empty_line
    line = "".center(message_length," ")
    "| #{line} |"
  end

  def message_line
    "| #{message} |"
  end
  
end

banner = Banner.new('To boldly go where no one has gone before.')
puts banner
# +--------------------------------------------+
# |                                            |
# | To boldly go where no one has gone before. |
# |                                            |
# +--------------------------------------------+

banner = Banner.new('')
puts banner
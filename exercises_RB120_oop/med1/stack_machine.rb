require "pry"
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class MiniLangError < StandardError; end
class BadTokenError  < MiniLangError; end
class EmptyStackError < MiniLangError; end

class Minilang
  ACTIONS = %w(PUSH ADD SUB MULT DIV MOD POP PRINT)
  
  def initialize(commands)
    @commands = commands.split
    @register = 0
    @stack = []
  end
  
  def eval
    begin
      commands.each { |token| eval_token(token) }
    rescue MiniLangError => error
      puts error.message
    end
  end
  
  private
  
  def eval_token(token)
    if ACTIONS.include?(token)
      send(token.downcase)
    elsif token.numeric?
      self.register = token.to_i
    else
      raise BadTokenError.new("Invalid token: #{token}")
    end
  end
  
  # def eval
  #   commands.each do |command|
  #     if VALID_COMMANDS.include?(command.downcase)
  #       begin
  #         self.send command
  #       rescue ValidateStackError => e
  #         puts e
  #         break
  #       end
  #     elsif command.numeric?
  #       self.register = command.to_i
  #     else
  #       begin
  #         validate_command(command)
  #       rescue ValidateCommandError => e
  #         puts e
  #         break
  #       end
  #     end
  #   end
  # end
  
  def print
    puts register
  end
  
  def push
    stack.unshift(register)
  end
  
  def add
    self.register = register + pop
  end
  
  def sub
    self.register = register - pop
  end
  
  def mult
    self.register = register * pop
  end
    
  def div
    self.register = register / pop
  end
  
  def mod
    self.register = register % pop
  end
  
  def pop
    raise EmptyStackError.new("Empty stack!") if stack.empty?
    self.register = stack.pop
  end
  
  attr_accessor :register, :stack, :commands
end


Minilang.new('PRINT').eval
#0

Minilang.new("5 PRINT PUSH ADD PRINT").eval

Minilang.new('5 PUSH 3 MULT PRINT').eval
# # 15

Minilang.new('5 PRINT PUSH 3 PRINT ADD PRINT').eval
# # 5
# # 3
# # 8

Minilang.new('5 PUSH 10 PRINT POP PRINT').eval
# # 10
# # 5

Minilang.new('5 PUSH POP POP PRINT').eval
# Empty stack!

Minilang.new('3 PUSH PUSH 7 DIV MULT PRINT ').eval
# 6

Minilang.new('4 PUSH PUSH 7 MOD MULT PRINT ').eval
# 12

Minilang.new('-3 PUSH 5 XSUB PRINT').eval
# Invalid token: XSUB

Minilang.new('-3 PUSH 5 SUB PRINT').eval
# 8

Minilang.new('6 PUSH').eval
# (nothing printed; no PRINT commands)
require "pry"
class String
  def numeric?
    Float(self) != nil rescue false
  end
end

class ValidateStackError < StandardError; end
class ValidateCommandError < StandardError; end

class Minilang
  VALID_COMMANDS = %w(push add sub mult div mod pop print)
  
  def initialize(commands)
    @commands = commands.split
    @register = 0
    @stack = []
  end
  
  def eval
    commands.each do |command|
      if VALID_COMMANDS.include?(command.downcase)
        begin
          self.send command
        rescue ValidateStackError => e
          puts e
          break
        end
      elsif command.numeric?
        self.register = command.to_i
      else
        begin
          validate_command(command)
        rescue ValidateCommandError => e
          puts e
          break
        end
      end
    end
  end
  
  def PRINT
    puts register
  end
  
  def PUSH
    stack.unshift(register)
  end
  
  def ADD
    validate_stack
    self.register = register + stack.pop
  end
  
  def SUB
    validate_stack
    self.register = register - stack.pop
  end
  
  def MULT
    validate_stack
    self.register = register * stack.pop
  end
    
  def DIV
    validate_stack
    self.register = register / stack.pop
  end
  
  def MOD
    validate_stack
    self.register = register % stack.pop
  end
  
  def POP
    validate_stack
    self.register = stack.pop
  end
  
  def validate_stack
    raise ValidateStackError.new("Empty stack!") if stack.empty?
  end
  
  def validate_command(command)
    raise ValidateCommandError.new("Invalid token: #{command}") if !VALID_COMMANDS.include?(command.downcase)
  end
  
  private
  
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
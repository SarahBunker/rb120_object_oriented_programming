class BasicObject
  # CONSTANT = 'within BasicObject'
end


class Object
 # CONSTANT = 'within top level scope'
end

# CONSTANT = 'within main scope'

class SuperClass
  # CONSTANT = 'within SuperClass'
end

module Included
  CONSTANT = 'within Included'
end



module Top
 # CONSTANT = 'within top module'

  module Encapsulating
    CONSTANT = 'within the Encapsulating module'

      class Main < SuperClass
        include Included

        # CONSTANT = 'within the main class'
        
        def invoke_constant
          CONSTANT
        end
      end
  end
end

# p self

# p Top::Encapsulating::Main.new.invoke_constant # at the object level
p Top::Encapsulating::Main::CONSTANT # at the class level (lexical scope)
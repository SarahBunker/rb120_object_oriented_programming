# 1  What is the public interface of a class

# The public interface of a class are the methods avaible to the rest of the code. General practice is to limit the methods that are availble to reduce dependancies. Codes are by default public but we can change them to `private` or `protected`.

# 2 - 5 Create a spike for the following meal- ordering application
# The application lets a customer place an order for a meal.
# A meal always has three meal items: a burger, a side, and drink.
# For each meal item, the customer must choose an option.
# The application must compute the total cost of the order.
=begin
Use the following code after you have completed the spike to add functionality
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
  
  OPTIONS = {
  '1' => { name: 'Fries', cost: 0.99 },
  '2' => { name: 'Onion Rings', cost: 1.50 }
  }
  
    OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
  
def place_order
  @order = Order.new
end

def initialize
  @burger = Burger.new
  @side = Side.new
  @drink = Drink.new
end

def meal
  [@burger, @side, @drink]
end

def initialize
  @option = choose_option
end

def choose_option
  puts "Please choose a #{self.class} option:"
  puts item_options # item_options returns a list of options and prices
                    # for a particular item type
  gets.chomp
end
=end


# 6 Add this to_s method to the Order class. The method should return a comma-and-space delimited string that contains the names of the selected items. For example:

# my_order.to_s # => "LS Cheeseburger, Fries, Chocolate Shake"

=begin
def to_s
  meal.map(&:to_s).join(', ')
end
=end

# Note that this method calls #to_s for each of the MealItem objects returned by #meal, so we also need a MealItem#to_s method. It should return the name of the meal item; we get this by looking in the object's OPTIONS constant, which is a nested hash. The first key is the @option instance variable, and the second is the :name symbol.

# Write this method for the MealItem Object class.

# 7 Add an Order#total method; it should return a string that contains the total cost of the meal based on the items selected, for example:

# my_order.total # => "$5.49"

class Order
  
  def initialize
    @burger = Burger.new
    @side = Side.new
    @drink = Drink.new
  end
  
  def meal
    [@burger, @side, @drink]
  end
  
  def choose_meal_items
    meal.each do |item|
      item.choose_option
    end
  end
  
  def total
    total_cost = burger.cost + side.cost + drink.cost
    format("$%.2f", total_cost) # #format formats the cost to two decimal places
  end
  
  def to_s
    meal.map(&:to_s).join(', ')
  end
  
  private
  attr_reader :burger, :side, :drink, :meal
  
end

class MealItem
  attr_reader :option
  def initialize
    @option = choose_option
  end
  
  def choose_option
    puts "Please choose a #{self.class} option:"
    puts item_options # item_options returns a list of options and prices
                      # for a particular item type
    gets.chomp
  end
  
  def item_options
    options = self.class::OPTIONS
    options.keys.map do |num|
      puts "#{num} #{options[num][:name]}: #{options[num][:cost]}"
    end
  end
  
  def to_s
    self.class::OPTIONS[option][:name]
  end
  
  def cost
    self.class::OPTIONS[option][:cost]
  end
end

class Burger < MealItem
  OPTIONS = {
    '1' => { name: 'LS Burger', cost: 3.00 },
    '2' => { name: 'LS Cheeseburger', cost: 3.50 },
    '3' => { name: 'LS Chicken Burger', cost: 4.50 },
    '4' => { name: 'LS Double Deluxe Burger', cost: 6.00 }
  }
end

class Side < MealItem
  OPTIONS = {
    '1' => { name: 'Fries', cost: 0.99 },
    '2' => { name: 'Onion Rings', cost: 1.50 }
    }
end

class Drink < MealItem
  OPTIONS = {
    '1' => { name: 'Cola', cost: 1.50 },
    '2' => { name: 'Lemonade', cost: 1.50 },
    '3' => { name: 'Vanilla Shake', cost: 2.00 },
    '4' => { name: 'Chocolate Shake', cost: 2.00 },
    '5' => { name: 'Strawberry Shake', cost: 2.00 }
  }
end

class Customer
  attr_reader :order
  
  def place_order
    @order = Order.new
  end
  
  def cost_meal
    order.total
  end
end

# b = Burger.new
# p b.cost

# u = Order.new
# p u.total

me = Customer.new
me.place_order
puts "The cost of the meal is #{me.cost_meal}"


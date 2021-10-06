# =begin

# The persistence of a number is how many times you have to perform a given operation to an integer before reaching a fixed point at which the operation no longer alters the number.
# https://en.wikipedia.org/wiki/Persistence_of_a_number

# Numberphile does a great video on muliplicative persistence which you can see here https://www.youtube.com/watch?v=Wim9WJeDTHQ

# Problem
# Determine the multiplicative persistence of a given integer where the mutiplicative persistence is the number of times you need to multiply the digits together before reaching a single digit. Assume that the input will always be a positive integer.
# examples:
# 5428 => 5*4*2*8 = 320 => 3*2*0 = 0      #2
# 327 => 42 => 8                          #2

# test cases
# p mult_persistence(8)                 == 0
# p mult_persistence(18)                == 1
# p mult_persistence(5428)              == 2
# p mult_persistence(327)               == 2
# p mult_persistence(467)               == 4
# p mult_persistence(1847)              == 3
# p mult_persistence(277777788888899)   == 11
# =end

# def mult_digits(integer)
#   integer.digits.reduce(:*)
# end

# def mult_persistence(integer)
#   persistence = 0
#   while integer > 9
#     persistence += 1
#     integer = mult_digits(integer)
#   end
#   persistence
# end

# p mult_persistence(8)                 == 0
# p mult_persistence(18)                == 1
# p mult_persistence(5428)              == 2
# p mult_persistence(327)               == 2
# p mult_persistence(467)               == 4
# p mult_persistence(1847)              == 3
# p mult_persistence(277777788888899)   == 11

# =begin
# Return an array of the smallest numbers with persistence between 0 and 8. Assume that all of the numbers will be between 0 and 5_000_000
# https://oeis.org/A003001
# =end

# def num_with_persitence(persistence,min)
#   max = 5_000_000
#   (min..max).each do|num|
#     return num if mult_persistence(num) == persistence
#   end
# end

# def smallest_mult_persistence
#   array_persistence_num = []
#   min = 0
#   (0..8).each do |persistence|
#     array_persistence_num << num_with_persitence(persistence,min)
#     min = array_persistence_num.last + 1
#   end
#   array_persistence_num
# end

# # p num_with_persitence(3,24)

=begin
Prime Numbers

Find the closest prime number to the given multiple of 24


=end

def prime?(num)
  return false if num == 1
  return true if num == 2
  (2..num/2).each do|divisor|
    return false if num%divisor == 0
  end
  true
end

def find_primes(max)
  prime_array = []
  (0..max).each do |num|
    prime_array << num if prime?(num)
  end
  prime_array
end

def prime2(prime)
  prime**2
end

def prime2_closest_to_mult_24(mult_24)
  mult = mult_24/24
  min = (mult == 1 ? 0 : (mult - 1) * 24)  
  max = (mult + 1) * 24
  difference = nil
  (min..max).each do |num|
    p num
  end
end

p prime?(1) == false
p prime?(2) == true
p prime?(7)  == true
p prime?(8) == false
p prime?(11) == true
p prime?(23) == true

p find_primes(100)

# prime2_closest_to_mult_24(24)
# p prime2(5)

=begin
find all the primes between zero and a given number and return them in an array

p find_primes(100) = [2, 3, 5, 7, 11, 13, 17, 19, 23, 29, 31, 37, 41, 43, 47, 53, 59, 61, 67, 71, 73, 79, 83, 89, 97]
=end

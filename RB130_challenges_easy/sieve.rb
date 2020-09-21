# Write a program that uses the Sieve of Eratosthenes to find all the primes
#  from 2 up to a given number.

# The Sieve of Eratosthenes is a simple, ancient algorithm for finding all
# prime numbers up to any given limit. It does so by iteratively marking as
#  composite (i.e. not prime) the multiples of each prime, starting with the
#   multiples of 2.

# Create your range, starting at two and continuing up to and including the
# given limit. (i.e. [2, limit]).

# The algorithm consists of repeating the following over and over:

# take the next available unmarked number in your list (it is prime)
# mark all the multiples of that number (they are not prime)
# Repeat until you have processed each number in your range. When the
# algorithm terminates, all the numbers in the list that have not been
# marked are prime. The wikipedia article has a useful graphic that explains
# the algorithm.

# Notice that this is a very specific algorithm, and the tests don't
# check that you've implemented the algorithm, only that you've come up
# with the correct list of primes.

class Sieve
  def initialize(end_point)
    @array = (2..end_point).to_a
  end

  def primes
    primes = []
    until @array.empty?
      primes << @array.first
      @array.reject! { |number| number % primes.last == 0 }
    end
    primes
  end
end

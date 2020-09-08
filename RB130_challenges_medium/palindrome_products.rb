# Write a program that can detect palindrome products in a given range.

# A palindromic number reads the same both ways. The largest palindrome made 
# from the product of two 2-digit numbers (range 10 ~ 99) is 9009 = 91 x 99.

class Palindromes
  attr_reader :palindromes, :min, :max

  Palindrome = Struct.new(:value, :factors)

  def initialize(max_factor: 0, min_factor: 1)
    @max = max_factor
    @min = min_factor
    @palindromes = Hash.new { |h, k| h[k] = [] }
  end

  def generate
    (min..max).to_a.repeated_combination(2).each do |first, second|
      palindromes[first * second] << [first, second] if palindrome?(first * second)
    end
  end

  def largest
    largest = palindromes.keys.max  
    Palindrome.new(largest, palindromes[largest])
  end

  def smallest
    smallest = palindromes.keys.min
    Palindrome.new(smallest, palindromes[smallest])
  end

  private

  def palindrome?(num)
    num.digits == num.digits.reverse
  end
end

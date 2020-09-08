class PerfectNumber

  def self.classify(int)
    raise StandardError.new, "Has to be greater than 1" unless int > 0 
    sum = PerfectNumber.divisors(int).reduce(:+)
    if sum == int
      'perfect'
    elsif sum > int
      'abundant'
    else
      'deficient'
    end
    
  end

  def self.divisors(number)
    result = []
    1.upto(number - 1) { |num| result << num if number % num == 0 }
    result
  end


end

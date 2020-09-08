class SumOfMultiples
    
  def initialize(mult1 = 3, mult2 = 5, *other_mults)
    @multiples = ([mult1, mult2] + other_mults).sort
  end

  def self.to(end_point)
    temp = SumOfMultiples.new
    temp.to(end_point)
  end

  def to(end_point)
    range_arr = (0...end_point).to_a
    result_array = range_arr.select do |num|
      @multiples.any? { |multiple| num % multiple == 0}
    end
    result_array.reduce(:+)

  end
end

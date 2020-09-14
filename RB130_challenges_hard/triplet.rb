class Triplet
  def initialize(first, second, third)
    @first = first
    @second = second
    @third = third
  end

  def sum
    @first + @second + @third
  end

  def product
    @first * @second * @third
  end

  def pythagorean?
    (@first**2) + (@second**2) == (@third**2)
  end

  def self.where(min_factor: 1, max_factor: 100, sum: nil)
    result = []
    (min_factor..max_factor).to_a.combination(3).each do |a, b, c|
      combo = Triplet.new(a, b, c)
      next unless combo.pythagorean?
      result << combo unless sum && combo.sum != sum
    end
    result
  end
end

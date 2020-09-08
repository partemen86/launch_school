class Prime
  def self.nth(number)
    raise ArgumentError if number < 1 || number.class != Integer
    result = [2]
    current_num = 3
    until result.length >= number do
      result << current_num if prime?(current_num)
      current_num += 2
    end
    result.last
  end

  private

  def self.prime?(i)
    2.upto((i ** 0.5).ceil) { |num| return false if i % num == 0 }
    true
  end
end

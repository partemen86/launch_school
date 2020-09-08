class Octal

  def initialize(num_string)
    @number = num_string
  end

  def to_decimal
    result = 0
    return result if @number.match(/[^0-7]/)
    @number.to_i.digits.each_with_index do |digit, idx|
      result += digit*(8**idx)
    end
    result
  end
end

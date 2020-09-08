
class Series
  attr_reader :digit_str

  def initialize(num_str)
    @digit_str = num_str
  end

  def slices(num)
    raise ArgumentError, 'too big' if num > digit_str.length
    result = []
    index = 0
    loop do 
      break if index + num > @digit_str.length
      result << @digit_str[index...(index + num)].chars.map(&:to_i)
      index += 1
    end
    result
  end

end



# Write a program that will take a string of digits and give you all the
# possible consecutive number series of length n in that string.

# For example, the string "01234" has the following 3-digit series:

# Copy Code
# - 012
# - 123
# - 234
# And the following 4-digit series:

# Copy Code
# - 0123
# - 1234
# And if you ask for a 6-digit series from a 5-digit string,
# you deserve whatever you get.


class Series

  def initialize(num_str)
    @digit_str = num_str
  end

  def slices(num)
    raise ArgumentError, 'too big' if num > @digit_str.length
    result = []
    num.size.times do |index|
      break if index + num > @digit_str.length
      result << @digit_str[index...(index + num)].chars.map(&:to_i)
    end
    result
  end

end



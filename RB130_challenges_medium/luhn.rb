# The Luhn formula is a simple checksum formula used to validate a variety
# of identification numbers, such as credit card numbers and Canadian Social
# Insurance Numbers.

# The formula verifies a number against its included check digit, which is
# usually appended to a partial number to generate the full number. This
# number must pass the following test:

# Counting from rightmost digit (which is the check digit) and moving left,
# double the value of every second digit.
# For any digits that thus become 10 or more, subtract 9 from the result.
# 1111 becomes 2121.
# 8763 becomes 7733 (from 2*6=12 → 12-9=3 and 2*8=16 → 16-9=7).
# Add all these digits together.
# 1111 becomes 2121 sums as 2+1+2+1 to give a checksum of 6.
# 8763 becomes 7733, and 7+7+3+3 is 20.
# If the total (the checksum) ends in 0 (put another way, if the total modulo
# 10 is congruent to 0), then the number is valid according to the Luhn
# formula; else it is not valid. So, 1111 is not valid (as shown above, it
# comes out to 6), while 8763 is valid (as shown above, it comes out to 20).

# Write a program that, given a number

# Can check if it is valid per the Luhn formula. This should treat,
# for example, "2323 2005 7766 3554" as valid.
# Can return the checksum, or the remainder from using the Luhn method.
# Can add a check digit to make the number valid per the Luhn formula and
# return the original number plus that digit. This should give
# "2323 2005 7766 3554" in response to "2323 2005 7766 355".

class Luhn
  def initialize(number)
    @number = number
  end

  def addends
    @number.digits.map.with_index do |digit, index|
      if index.odd?
        digit * 2 > 9 ? digit * 2 - 9 : digit * 2
      else
        digit
      end
    end.reverse
  end

  def checksum
    addends.sum
  end

  def valid?
    checksum % 10 == 0
  end

  def self.create(number)
    new_number = number * 10
    sum = new(new_number).checksum
    sum % 10 == 0 ? new_number : new_number + (10 - sum % 10)
  end
end

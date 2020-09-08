# Write a program that, given a 3 x 4 grid of pipes,

# underscores, and spaces, can determine which number is represented,

# or whether it is garbled.

# Step One

# To begin with, convert a simple binary font to a string containing 

# 0 or 1. The binary font uses pipes and underscores, 

# four rows high and three columns wide.

#  _   #
# | |  # zero.
# |_|  #
#      # the fourth row is always blank
# Is converted to "0"

#    #
# |  # one.
# |  #
#    # (blank fourth row)
# Is converted to "1"

# If the input is the correct size, but not recognizable,

# your program should return '?'. If the input is the incorrect size, 

# your program should return an error.

# Step Two

# Update your program to recognize multi-character binary strings, 

# replacing garbled numbers with ?

# Step Three

# Update your program to recognize all numbers 0 through 9, both 

# individually and as part of a larger string.

#  _
#  _|
# |_

# Is converted to "2"

#   _  _     _  _  _  _  _  _  #
# | _| _||_||_ |_   ||_||_|| | # decimal numbers.
# ||_  _|  | _||_|  ||_| _||_| #
#                              # fourth line is always blank
# Is converted to "1234567890"

# Step Four

# Update your program to handle multiple numbers, one per line. 

# When converting several lines, join the lines with commas.

#     _  _
#   | _| _|
#   ||_  _|

#     _  _
# |_||_ |_
#   | _||_|

#  _  _  _
#   ||_||_|
#   ||_| _|

# Is converted to "123,456,789"

class OCR
  KEY = {
    '1' => ' '
  }

  def initialize(str)
    @str = str
  end

  def convert
    answer = ''
    array = @str.split("\n")
    raise ArgumentError, "wrong size" unless array.size == 3
    num_characters = (array[1].size / 3.0).ceil
    p num_characters
    if array[0] == ''
      return '1'
    end
  end


  
end

text = <<-NUMBER.chomp

| |
| |

    NUMBER

test = OCR.new(text)
test.convert

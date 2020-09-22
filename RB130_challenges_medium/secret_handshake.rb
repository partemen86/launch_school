# Write a program that will take a decimal number, and convert it to the
# appropriate sequence of events for a secret handshake.

# There are 10 types of people in the world: Those who understand binary,
# and those who don't. You and your fellow cohort of those in the "know"
# when it comes to binary decide to come up with a secret "handshake".

# Copy Code
# 1 = wink
# 10 = double blink
# 100 = close your eyes
# 1000 = jump

# 10000 = Reverse the order of the operations in the secret handshake.
# Copy Code
# handshake = SecretHandshake.new 9
# handshake.commands # => ["wink","jump"]

# handshake = SecretHandshake.new "11001"
# handshake.commands # => ["jump","wink"]
# The program should consider strings specifying an invalid binary as the
# value 0.

class SecretHandshake
  COMMANDS = ["wink", "double blink", "close your eyes", "jump"]

  def initialize(num)
    @code = num.class == String ? num.to_i : num.to_s(2).to_i
  end

  def commands
    result = []
    @code.digits[0..3].each_with_index do |digit, index|
      result << COMMANDS[index] if digit == 1
    end
    result.reverse! if @code.digits[4] == 1
    result
  end
end

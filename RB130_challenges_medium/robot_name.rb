# Write a program that manages robot factory settings.

# When robots come off the factory floor, they have no name.
# The first time you boot them up,
# a random name is generated, such as RX837 or BC811.

# Every once in a while we need to reset a robot to its factory settings,
# which means that their name gets wiped. The next time you ask,
# it will respond with a new random name.

# The names must be random: they should not follow a predictable sequence.
# Random names means a risk of collisions. Your solution should not allow
# the use of the same name twice when avoidable.

class Robot
  attr_reader :name
  @@names = []

  LETTERS = ('A'..'Z').to_a
  NUMBERS = (0..9).to_a

  def initialize
    reset
    @@names << @name
  end

  def reset
    loop do
      @name = ''
      2.times { @name << LETTERS.sample }
      3.times { @name << NUMBERS.sample.to_s }
      break unless @@names.include? @name
    end
  end
end

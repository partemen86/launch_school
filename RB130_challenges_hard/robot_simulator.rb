# A robot factory's test facility needs a program to verify robot movements.

# The robots have three possible movements:

# turn right
# turn left
# advance

# Robots are placed on a hypothetical infinite grid,
# facing a particular direction
# (north, east, south, or west) at a set of {x,y} coordinates, e.g., {3,8},
# with coordinates increasing to the north and east.

# The robot then receives a number of instructions, at which point the testing
# facility verifies the robot's new position,
# and in which direction it is pointing.

# The letter-string "RAALAL" means:
# Turn right
# Advance twice
# Turn left
# Advance once
# Turn left yet again
# Say a robot starts at {7, 3} facing north.
# Then running this stream of instructions should leave it at
# {9, 4} facing west.

class Robot
  DIRECTIONS = [:north, :east, :south, :west]

  attr_accessor :bearing, :east, :north

  def orient(dir)
    raise ArgumentError, "Invalid direction" unless DIRECTIONS.include? dir
    self.bearing = dir
  end

  def turn_right
    self.bearing = DIRECTIONS.rotate(1)[DIRECTIONS.index(@bearing)]
  end

  def turn_left
    self.bearing = DIRECTIONS.rotate(-1)[DIRECTIONS.index(@bearing)]
  end

  def advance
    case bearing
    when :north then @north += 1
    when :south then @north -= 1
    when :east then @east += 1
    when :west then @east -= 1
    end
  end

  def at(east, north)
    self.east = east
    self.north = north
  end

  def coordinates
    [east, north]
  end
end

class Simulator
  def instructions(string)
    string.each_char.with_object([]) do |char, result|
      case char
      when "L" then result << :turn_left
      when "R" then result << :turn_right
      when "A" then result << :advance
      end
    end
  end

  def place(robot, x:, y:, direction:)
    robot.orient(direction)
    robot.at(x, y)
  end

  def evaluate(robot, string)
    instructions(string).each { |instruction| robot.send(instruction) }
  end
end

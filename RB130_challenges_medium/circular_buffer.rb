# A circular buffer, cyclic buffer or ring buffer is a data structure that
# uses a single, fixed-size buffer as if it were connected end-to-end.

# A circular buffer first starts empty and of some predefined length.
# For example, this is an empty 7-element buffer:

# Copy Code
# [ ][ ][ ][ ][ ][ ][ ]
# Assume that a 1 is written into the middle of the buffer (exact starting
#  location does not matter in a circular buffer):

# Copy Code
# [ ][ ][ ][1][ ][ ][ ]
# Then assume that two more elements are added, or written to the buffer
# - 2 & 3 - which get appended after the 1:

# Copy Code
# [ ][ ][ ][1][2][3][ ]
# If two elements are then read, or removed from the buffer, the oldest values
# inside the buffer are removed. The two elements removed, in this case, are
# 1 & 2, leaving the buffer with just a 3:

# Copy Code
# [ ][ ][ ][ ][ ][3][ ]
# If the buffer has 7 elements then it is completely full:

# Copy Code
# [6][7][8][9][3][4][5]
# When the buffer is full an error will be raised, alerting the client that
# further writes are blocked until a slot becomes free.

# The client can opt to overwrite the oldest data with a forced write. In this
# case, two more elements - A & B - are added and they overwrite the 3 & 4:

# Copy Code
# [6][7][8][9][A][B][5]
# Finally, if two elements are now removed then what would be returned is not
# 3 & 4 but 5 & 6 because A & B overwrote the 3 & the 4 yielding the
# buffer with:

# Copy Code
# [ ][7][8][9][A][B][ ]

class CircularBuffer
  class BufferEmptyException < StandardError
  end

  class BufferFullException < StandardError
  end

  def initialize(size)
    @buffer = Array.new(size)
    @next = 0
    @last = 0
  end

  def read
    raise BufferEmptyException unless @buffer[@last]
    result = @buffer[@last]
    @buffer[@last] = nil
    @last = increment(@last)
    result
  end

  def write(value)
    raise BufferFullException if @buffer[@next]
    return unless value
    @buffer[@next] = value
    @next = increment(@next)
  end

  def write!(value)
    return unless value
    @last = increment(@last) if @buffer[@next]
    @buffer[@next] = value
    @next = increment(@next)
  end

  def clear
    @buffer = Array.new(@buffer.size)
  end

  private

  def increment(state)
    (state + 1) % @buffer.size
  end
end

class CircularBuffer
  class BufferEmptyException < StandardError
  end
  class BufferFullException < StandardError
  end
  
  def initialize(size)
    @buffer = Array.new(size)
    @current = 0
    @last = 0
  end

  def read
    raise BufferEmptyException if buffer.all?(&:nil?)
    value = buffer[last]
    buffer[last] = nil
    increment_last
    value
  end

  def write(value)
    return if value.nil?
    if buffer[current] == nil
        @buffer[current] = value
        increment_current
    else
      raise BufferFullException
    end

  end

  def write!(value)
    return if value.nil?
    increment_last if buffer[current]
    buffer[current] = value
    increment_current
  end
      
  def clear
    buffer.map! { |_| nil }
  end

  private
    
  attr_accessor :current, :last, :buffer

  def increment_current
    self.current = (current + 1) % buffer.size
  end

  def increment_last
    self.last = (last + 1) % buffer.size
  end

end




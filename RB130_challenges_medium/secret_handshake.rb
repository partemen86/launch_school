class SecretHandshake
  
  def initialize(input)
    @input = input
  end

  def commands
    result = []
    if @input.class == String
      return result unless @input.match(/[\d]/)
      @input = @input.to_i
    end
    binary = @input.to_s(2)
    result << 'wink' if binary[-1] == '1'
    result << 'double blink' if binary[-2] == '1'
    result << 'close your eyes' if binary[-3] == '1'
    result << 'jump' if binary[-4] == '1'
    result.reverse! if binary[-5] == '1'
    result
  end

end


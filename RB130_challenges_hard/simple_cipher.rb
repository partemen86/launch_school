class Cipher
  LETTERS = ('a'..'z').to_a

  attr_reader :key

  def initialize(key = nil)
    @key = key || Array.new(100) { LETTERS.sample }.join
    raise ArgumentError, "Invalid characters" unless valid_key?
  end

  def encode(string)
    process(string)
  end

  def decode(string)
    process(string, true)
  end

  private

  def valid_key?
    @key[/[a-z]+/] == @key
  end

  def process(string, decode = false)
    result = ""
    string.chars.each_with_index do |char, idx|
      shift = decode ? -1 * (key[idx].ord - 97) : key[idx].ord - 97
      result << LETTERS.rotate(shift)[LETTERS.index(char)]
    end
    result
  end
end

# Implement run-length encoding and decoding.

# Run-length encoding (RLE) is a simple form of data compression,
# where runs (consecutive data elements) are replaced by just one data value
# and count.

# For example we can represent the original 53 characters with only 13.

# "WWWWWWWWWWWWBWWWWWWWWWWWWBBBWWWWWWWWWWWWWWWWWWWWWWWWB"  ->  "12WB12W3B24WB"

# RLE allows the original data to be perfectly reconstructed from the compressed
# data, which makes it a lossless data compression.

# "AABCCCDEEEE"  ->  "2AB3CD4E"  ->  "AABCCCDEEEE"

module RunLengthEncoding
  def self.encode(input)
    result = ''
    counter = 1
    char_array = input.chars << ' '
    char_array[1..-1].each_with_index do |char, idx|
      if char == char_array[idx]
        counter += 1
      else
        result << counter.to_s unless counter == 1
        result << char_array[idx]
        counter = 1
      end
    end
    result
  end

  def self.decode(input)
    input.gsub(/\d+\D/) { |match| match[-1] * match[0...-1].to_i }
  end
end

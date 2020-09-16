# Implement encoding and decoding for the rail fence cipher.

# The Rail Fence cipher is a form of transposition cipher that gets its
# name from the way in which it's encoded. It was already used by the
# ancient Greeks.

# In the Rail Fence cipher, the message is written downwards on successive
# "rails" of an imaginary fence, then moving up when we get to the bottom
# (like a zig-zag). Finally the message is then read off in rows.

# For example, using three "rails" and the message "WE ARE DISCOVERED FLEE
# AT ONCE", the cipherer writes out:

# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .
# Then reads off:

# WECRLTEERDSOEEFEAOCAIVDEN
# To decrypt a message you take the zig-zag shape and fill the ciphertext
# along the rows.

# ? . . . ? . . . ? . . . ? . . . ? . . . ? . . . ?
# . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# The first row has seven spots that can be filled with "WECRLTE".

# W . . . E . . . C . . . R . . . L . . . T . . . E
# . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? . ? .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# Now the 2nd row takes "ERDSOEEFEAOC".

# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . ? . . . ? . . . ? . . . ? . . . ? . . . ? . .
# Leaving "AIVDEN" for the last row.

# W . . . E . . . C . . . R . . . L . . . T . . . E
# . E . R . D . S . O . E . E . F . E . A . O . C .
# . . A . . . I . . . V . . . D . . . E . . . N . .
# If you now read along the zig-zag shape you can read the original message.

class RailFenceCipher
  def self.encode(string, rails)
    return string if rails == 1 || rails > string.length
    result = []
    interval = rails * 2 - 2
    middle_rails_padding = 0
    rails.times do |starting_idx|
      result << string.chars.select.with_index do |_, idx|
        (idx - starting_idx) % interval == 0 ||
          (idx - starting_idx + middle_rails_padding) % interval == 0
      end
      middle_rails_padding += 2
    end
    result.join
  end

  def self.decode(string, rails)
    return string if rails == 1
    lines = Array.new(rails) { [] }
    next_line_idx = 0
    idx_increasing = false
    string.length.times do
      lines.each_with_index do |line, line_index|
        line << (line_index == next_line_idx ? '?' : '.')
      end
      if next_line_idx == 0 || next_line_idx == rails - 1
        idx_increasing = !idx_increasing
      end
      idx_increasing ? next_line_idx += 1 : next_line_idx -= 1
    end
    fill_in_lines(lines, string)
  end

  def self.fill_in_lines(lines, string)
    string_chars = string.chars
    lines.each do |line|
      line.length.times do |index|
        line[index] = string_chars.shift if line[index] == '?'
      end
    end
    max_index = lines.max_by(&:length).length
    result = ''
    max_index.times do |index|
      lines.each do |line|
        result << line[index] if line[index] =~ /[A-Z]/
      end
    end
    result
  end
end

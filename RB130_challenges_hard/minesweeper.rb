# Minesweeper is a popular game where the user has to find the mines
# using numeric hints that indicate how many mines are directly adjacent
# (horizontally, vertically, diagonally) to a square.

# In this exercise you have to create some code that counts the number of
# mines adjacent to a square and transforms boards like this
# (where * indicates a mine):

# +-----+
# | * * |
# |  *  |
# |  *  |
# |     |
# +-----+
# into this:

# +-----+
# |1*3*1|
# |13*31|
# | 2*2 |
# | 111 |
# +-----+

class ValueError < StandardError
end

class Board
  def self.transform(input)
    row_size = input[0].size
    board = input[1...-1]
    raise ValueError unless
      valid?(board, row_size) && input[0] == input[-1] && input[0] =~ /\+\-*\+/
    get_answer(input)
  end

  def self.valid?(arr, size)
    arr.all? { |line| line =~ /\|[ \*]*\|/ && line.size == size }
  end

  def self.get_answer(input)
    input.map.with_index do |line, idx1|
      line.chars.map.with_index do |char, idx2|
        if char == ' '
          count = surrounding_mines(input, idx1, idx2)
          count == 0 ? ' ' : count.to_s
        else
          char
        end
      end.join
    end
  end

  def self.surrounding_mines(input, line, column)
    coords = [input[line][column - 1], input[line][column + 1],
              input[line - 1][column - 1], input[line - 1][column + 1],
              input[line - 1][column], input[line + 1][column - 1],
              input[line + 1][column], input[line + 1][column + 1]]
    coords.count('*')
  end
end

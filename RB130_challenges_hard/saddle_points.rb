# Write a program that detects saddle points in a matrix.

# So say you have a matrix like so:

#     0  1  2
#   |---------
# 0 | 9  8  7
# 1 | 5  3  2     <--- saddle point at (1,0)
# 2 | 6  6  7
# It has a saddle point at (1, 0).

# It's called a "saddle point" because it is greater than or equal to
# every element in its row and the less than or equal to every element
# in its column.

# A matrix may have zero or more saddle points.

# Your code should be able to provide the (possibly empty) list of all
# the saddle points for any given matrix.

# Note that you may find other definitions of matrix saddle points online,
# but the tests for this exercise follow the above unambiguous definition.

class Matrix
  attr_reader :matrix

  def initialize(string)
    @matrix = string.split("\n").map { |row| row.split.map(&:to_i) }
  end

  def rows
    @matrix
  end

  def columns
    @matrix.transpose
  end

  def saddle_points
    result = []
    rows.each_with_index do |row, row_num|
      row.each_with_index do |value, col_num|
        next unless value >= rows[row_num].max && value <= columns[col_num].min
        result << [row_num, col_num]
      end
    end
    result
  end
end

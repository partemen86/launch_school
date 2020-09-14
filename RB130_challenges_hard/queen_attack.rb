# In the game of chess, a queen can attack pieces which are
# on the same row, column, or diagonal.

# A chessboard can be represented by an 8 by 8 array.

# So if you're told the white queen is at (2, 3) and the black
# queen at (5, 6), then you'd know you've got a set-up like so:

# _ _ _ _ _ _ _ _
# _ _ _ _ _ _ _ _
# _ _ _ W _ _ _ _
# _ _ _ _ _ _ _ _
# _ _ _ _ _ _ _ _
# _ _ _ _ _ _ B _
# _ _ _ _ _ _ _ _
# _ _ _ _ _ _ _ _

# You'd also be able to answer whether the queens can attack each other.
# In this case, that answer would be yes, they can,
# because both pieces share a diagonal.

class Queens
  LINE = "_ _ _ _ _ _ _ _"
  attr_reader :white, :black

  def initialize(white: [0, 3], black: [7, 3])
    raise ArgumentError if white == black
    @white = white
    @black = black
    @board = initialize_board
  end

  def initialize_board
    board = Array.new(8) { LINE.dup }
    board[white[0]][white[1] * 2] = 'W'
    board[black[0]][black[1] * 2] = 'B'
    board
  end

  def to_s
    @board.join("\n")
  end

  def attack?
    white[0] == black[0] || white[1] == black[1] ||
      (white[0] - black[0]).abs == (white[1] - black[1]).abs
  end
end

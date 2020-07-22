class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]

  def initialize
    @squares = {}
    reset
  end
  # rubocop:disable Metrics/AbcSize
  # rubocop:disable Metrics/MethodLength

  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize
  # rubocop:enable Metrics/MethodLength

  def []=(key, marker)
    @squares[key].marker = marker
  end

  def [](key)
    @squares[key].marker
  end

  def empty?(index)
    @squares[index].unmarked?
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def line_almost_complete(target_marker)
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if squares.collect(&:marker).count(target_marker) == 2
        third_square_arr = line.select do |position|
          @squares[position].marker == Square::INITIAL_MARKER
        end
        return third_square_arr.first unless third_square_arr.empty?
      end
    end
    nil
  end

  def reset
    (1..9).each { |num| @squares[num] = Square.new }
  end

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.uniq.size == 1
  end
end

class Square
  INITIAL_MARKER = ' '
  attr_accessor :marker

  def initialize(marker = INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end
end

class Player
  attr_reader :marker

  def initialize(marker)
    @marker = marker
  end
end

class TTTGame
  HUMAN_MARKER = 'X'
  COMPUTER_MARKER = 'O'
  FIRST_TO_MOVE = HUMAN_MARKER
  NUMBER_OF_WINS = 2
  attr_reader :board, :human, :computer
  attr_accessor :human_score, :computer_score

  def clear
    system 'clear'
  end

  def initialize
    @board = Board.new
    @human = Player.new(HUMAN_MARKER)
    @computer = Player.new(COMPUTER_MARKER)
    @current_marker = FIRST_TO_MOVE
    @human_score = 0
    @computer_score = 0
  end

  def play
    clear
    display_welcome_message
    start_new_game
    display_goodbye_message
  end

  private

  def start_new_game
    loop do
      reset
      reset_scores
      main_game
      display_play_again_message
      break unless play_again?
    end
  end

  def main_game
    loop do
      display_board
      player_move
      update_score
      display_result
      break if human_score >= NUMBER_OF_WINS || computer_score >= NUMBER_OF_WINS
      reset
    end
  end

  def player_move
    loop do
      current_player_moves
      break if board.someone_won? || board.full?
      clear_screen_and_display_board
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = COMPUTER_MARKER
    else
      computer_moves
      @current_marker = HUMAN_MARKER
    end
  end

  def update_score
    if board.winning_marker == human.marker
      self.human_score += 1
    elsif board.winning_marker == computer.marker
      self.computer_score += 1
    end
  end

  def display_round_winner
    if computer_score == NUMBER_OF_WINS
      puts "Computer won this round!"
    elsif human_score == NUMBER_OF_WINS
      puts "You won this round!"
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == HUMAN_MARKER
  end

  def joinor(array, symbol = ', ', word = 'or')
    if array.empty?
      ''
    elsif array.size == 1
      array[0]
    elsif array.size == 2
      array.join(' or ')
    else
      array[0...-1].join(symbol) + symbol + word + " #{array[-1]}"
    end
  end

  def human_moves
    puts "Choose a square (#{joinor(board.unmarked_keys)}): "
    square = ''
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if @board.line_almost_complete(COMPUTER_MARKER)
      board[@board.line_almost_complete(COMPUTER_MARKER)] = computer.marker
    elsif @board.line_almost_complete(HUMAN_MARKER)
      board[@board.line_almost_complete(HUMAN_MARKER)] = computer.marker
    elsif @board.empty?(5)
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def display_result
    clear
    display_board
    case board.winning_marker
    when human.marker
      puts "You won!"
    when computer.marker
      puts "Computer won!"
    else
      puts "The board is full"
    end
    puts "Press enter to continue."
    gets
  end

  def display_board
    puts "You're a #{human.marker}. Computer is a #{computer.marker}."
    puts "You have #{human_score} wins.  Computer has #{computer_score} wins"
    puts ""
    @board.draw
    puts ""
  end

  def play_again?
    answer = ''
    loop do
      puts "Would you like to play again? (y/n)"
      answer = gets.chomp.downcase
      break if %w(y n).include? answer
      puts "Sorry, must be y or n"
    end

    answer == 'y'
  end

  def reset
    board.reset
    @current_marker = FIRST_TO_MOVE
    clear
  end

  def reset_scores
    self.human_score = 0
    self.computer_score = 0
  end

  def display_play_again_message
    display_round_winner
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play

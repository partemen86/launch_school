INITAL_MARKER = ' '
PLAYER_MARKER = 'X'
COMPUTER_MARKER = 'O'
GAME_OPTIONS = 'player'
WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(msg)
  puts "=> #{msg}"
end

def play_again?
  prompt("Play again? (y or n)")
  answer = gets.chomp
  answer.downcase.start_with?('y')
end

def joinor(array, delimiter = ', ', word = 'or')
  case array.size
  when 0 then ''
  when 1 then array[0]
  when 2 then array.join(" #{word} ")
  else
    array[-1] = "#{word} #{array[-1]}"
    array.join(delimiter)
  end
end

# rubocop:disable Metrics/AbcSize
def display_board(brd, player_score, computer_score)
  system 'clear'
  puts "You're a #{PLAYER_MARKER}. Computer is #{COMPUTER_MARKER}"
  puts "Player score: #{player_score}, Computer score: #{computer_score}"
  puts "First to 5 wins is the victor!"
  puts ""
  puts "     |     |"
  puts "  #{brd[1]}  |  #{brd[2]}  |  #{brd[3]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[4]}  |  #{brd[5]}  |  #{brd[6]}"
  puts "     |     |"
  puts "-----+-----+-----"
  puts "     |     |"
  puts "  #{brd[7]}  |  #{brd[8]}  |  #{brd[9]}"
  puts "     |     |"
  puts ""
end
# rubocop:enable Metrics/AbcSize

def initialize_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITAL_MARKER }
  new_board
end

def empty_squares(brd)
  brd.keys.select { |num| brd[num] == INITAL_MARKER }
end

def player_places_piece!(brd)
  square = ''
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd))})"
    square = gets.chomp.to_i
    break if empty_squares(brd).include?(square)
    prompt("Sorry, that is not a valid choice.")
  end

  brd[square] = PLAYER_MARKER
end

def at_risk_square(board, line, marker)
  if board.values_at(*line).count(marker) == 2
    board.select { |key, value| line.include?(key) && value == INITAL_MARKER }.keys.first
  end
end

def place_piece(brd, current_player)
  if current_player == 'player'
    player_places_piece!(brd)
  else
    computer_places_piece!(brd)
  end
end

def alternate_player(current_player)
  if current_player == 'player'
    'computer'
  else
    'player'
  end
end

def computer_places_piece!(brd)
  square = nil
  # offense
  WINNING_LINES.each do |line|
    square = at_risk_square(brd, line, COMPUTER_MARKER)
    break if square
  end

  # defense
  if !square
    WINNING_LINES.each do |line|
      square = at_risk_square(brd, line, PLAYER_MARKER)
      break if square
    end
  end

  # random square
  if !square
    square = if empty_squares(brd).include?(5)
               5
             else
               empty_squares(brd).sample
             end
  end

  brd[square] = COMPUTER_MARKER
end

def board_full?(brd)
  empty_squares(brd).empty?
end

def detect_winner(brd)
  WINNING_LINES.each do |line|
    if brd.values_at(*line).count(PLAYER_MARKER) == 3
      return 'Player'
    elsif brd.values_at(*line).count(COMPUTER_MARKER) == 3
      return 'Computer'
    end
  end
  nil
end

def someone_won?(brd)
  !!detect_winner(brd)
end

loop do
  player_wins = 0
  computer_wins = 0
  first_player = ''

  if GAME_OPTIONS == 'choose'
    loop do
      prompt "Please choose who goes first: (player or computer)"
      first_player = gets.chomp.downcase
      break if first_player == 'player' || first_player == 'computer'
      prompt "That is not a valid choice"
    end
  elsif GAME_OPTIONS == 'computer'
    first_player = 'computer'
  else
    first_player = 'player'
  end

  loop do
    board = initialize_board
    current_player = first_player

    loop do
      display_board(board, player_wins, computer_wins)
      place_piece(board, current_player)
      current_player = alternate_player(current_player)
      break if someone_won?(board) || board_full?(board)
    end
    display_board(board, player_wins, computer_wins)

    if someone_won?(board)
      winner = detect_winner(board)
      if winner == 'Player'
        player_wins += 1
      else
        computer_wins += 1
      end

      prompt("#{winner} won!")
    else
      prompt "It's a tie!"
    end

    prompt("Enter any key to continue")
    gets.chomp

    if player_wins >= 5
      display_board(board, player_wins, computer_wins)
      prompt "You win the game!"
      break
    elsif computer_wins >= 5
      display_board(board, player_wins, computer_wins)
      prompt "Computer wins the game!"
      break
    end
  end
  break unless play_again?
end
prompt "Thanks for playing Tic Tac Toe"

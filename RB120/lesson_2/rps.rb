class Move
  VALUES = {
    'r' => 'rock', 'p' => 'paper', 'sc' => 'scissors',
    'l' => 'lizard', 'sp' => 'spock'
  }
  WINNING_COMBOS = {
    'rock'   => ['scissors', 'lizard'], 'paper'    => ['rock', 'spock'],
    'spock'  => ['rock', 'scissors'],   'scissors' => ['paper', 'lizard'],
    'lizard' => ['spock', 'paper']
  }

  def initialize(value)
    @value = value
  end

  def to_s
    @value
  end

  def >(other_move)
    WINNING_COMBOS[@value].include? other_move.to_s
  end

  def <(other_move)
    WINNING_COMBOS[other_move.to_s].include? @value
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp.capitalize
      break unless n.empty?
      puts "Sorry, must be a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "Please choose (r)ock, (p)aper, (sc)issors, (l)izard, or (sp)ock:"
      choice = gets.chomp
      break if Move::VALUES.keys.include?(choice)
      puts "Sorry, invalid choice"
    end
    self.move = Move.new(Move::VALUES[choice])
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    self.move = Move.new(Move::VALUES.values.sample)
  end
end

class RPSGame
  attr_accessor :human, :computer

  def initialize
    @human = Human.new
    @computer = Computer.new
    @history = []
  end

  def display_welcome_message
    puts "Welcome to Rock, Paper, Scissors!"
  end

  def display_goodbye_message
    puts "Thanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def display_moves
    puts "#{human.name} chose #{human.move}"
    puts "#{computer.name} chose #{computer.move}"
  end

  def display_winner
    if human.move > computer.move
      puts "#{human.name} won"
    elsif computer.move > human.move
      puts "#{computer.name} won!"
    else
      puts "It's a tie!"
    end
  end

  def display_scores
    puts "The score is: "
    puts "#{human.name}: #{human.score} to #{computer.name}: #{computer.score}"
    puts "press enter to continue"
    gets
  end

  def update_scores
    if human.move > computer.move
      human.score += 1
    elsif computer.move > human.move
      computer.score += 1
    end
  end

  def play_again?
    answer = nil
    loop do
      puts "Would you like to play again? y/n"
      answer = gets.chomp
      break if ['y', 'n'].include?(answer.downcase)
      puts "Sorry, must be y or n."
    end

    return false if answer.casecmp? 'n'
    return true if answer.casecmp? 'y'
  end

  def display_final_result
    if computer.score > human.score
      puts "#{computer.name} wins the game!"
    elsif human.score > computer.score
      puts "#{human.name} wins the game!"
    end
  end

  def update_history
    history << [human.move, computer.move]
  end

  def display_history
    puts "Match history: "
    round = 1
    history.each do |move|
      puts "Round #{round} - player move: #{move[0]}, computer move: #{move[1]}"
      round += 1
    end
  end

  def play
    loop do
      display_welcome_message
      loop do
        system("clear")
        human.choose
        computer.choose
        update_history
        display_moves
        update_scores
        display_winner
        display_scores
        break if human.score == 5 || computer.score == 5
      end
      display_final_result
      break unless play_again?
    end
    display_history
    display_goodbye_message
  end

  private

  attr_accessor :history
end

RPSGame.new.play

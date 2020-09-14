# Bowling
# Write a program that can score a bowling game.

# Bowling is game where players roll a heavy ball to knock
# down pins arranged in a triangle. Write code to keep track
# of the score of a game of bowling.

# Scoring Bowling
# The game consists of 10 frames. A frame is composed of one or two ball
#  throws with 10 pins standing at frame initialization. There are three
#   cases for the tabulation of a frame.

# An open frame is where a score of less than 10 is recorded for the frame.
#  In this case the score for the frame is the number of pins knocked down.

# A spare is where all ten pins are knocked down after the second throw.
#  The total value of a spare is 10 plus the number of pins knocked down
#   in their next throw.

# A strike is where all ten pins are knocked down after the first throw.
#  The total value of a strike is 10 plus the number of pins knocked down
#   in their next two throws. If a strike is immediately followed by a
#   second strike, then we can not total the value of first strike until
#    they throw the ball one more time.

# Here is a three frame example:

# Frame 1 Frame 2 Frame 3
# X (strike) 5/ (spare) 9 0 (open frame)
# Frame 1 is (10 + 5 + 5) = 20

# Frame 2 is (5 + 5 + 9) = 19

# Frame 3 is (9 + 0) = 9

# This means the current running total is 48.

# The tenth frame in the game is a special case. If someone throws a
# strike or a spare then they get a fill ball. Fill balls exist to
# calculate the total of the 10th frame. Scoring a strike or spare on
# the fill ball does not give the player more fill balls. The total
# value of the 10th frame is the total number of pins knocked down.

# For a tenth frame of X1/ (strike and a spare), the total value is 20.

# For a tenth frame of XXX (three strikes), the total value is 30.

# Requirements
# Write code to keep track of the score of a game of bowling. It should
# support two operations:

# roll(pins) is called each time the player rolls a ball. The argument
# is the number of pins knocked down.

# score() is called only at the very end of the game. It returns the
# total score for that game.

class Game
  def initialize
    @round = 1
    @score = 0
    @first_attempt = true
    @strikes = []
    spare_reset
    @fill = 0
  end

  def score
    raise StandardError, 'Score cannot be taken until the end of the game' if
      @round <= 10
    @score
  end

  def roll(score)
    check_score_valid(score)
    check_game_not_over
    if @fill > 0
      filler_ball(score)
    elsif @first_attempt
      score == 10 ? strike : go_again(score)
    else
      check_pin_count_legal(score)
      round_over(score)
    end
  end

  private

  def filler_ball(score)
    add_strikes(score)
    if @spare.size == 2 # spare
      @score += (10 + score)
    else # strike
      check_pin_count_legal(score)
      @spare << score unless score == 10
    end
    @fill -= 1
    @round += 1 if @fill == 0
  end

  def strike
    add_strikes(10)
    @round == 10 ? @fill = 2 : @round += 1
    @score += 20 if @spare.sum == 10
    @strikes << [2, 10]
    spare_reset
  end

  def go_again(score)
    add_strikes(score)
    @score += (10 + score) if @spare.sum == 10
    spare_reset
    @first_attempt = false
    @spare << score
  end

  def round_over(score)
    add_strikes(score)
    @spare << score
    if @spare.sum == 10
      @fill = 1 if @round == 10
    else
      @score += @spare.sum
      spare_reset
    end
    @round += 1 unless @fill > 0
    @first_attempt = true
  end

  def add_strikes(score)
    if @strikes[1]
      update_strike_count(@strikes[1], score)
      @score += @strikes.shift[1] + score
    elsif @strikes[0]
      update_strike_count(@strikes[0], score)
      @score += @strikes.shift[1] if @strikes[0][0] == 0
    end
  end

  def spare_reset
    @spare = []
  end

  def check_score_valid(score)
    raise StandardError, "Pins must have a value from 0 to 10" if
      score < 0 || score > 10
  end

  def check_game_not_over
    raise StandardError, 'Should not be able to roll after game is over' if
      @round > 10
  end

  def check_pin_count_legal(score)
    raise StandardError, 'Pin count exceeds pins on the lane' if
      @spare[0] && @spare[0] + score > 10
  end

  def update_strike_count(array, score)
    array[0] -= 1
    array[1] += score
  end
end

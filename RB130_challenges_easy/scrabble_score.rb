class Scrabble
  
  KEY = {
    1 => %w(A E I O U L N R S T),
    2 => %w(D G),
    3 => %w(B C M P),
    4 => %w(F H V W Y),
    5 => %w(K),
    8 => %w(J X),
    10 => %w(Q Z)
  }

  def initialize(string)
    @string = string
  end

  def self.score(string)
    Scrabble.new(string).score    
  end

  def score
    score = 0
    return score unless @string
    @string.each_char do |char|
      KEY.each do |points, letters|
        score += points if letters.include?(char.upcase)
      end
    end
    score
  end

end



class Cipher
  UPPERCASE_LETTERS = ('A'..'Z').to_a
  LOWERCASE_LETTERS = ('a'..'z').to_a

  def self.rotate(string, distance)
    string.chars.map do |char|
      if UPPERCASE_LETTERS.include? char
        UPPERCASE_LETTERS[(UPPERCASE_LETTERS.index(char) + distance) % 26]
      elsif LOWERCASE_LETTERS.include? char
        LOWERCASE_LETTERS[(LOWERCASE_LETTERS.index(char) + distance) % 26]
      else
        char
      end
    end.join
  end
end

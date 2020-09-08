class Anagram

  def initialize(string)
    @word = string
  end

  def match(arr)
    arr.select do |word| 
      word.downcase.chars.sort == @word.downcase.chars.sort &&
      word.downcase != @word.downcase
    end
  end

end


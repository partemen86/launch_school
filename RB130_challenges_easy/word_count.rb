class Phrase

  def initialize(string)
    @phrase = string
  end

  def word_count
    result = Hash.new(0)
    word_arr = @phrase.scan(/\b[\w']+\b/) do |word| 
      result[word.downcase] += 1 
    end
    result
  end

end


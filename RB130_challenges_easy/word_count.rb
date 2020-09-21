# Write a program that given a phrase can count the occurrences
# of each word in that phrase.

# For example, if we count the words for the input
# "olly olly in come free", we should get:

# olly: 2
# in: 1
# come: 1
# free: 1

class Phrase
  def initialize(words)
    @words = words
  end

  def word_count
    count = Hash.new(0)
    @words.downcase.scan(/\b[\w']+\b/).each { |word| count[word] += 1 }
    count
  end
end

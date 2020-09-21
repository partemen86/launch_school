# Write a program that, given a word and a list of possible anagrams,
# selects the correct sublist that contains the anagrams of the word.

# For example, given the word "listen" and a list of candidates like
# "enlists" "google" "inlets" "banana" the program should return a list
# containing "inlets". Please read the test suite for exact rules of anagrams.

class Anagram
  def initialize(word)
    @word = word
  end

  def match(array)
    array.select do |word|
      word.downcase.chars.sort == @word.downcase.chars.sort &&
        !word.casecmp?(@word)
    end
  end
end

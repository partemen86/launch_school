# Pig Latin is a made-up children's language that's intended to be confusing.
# It obeys a few simple rules (below), but when it's spoken quickly it's
# really difficult for non-children (and non-native speakers) to understand.

# Rule 1: If a word begins with a vowel sound, add an "ay" sound to the end
# of the word.
# Rule 2: If a word begins with a consonant sound, move it to the end of
# the word, and then add an "ay" sound to the end of the word.
# There are a few more rules for edge cases, and there are regional
# variants too.

class PigLatin
  def self.translate(string)
    string.split.map { |word| pig_latined(word) }.join(" ")
  end

  def self.pig_latined(word)
    if word.match(/\A(sch)|(thr)|[^aeiou]qu/)
      word[3..-1] + word[0..2] + 'ay'
    elsif word.match(/\A(th)|(ch)|(sh)|(qu)/)
      word[2..-1] + word[0..1] + 'ay'
    elsif word.match(/\A[aeiou]|[xy][^aeiou]/)
      word + 'ay'
    else
      word[1..-1] + word[0] + 'ay'
    end
  end
end

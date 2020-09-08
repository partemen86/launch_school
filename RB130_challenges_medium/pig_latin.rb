class PigLatin
  def self.translate(words)
    words_arr = words.split
    x = words_arr.map do |word|
      if word.match(/^thr|^sch|^[^aeiou]qu/)
        word[3..-1] + word[0..2] + 'ay'
      elsif word.match(/^ch|^th|^qu/)
        word[2..-1] + word[0..1] + 'ay'
      elsif word.match(/^[xy][^aeiou]|^[aeiou]/)
        word + 'ay'
      else
        word[1..-1] + word[0] + 'ay'
      end
    end
    x.join(" ")
  end

end

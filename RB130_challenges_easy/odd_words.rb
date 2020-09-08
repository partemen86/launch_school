def odd_words(string)
  words = string.delete('.').split
  words.each_with_index do |word, idx|
    if idx.odd?
      output(word.reverse)
    else 
      output(word)
    end
    puts " " unless idx >= words.size - 1
  end
  puts '.'

end

def output(string)
  string.each_char do |char|
    puts char
    sleep 0.2
  end
end

 odd_words("whats the  matter with kansas .")


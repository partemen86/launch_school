
puts "=> Please enter string"
answer = gets.chomp

array_of_answer = answer.split(" ")
array_of_answer.each do |word|
  if word.reverse == word && word.length > 1
    word.upcase!
  end
end

output = array_of_answer.join(" ")
p output
p answer
flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
counter = 0
x = flintstones.each_with_object({}) do |name, hash|

  hash[name] = counter
  counter +=1
end

ages = { "Herman" => 32, "Lily"    => 30, "Grandpa" => 5843, 
         "Eddie"  => 10, "Marilyn" => 22, "Spot"    => 237 }

age_counter = 0
ages.each do |_key, value|
  age_counter += value
end

p age_counter

y = ages.select do |_key, value|
  value < 100
end


ages = { "Herman" => 32, "Lily"    => 30, "Grandpa" => 5843, 
         "Eddie"  => 10, "Marilyn" => 22, "Spot"    => 237 }
p ages.values.min

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

p flintstones.index {|name| name[0,2] == "Be"}

new_flintstones = flintstones.map! do |name| 
  name = name[0,3]
end

p new_flintstones

# problem 7
#
#

statement = "The Flintstones Rock"

statement_letters = statement.delete(" ").chars

letter_hash = Hash.new(0)
statement_letters.each do |letter|
  letter_hash[letter] +=1
end

p letter_hash
# problem 9
#
words = "the flintstones rock"
def titleize(string)
  split_words = string.split
  split_words.each {|word| word.capitalize!}
  split_words.join(" ")
end
# words.split.map { |word| word.capitalize }.join(' ')

p titleize(words)

# problem 10
#
#
munsters = {
  "Herman" => { "age" => 18, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}

munsters.each do |key, value|
  case value["age"]
  when 0..17
    value["age_group"] = "kid"
  when 18..64
    value["age_group"] = "adult"
  else
    value["age_group"] = "senior"
  end
end

array = [1,2,3,4]
array.each do |num|
  puts num + 1
  break
end
p array
# # practice problem 1
# arr = ['10', '11', '9', '7', '8']

# sorted_arr = arr.sort do |a, b|
#   b.to_i <=> a.to_i
# end

# p sorted_arr

# # practice problem 2

# books = [
#   { title: 'One Hundred Years of Solitude', author: 'Gabriel Garcia Marquez', published: '1967' },
#   { title: 'The Great Gatsby', author: 'F. Scott Fitzgerald', published: '1925' },
#   { title: 'War and Peace', author: 'Leo Tolstoy', published: '1869' },
#   { title: 'Ulysses', author: 'James Joyce', published: '1922' }
# ]

# sorted_books = books.sort do |book1, book2|
#   book1[:published].to_i <=> book2[:published].to_i
# end

# p sorted_books

# # practice problem 3

# arr1 = ['a', 'b', ['c', ['d', 'e', 'f', 'g']]]

# arr2 = [{first: ['a', 'b', 'c'], second: ['d', 'e', 'f']}, {third: ['g', 'h', 'i']}]

# arr3 = [['abc'], ['def'], {third: ['ghi']}]

# hsh1 = {'a' => ['d', 'e'], 'b' => ['f', 'g'], 'c' => ['h', 'i']}

# hsh2 = {first: {'d' => 3}, second: {'e' => 2, 'f' => 1}, third: {'g' => 0}}

# p arr1[2][1][3]
# p arr2[1][:third][0]
# p arr3[2][:third][0][0]
# p hsh1['b'][1]
# p hsh2[:third].keys[0]

# practice problem 4

# arr1 = [1, [2, 3], 4]

# arr2 = [{a: 1}, {b: 2, c: [7, 6, 5], d: 4}, 3]

# hsh1 = {first: [1, 2, [3]]}

# hsh2 = {['a'] => {a: ['1', :two, 3], b: 4}, 'b' => 5}

# arr1[1][1] += 1
# p arr1
# arr2[2] += 1
# p arr2
# hsh1[:first][2][0] += 1
# p hsh1
# hsh2[['a']][:a][2] += 1
# p hsh2

# practice problem 5

# munsters = {
#   "Herman" => { "age" => 32, "gender" => "male" },
#   "Lily" => { "age" => 30, "gender" => "female" },
#   "Grandpa" => { "age" => 402, "gender" => "male" },
#   "Eddie" => { "age" => 10, "gender" => "male" },
#   "Marilyn" => { "age" => 23, "gender" => "female"}
# }

# total_age = 0
# munsters.each_value do |value|
#   total_age += value["age"] if value["gender"] == "male" 
# end
# p total_age

# practice problem 6

# munsters.each do |name, details|
#   puts "#{name} is a #{details["age"]}-year-old #{details["gender"]}"
# end

# practice problem 8

# hsh = {first: ['the', 'quick'], second: ['brown', 'fox'],
#       third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

# hsh.each_value do |array|
#   array.each do |word|
#     word.chars.each do |letter|
#       puts letter if %w(a e i o u).include?(letter)
#     end
#   end
# end

# practice problem 9

# arr = [['b', 'c', 'a'], [2, 1, 3], ['blue', 'black', 'green']]

# arr2 = arr.map do |sub_arr|
#   sub_arr.sort do |a, b|
#     b <=> a
#   end
# end
# p arr
# p arr2

# practice problem 10

# arreh = [{a: 1}, {b: 2, c: 3}, {d: 4, e: 5, f: 6}]

# arrey2 = arreh.map do |hash|
#   incremented_hash = {}
#   hash.each do |key, value|
#     incremented_hash[key] = value + 1
#   end
#   incremented_hash
# end
# p arreh
# p arrey2

# practice problem 11

# arr = [[2], [3, 5, 7], [9], [11, 13, 15]]

# x = arr.map do |sub_arr|
#   sub_arr.select do |num|
#     num % 3 == 0
#   end
# end

# p arr
# p x

# practice problem 12

# arr = [[:a, 1], ['b', 'two'], ['sea', {c: 3}], [{a: 1, b: 2, c: 3, d: 4}, 'D']]
# # expected return value: {:a=>1, "b"=>"two", "sea"=>{:c=>3}, {:a=>1, :b=>2, :c=>3, :d=>4}=>"D"}
# new_hash = {}
# arr.each do |sub_arr|
#   new_hash[sub_arr[0]] = sub_arr[1]
# end

# p arr
# p new_hash

# practice problem 13

# arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]

# x = arr.sort_by do |sub_arr|
#   sub_arr.select {|num| num.odd?} 
# end
# p arr
# p x

# practice problem 14

# hsh = {
#   'grape' => {type: 'fruit', colors: ['red', 'green'], size: 'small'},
#   'carrot' => {type: 'vegetable', colors: ['orange'], size: 'medium'},
#   'apple' => {type: 'fruit', colors: ['red', 'green'], size: 'medium'},
#   'apricot' => {type: 'fruit', colors: ['orange'], size: 'medium'},
#   'marrow' => {type: 'vegetable', colors: ['green'], size: 'large'},
# }

# x = hsh.values.map do |sub_hsh|
#   if sub_hsh[:type] == 'vegetable'
#     sub_hsh[:size].upcase
#   elsif sub_hsh[:type] == 'fruit'
#     sub_hsh[:colors].map {|color| color.capitalize}
#   end
# end

# p x
# p hsh

# practice problem 15

# arr = [{a: [1, 2, 3]}, {b: [2, 4, 6], c: [3, 6], d: [4]}, {e: [8], f: [6, 10]}]

# x = arr.select do |hash|
#   hash.values.all? do |sub_array| 
#     sub_array.all? {|num| num.even?}
    
#   end  
  
# end

# p x

# practice problem 16

# def uuid_gen
#   characters = []
#   (0..9).each {|num| characters << num.to_s}
#   ('a'..'f').each {|letter| characters << letter}
#   uuid = ""
#   sections = [8,4,4,4,12]
#   sections.each do |num|
#     num.times do
#       uuid << characters.sample
#     end
#   uuid += '-' 
#   end
#   uuid[0...-1]
# end

# p uuid_gen


order_data = [
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 351, order_date: '12/04/16', order_fulfilled: true, order_value: 135.99},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 383, order_date: '12/04/16', order_fulfilled: true, order_value: 289.49},
  {customer_id: 12, customer_name: 'Emma Lopez', order_id: 392, order_date: '01/10/17', order_fulfilled: false, order_value: 58.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 241, order_date: '11/10/16', order_fulfilled: true, order_value: 120.00},
  {customer_id: 32, customer_name: 'Michael Richards', order_id: 395, order_date: '01/10/17', order_fulfilled: false, order_value: 85.65},
  # rest of data...
]

customer_orders = order_data.map do |row|
  {
    customer_id: row[:customer_id],
    customer_name: row[:customer_name],
    orders: [
      {
        order_fulfilled: row[:order_fulfilled],
        order_value: row[:order_value]
      }
    ]
  }
end

p customer_orders
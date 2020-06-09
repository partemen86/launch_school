my_numbers = [1, 4, 3, 7, 2, 6]

def double_odd_index(some_array)
  counter = 0
  doubled_odd_index_arr = []
  loop do
    break if counter >= some_array.length
    if counter.odd?
      doubled_odd_index_arr << some_array[counter] * 2
    else
      doubled_odd_index_arr << some_array[counter]
    end
    counter += 1
  end
  doubled_odd_index_arr
end

p double_odd_index(my_numbers)


my_numbers = [1 ,4, 3, 7, 2, 6]

def multiply(arr,multiple)
  counter = 0
  new_array = []
  loop do
    break if counter >= arr.length
    new_array << arr[counter] * multiple
    counter +=1
  end
  new_array
end

p multiply(my_numbers,5)

produce = { 'apple' => 'Fruit', 'carrot'   => 'Vegetable',
            'pear'  => 'Fruit', 'broccoli' => 'Vegetable'}


def select_fruits(input_list)
  selected_fruits = {}
  counter = 0
  list_keys = input_list.keys
  loop do
    break if list_keys.length == counter
    current_key = list_keys[counter]
    if input_list[current_key] == 'Fruit'
      selected_fruits[current_key] = 'Fruit'
    end
    counter += 1
  end
  selected_fruits
end

p select_fruits(produce)
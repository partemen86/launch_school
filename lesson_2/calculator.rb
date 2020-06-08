
require 'yaml'
MESSAGES = YAML.load_file('calculator_messages.yml')

def prompt(message)
  puts "=> #{message}"
end

def valid_number?(num)
  /\d/.match(num) && /^-?\d*\.?\d*$/.match(num)
end

def operation_to_message(op)
  case op
  when "1"
    "Adding"
  when "2"
    "Subtracting"
  when "3"
    "Multiplying"
  when "4"
    "Dividing"
  end
end

prompt(MESSAGES['welcome'])

name = ''
loop do
  name = gets.chomp

  if name.empty?
    prompt(MESSAGES['valid_name'])
  else
    break
  end
end

prompt("Hi #{name}!")
loop do
  number1 = ''
  loop do
    prompt(MESSAGES['first_num'])
    number1 = gets.chomp

    if valid_number?(number1)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  number2 = ''
  loop do
    prompt(MESSAGES['second_num'])
    number2 = gets.chomp

    if valid_number?(number2)
      break
    else
      prompt(MESSAGES['invalid_num'])
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perfrom?
    1) add
    2) subtract
    3) multiply
    4) divide
  MSG

  prompt(operator_prompt)

  operator = ''
  loop do
    operator = gets.chomp

    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt(MESSAGES['invalid_operator'])
    end
  end

  prompt("#{operation_to_message(operator)} the two numbers...")

  result =  case operator
            when '1'
              number1.to_f + number2.to_f
            when '2'
              number1.to_f - number2.to_f
            when '3'
              number1.to_f * number2.to_f
            when '4'
              number1.to_f / number2.to_f
            end
  # if operator == '1'
  #   result = number1.to_i + number2.to_i
  # elsif operator == '2'
  #   result = number1.to_i - number2.to_i
  # elsif operator == '3'
  #   result = number1.to_i * number2.to_i
  # elsif operator == '4'
  #   result = number1.to_f / number2.to_f
  # end
  prompt("The result is #{result}")
  prompt(MESSAGES['another_calc'])
  answer = gets.chomp
  break unless answer.downcase.start_with?('y')
end

prompt(MESSAGES['goodbye'])

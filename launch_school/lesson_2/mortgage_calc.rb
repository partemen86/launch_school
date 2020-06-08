
def prompt(str)
  puts "=> #{str}"
end

def valid_number?(num)
  /\d/.match(num) && /^\d*\.?\d*$/.match(num)
end

prompt("Welcome to the Mortgage Calculator!")
loop do
  loan_amount = ''
  loop do
    prompt("Please enter loan amount")
    loan_amount = gets.chomp

    if valid_number?(loan_amount)
      loan_amount = loan_amount.to_f
      break
    else
      prompt("That does not appear to be a valid number")
    end
  end

  apr = ''
  loop do
    prompt("Please enter Annual Percentage Rate(APR)")
    apr = gets.chomp

    if valid_number?(apr)
      apr = apr.to_f / 100
      break
    else
      prompt("That does not appear to be a valid number")
    end
  end

  loan_duration = ''
  loop do
    prompt("Please enter loan duration, in years")
    loan_duration = gets.chomp
    if valid_number?(loan_duration)
      loan_duration = loan_duration.to_f
      break
    else
      prompt("That does not appear to be a valid number")
    end
  end

  monthly_apr = apr / 12

  duration_in_months = loan_duration * 12

  monthly_payment = loan_amount *
                    (monthly_apr /
                    (1 - (1 + monthly_apr)**(-1 * duration_in_months)))

  #prompt("Your monthly payment will be: #{monthly_payment}")
  prompt("Your monthly payment is: $#{format('%.2f', monthly_payment)}")
  
  prompt("Would you like to do another calculation?")
  answer = gets.chomp

  break unless answer.downcase.start_with?('y')
end

prompt("Thank you for using the Mortgage Calculator!")

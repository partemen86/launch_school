require 'minitest/autorun'

require_relative 'transaction'

class TransactionTest < Minitest::Test

  # def setup
  #   @transaction = Transaction.new(100)
  # end

  def test_prompt_for_payment
    transaction = Transaction.new(100)
    input1 = StringIO.new("100\n")
    output1 = StringIO.new
    transaction.prompt_for_payment(inp: input1, outp: output1)
    assert_equal(100, transaction.amount_paid)
    
  end

end



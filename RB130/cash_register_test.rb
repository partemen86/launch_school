require 'minitest/autorun'

require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test

  def setup
    @register = CashRegister.new(500)
    @transaction = Transaction.new(50)
    @transaction.amount_paid = 70
  end

  def test_accept_money
    assert_equal(20, @register.change(@transaction)) 
  end

end
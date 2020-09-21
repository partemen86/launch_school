require 'minitest/autorun'
require_relative 'cash_register'
require_relative 'transaction'

class CashRegisterTest < Minitest::Test

  def setup
    @transaction = Transaction.new(50)
    @register = CashRegister.new(100)
  end

  def test_accept_money
    @transaction.amount_paid = 50
    @register.accept_money(@transaction)
    assert_equal(150, @register.total_money)
  end

  def test_change
    @transaction.amount_paid = 75
    assert_equal(25, @register.change(@transaction))
  end

  def test_give_receipt
    string = "You've paid $50.\n"
    assert_output(string) { @register.give_receipt(@transaction)}
  end

  def test_prompt_for_payment
    string = StringIO.new("50\n")
    @transaction.prompt_for_payment(inp: string, outp: StringIO.new)
    assert_equal(50, @transaction.amount_paid)
  end
end
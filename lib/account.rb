# frozen_string_literal: true

require_relative 'transaction'
require_relative 'transaction_history'
require 'date'

# Account class, for recording balance and making deposits and withdrawals.
class Account
  attr_reader :balance, :t_history

  def initialize(t_history = TransactionHistory.new)
    @balance = 0
    @t_history = t_history
  end

  def deposit(amount)
    amount = check_format(amount)
    zero_error(amount)
    @balance += amount
    record_transaction(amount)
  end

  def withdraw(amount)
    amount = check_format(amount)
    zero_error(amount)
    check_balance(amount)
    @balance -= amount
    record_transaction(-amount)
  end

  def statement
    @t_history.print_statement
  end

  private

  def record_transaction(amount, transaction = Transaction.new)
    transaction.amount = amount
    transaction.balance_after = @balance
    @t_history.add_t(transaction)
  end

  def check_format(amount)
    fail 'You must input a valid amount of money.' unless amount.match(/^[0-9]*.[0-9][0-9]$/)
    
    amount.to_f
  end

  def zero_error(amount)
    fail 'You must specify an amount more than zero.' if amount == 0
  end

  def check_balance(amount)
    fail 'You do not have sufficient funds for that transaction' unless @balance - amount >= 0
  
  end
end

# frozen_string_literal: true

require_relative 'transaction'
require_relative 'transaction_history'
require_relative 'statement'
require 'date'

# Account class, for recording balance and making deposits and withdrawals.
class Account
  OPENING_BALANCE = 0

  def initialize(transaction_history = TransactionHistory.new)
    @transaction_history = transaction_history
  end

  def balance
    if first_transaction?
      OPENING_BALANCE
    else
      @transaction_history.most_recent.balance_after
    end
  end

  def deposit(amount, transaction = Transaction.new(date = DateTime.now))
    amount = check_format(amount)
    zero_value_transaction_error(amount)
    record_transaction(amount, transaction)
  end

  def withdraw(amount, transaction = Transaction.new(date = DateTime.now))
    amount = check_format(amount)
    zero_value_transaction_error(amount)
    check_balance(amount)
    record_transaction(-amount, transaction)
  end

  def statement(statement = Statement.new)
    statement.print_statement(@transaction_history)
  end

  private

  def first_transaction?
    @transaction_history.empty?
  end

  def record_transaction(amount, transaction)
    transaction.amount = amount
    transaction.balance_after = balance + amount
    @transaction_history.add_transaction(transaction)
  end

  def check_format(amount)
    fail 'You must input a valid amount of money.' unless amount.match(/^[0-9]*.[0-9][0-9]$/)
    
    amount.to_f
  end

  def zero_value_transaction_error(amount)
    fail 'You must specify an amount more than zero.' if amount == 0
  end

  def check_balance(amount)
    fail 'You do not have sufficient funds for that transaction' unless balance - amount >= 0
  
  end
end

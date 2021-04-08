# frozen_string_literal: true

# TransactionHistory class, for storing an account's transactions and printing out statements.
class TransactionHistory
  attr_reader :transactions

  def initialize
    @transactions = []
  end

  def add_transaction(transaction)
    @transactions << transaction
  end

end

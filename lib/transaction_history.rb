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

  def print_amount(transaction)
    if transaction.deposit?
      ' || ' + '%.2f' % transaction.amount + ' || || '
    elsif transaction.withdrawal?
      ' || || ' + '%.2f' % transaction.amount.abs + ' || '
    end
  end

  def print_transaction(transaction)
    transaction.date.strftime("%d/%m/%Y") + print_amount(transaction) + '%.2f' % transaction.balance_after
  end

  def print_statement
    "date || credit || debit || balance\n" +
      @transactions.reverse.map { |transaction| print_transaction(transaction) }.join("\n")
  end
end

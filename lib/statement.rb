class Statement
  
  def print_statement(transaction_history)
    "date || credit || debit || balance\n" +
      transaction_history.transactions.reverse.map { |transaction| print_transaction(transaction) }.join("\n")
  end

  private

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

end
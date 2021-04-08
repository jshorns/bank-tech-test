class Statement
  
  def print_statement(transaction_history)
    puts format_statement(transaction_history)
  end
   

  private

  def format_statement(transaction_history)
    "date || credit || debit || balance\n" +
      transaction_history.transactions.reverse.map { |transaction| format_transaction(transaction) }.join("\n")
  end

  def format_amount(transaction)
    if transaction.deposit?
      ' || ' + '%.2f' % transaction.amount + ' || || '
    elsif transaction.withdrawal?
      ' || || ' + '%.2f' % transaction.amount.abs + ' || '
    end
  end

  def format_transaction(transaction)
    transaction.date.strftime("%d/%m/%Y") + format_amount(transaction) + '%.2f' % transaction.balance_after
  end

end
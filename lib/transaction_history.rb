class TransactionHistory
    attr_reader :transactions
    def initialize
        @transactions = []
    end

    def add_t(transaction)
        @transactions.unshift(transaction)
    end

    def print_amount(transaction)
        if transaction.deposit?
        " || " + '%.2f' % transaction.amount + " || || "
        elsif transaction.withdrawal?
         " || || " + '%.2f' % transaction.amount.abs + " || "
        end
    end

    def print_transaction(transaction)
        #refactoring - make this just a q of outputting the middle bit. leave the rest to transaction history.
        transaction.date.strftime("%d/%m/%Y") + print_amount(transaction) + '%.2f' % transaction.balance_after
    end

    def print_statement
        "date || credit || debit || balance\n" +
        @transactions.map { |transaction| print_transaction(transaction)}.join("\n") 
    end

end
require_relative 'transaction'

class Account
    attr_reader :balance, :t_history
    def initialize
        @balance = 0
        @t_history = []
    end

    def deposit(amount)
        @balance += amount
    end

    def withdraw(negative_amount)
        @balance += negative_amount
    end

    def record_transaction(amount, transaction = Transaction.new)
        transaction.set_amount(amount)
        transaction.set_balance_after(@balance)
        add_to_t_history(transaction)
    end

    def add_to_t_history(transaction)
        @t_history << transaction
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

end
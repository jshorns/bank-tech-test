require_relative 'transaction'
require_relative 'transaction_history'

class Account
    attr_reader :balance, :t_history
    def initialize(t_history = TransactionHistory.new)
        @balance = 0
        @t_history = t_history
    end

    def deposit(amount)
        fail "You must input a valid number." unless amount.is_a? Numeric
        @balance += amount
        record_transaction(amount)
    end

    def withdraw(amount)
        fail "You must input a valid number." unless amount.is_a? Numeric
        @balance -= amount
        record_transaction(-amount)
    end

    def record_transaction(amount, transaction = Transaction.new)
        transaction.set_amount(amount)
        transaction.set_balance_after(@balance)
        @t_history.add_t(transaction)
    end

    def statement
        @t_history.print_statement
    end

end
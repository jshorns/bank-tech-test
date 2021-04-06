require_relative 'transaction'

class Account
    attr_reader :balance, :t_history
    def initialize
        @balance = 0
        @t_history = []
        @current_transaction = nil
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
        @t_history << transaction
    end

end
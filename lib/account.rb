require_relative 'transaction'

class Account
    attr_reader :balance, :t_history
    def initialize(transaction = Transaction.new)
        @balance = 0
        @t_history = []
        @current_transaction = transaction
    end

    def deposit(amount)
        @balance += amount
    end

    def withdraw(negative_amount)
        @balance += negative_amount
    end

    def record_transaction(amount)
    
    end


end
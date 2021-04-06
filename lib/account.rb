require_relative 'transaction'

class Account
    attr_reader :balance 
    def initialize
        @balance = 0
    end

    def deposit(amount)
        @balance += amount
        record_transaction
    end

    def withdraw(negative_amount)
        @balance += negative_amount
        record_transaction
    end

private

    def record_transaction(transaction = Trasnsaction.new)
        
    end

end
require_relative 'transaction'

class Account
    attr_reader :balance 
    def initialize
        @balance = 0
    end

    def deposit(amount)
        @balance += amount
    end

    def withdraw(negative_amount)
        @balance += negative_amount
    end


end
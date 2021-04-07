class Transaction
    attr_reader :amount, :balance_after
    def initialize(date = DateTime.now)
        @amount = nil
        @balance_after = nil
        @date = date
    end

    def set_amount(amount)
        @amount = amount
    end

    def set_balance_after(balance)
        @balance_after = balance
    end

    def deposit?
        @amount > 0
    end

    def withdrawal?
        @amount < 0
    end

    def date
      @date  
    end

end
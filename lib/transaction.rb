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

    def print_transaction
        if deposit? 
            @date.strftime("%d/%m/%Y") + " || " + '%.2f' % @amount + " || || " + '%.2f' % @balance_after
        end
    end

end
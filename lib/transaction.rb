class Transaction
    attr_reader :amount
    def initialize
        @amount = nil
    end

    def set_amount(amount)
        @amount = amount
    end

    def deposit?
        @amount > 0
    end

    def withdrawal?
        @amount < 0
    end

    def date

    end
end
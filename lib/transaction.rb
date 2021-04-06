class Transaction
    attr_reader :amount
    def initialize
        @amount = nil
    end

    def set_amount(amount)
        @amount = amount
    end

    def deposit?
    end

    def withdrawal?
    end

    def date

    end
end
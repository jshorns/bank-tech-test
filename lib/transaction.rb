# frozen_string_literal: true

# Transaction class, for storing the details of transactions.
class Transaction
  attr_reader :date
  attr_accessor :amount, :balance_after

  def initialize(date = DateTime.now)
    @amount = nil
    @balance_after = nil
    @date = date
  end

  def deposit?
    @amount.positive?
  end

  def withdrawal?
    @amount.negative?
  end
end

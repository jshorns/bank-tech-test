# frozen_string_literal: true

require 'transaction'

describe Transaction do
  amount = 500.0

  describe '#amount' do
    it 'is nil on initialize' do
      expect(subject.amount).to be nil
    end
  end

  describe '#date' do
    it 'stores the date' do
      expect(subject.date).to be_an_instance_of DateTime
    end
  end

  describe '#amount' do
    it 'changes the amount of the transaction' do
      subject.amount = amount
      expect(subject.amount).to eq amount
    end
  end

  describe '#balance_after' do
    it 'changes the amount stored to balance_after' do
      subject.balance_after = amount
      expect(subject.balance_after).to eq amount
    end
  end

  describe '#deposit?' do
    it 'returns true if amount is above zero' do
      subject.amount = amount
      expect(subject.deposit?).to be true
    end
    it 'returns false if amount is below zero' do
      subject.amount = -amount
      expect(subject.deposit?).to be false
    end
  end

  describe '#withdrawal?' do
    it 'returns true if amount is below zero' do
      subject.amount = -amount
      expect(subject.withdrawal?).to be true
    end
    it 'returns false if amount is above zero' do
      subject.amount = amount
      expect(subject.withdrawal?).to be false
    end
  end
end

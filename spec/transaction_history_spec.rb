# frozen_string_literal: true

require 'transaction_history'

describe TransactionHistory do
  describe '#add_transaction' do
    let(:transaction) { double(:transaction) }
    it 'adds a transaction to the array' do
      expect { subject.add_transaction(transaction) }.to change { subject.transactions.length }.by 1
      subject.add_transaction(transaction)
      expect(subject.transactions).to include transaction
      expect(subject.transactions[0]).to eq transaction
    end
  end
  describe 'empty?' do
    let(:transaction) { double(:transaction) }
    it 'returns true if transactions array is empty' do
      expect(subject.empty?).to be true
    end
    it 'returns false if transactions array is not empty' do
      subject.add_transaction(transaction)
      expect(subject.empty?).to be false
    end
  end
end

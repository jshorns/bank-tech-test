# frozen_string_literal: true

require 'transaction_history'

describe TransactionHistory do
  it { is_expected.to respond_to :transactions }
  describe '#add_transaction' do
    let(:transaction) { double(:transaction) }
    it 'adds a transaction to the array' do
      expect { subject.add_transaction(transaction) }.to change { subject.transactions.length }.by 1
      subject.add_transaction(transaction)
      expect(subject.transactions).to include transaction
      expect(subject.transactions[0]).to eq transaction
    end
  end
  describe '#print_transaction' do
    let(:deposit) { double(:transaction, amount: 500.00, deposit?: true, withdrawal?: false, balance_after: 1000.00, date: DateTime.new(2021, 4, 6)) }
    let(:withdrawal) { double(:transaction, amount: -500.00, deposit?: false, withdrawal?: true, balance_after: 1000.00, date: DateTime.new(2021, 4, 6)) }
    it 'returns a string in the specified format for withdrawals' do
      expect(subject.print_transaction(withdrawal)).to eq '06/04/2021 || || 500.00 || 1000.00'
    end
    it 'returns a string in the specified format' do
      expect(subject.print_transaction(deposit)).to eq '06/04/2021 || 500.00 || || 1000.00'
    end
  end

  describe '#print_statement' do
    let(:transaction1) { double(:transaction, amount: 1000.00, deposit?: true, withdrawal?: false, balance_after: 1000.00, date: DateTime.new(2012, 1, 10)) }
    let(:transaction2) { double(:transaction, amount: 2000.00, deposit?: true, withdrawal?: false, balance_after: 3000.00, date: DateTime.new(2012, 1, 13)) }
    let(:transaction3) { double(:transaction, amount: -500.00, deposit?: false, withdrawal?: true, balance_after: 2500.00, date: DateTime.new(2012, 1, 14)) }
    it 'prints out the transactions in the required format' do
      subject.add_transaction(transaction1)
      subject.add_transaction(transaction2)
      subject.add_transaction(transaction3)
      expect(subject.print_statement).to eq(
        "date || credit || debit || balance\n"  +
        "14/01/2012 || || 500.00 || 2500.00\n"  +
        "13/01/2012 || 2000.00 || || 3000.00\n" +
        '10/01/2012 || 1000.00 || || 1000.00'
      )
    end
  end
end

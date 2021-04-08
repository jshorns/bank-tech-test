# frozen_string_literal: true

require 'account'

describe Account do
  let(:transaction_history) { double(:transaction_history, transactions: []) }
  before(:each) { allow(transaction_history).to receive(:add_transaction) }
  subject { described_class.new(transaction_history) }
  amount = '500.00'
  describe '#deposit' do
  let(:transaction) { double(:transaction, :date => DateTime.now) }
    it 'adds details of the transaction and adds amount for balance after' do
      expect(transaction).to receive(:amount=).with(amount.to_f)
      expect(transaction).to receive(:balance_after=).with(subject.balance + amount.to_f)
      expect(transaction_history).to receive(:add_transaction)
      expect(transaction_history).to receive(:transactions)
      subject.deposit(amount, transaction)
    end
    it 'fails if amount is in incorrect format' do
      expect { subject.deposit('500.876', transaction) }.to raise_error('You must input a valid amount of money.')
    end
    it 'fails if sum is 0' do
      expect { subject.deposit('0.00', transaction) }.to raise_error('You must specify an amount more than zero.')
    end
  end

  describe "#withdraw" do
  let(:transaction) { double(:transaction, :date => DateTime.now) }
    it 'adds details of the transaction and deducts amount for balance after' do
      allow(subject).to receive(:balance).and_return(amount.to_f + 1)
      expect(transaction).to receive(:amount=).with(-amount.to_f)
      expect(transaction).to receive(:balance_after=).with(subject.balance-amount.to_f)
      expect(transaction_history).to receive(:add_transaction)
      subject.withdraw(amount, transaction)
    end
    it 'fails if input is not in money format' do
      expect { subject.withdraw('500.876', transaction) }.to raise_error('You must input a valid amount of money.')
    end
    it 'fails if there are insufficient funds' do
      allow(transaction).to receive(:amount=)
      allow(transaction).to receive(:balance_after=)
      expect { subject.withdraw('10.00', transaction) }.to raise_error('You do not have sufficient funds for that transaction')
    end
    it 'fails if sum is 0' do
      expect { subject.withdraw('0.00', transaction) }.to raise_error('You must specify an amount more than zero.')
    end
  end
 
  describe "#balance" do
    it 'returns opening balance before any transactions have been added' do
      expect(subject.balance).to eq Account::OPENING_BALANCE
    end
    describe 'after two transactions' do
      let(:transaction1) { double(:transaction, amount: 1000.00, deposit?: true, withdrawal?: false, balance_after: 1000.00, date: DateTime.new(2012, 1, 10)) }
      let(:transaction2) { double(:transaction, amount: 2000.00, deposit?: true, withdrawal?: false, balance_after: 3000.00, date: DateTime.new(2012, 1, 13)) }
      let(:transaction_history) { double(:transaction_history, transactions: [transaction1, transaction2]) }
      subject { described_class.new(transaction_history) }
      it 'returns balance after most recent transaction' do
        expect(subject.balance).to eq transaction2.balance_after
      end
    end
  end

  describe '#statement' do
    let(:statement) { double(:statement) }
    it 'prints the transaction history' do
      expect(statement).to receive(:print_statement).with(transaction_history)
      subject.statement(statement)
    end
  end
 
end

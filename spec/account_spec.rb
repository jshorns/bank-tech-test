# frozen_string_literal: true

require 'account'

describe Account do
  it { is_expected.to respond_to :balance }
  it { is_expected.to respond_to :transaction_history }
  amount = '500.00'
  describe '#deposit' do
    # also - amount cannot be zero
    it 'adds money to the balance' do
      expect { subject.deposit(amount) }.to change { subject.balance }.by amount.to_f
    end
    it 'records the transaction' do
      expect(subject).to receive(:record_transaction).with(amount.to_f)
      subject.deposit(amount)
    end
    it 'fails if input is not in money format' do
      expect { subject.deposit('500.876') }.to raise_error('You must input a valid amount of money.')
    end
    it 'fails if sum is 0' do
      expect { subject.withdraw('0.00') }.to raise_error('You must specify an amount more than zero.')
    end
  end

  describe '#withdraw' do
    before { subject.deposit('600.00') }
    it 'removes money from the balance' do
      expect { subject.withdraw(amount) }.to change { subject.balance }.by(-amount.to_f)
    end
    it 'records the transaction' do
      expect(subject).to receive(:record_transaction).with(-amount.to_f)
      subject.withdraw(amount)
    end
    it 'fails if input is not in money format' do
      expect { subject.withdraw('500.876') }.to raise_error('You must input a valid amount of money.')
    end
    it 'fails if there are insufficient funds' do
      expect { subject.withdraw('610.00') }.to raise_error('You do not have sufficient funds for that transaction')
    end
    it 'fails if sum is 0' do
      expect { subject.withdraw('0.00') }.to raise_error('You must specify an amount more than zero.')
    end
  end

  describe '#statement' do
    let(:transaction_history) { double(:transaction_history) }
    subject { described_class.new(transaction_history) }
    it 'prints the transaction history' do
      expect(transaction_history).to receive(:print_statement)
      subject.statement
    end
  end
  # describe "#record_transaction" do
  # let(:transaction) { double(:transaction, :date => DateTime.now) }
  # let(:transaction_history) { double(:transaction_history) }
  # subject { described_class.new(transaction_history) }
  #  it 'adds details of the transaction' do
  #     expect(transaction).to receive(:set_amount)
  #     expect(transaction).to receive(:set_balance_after)
  #     expect(transaction_history).to receive(:add_t)
  #     subject.record_transaction(amount, transaction)
  #  end
  # end
end

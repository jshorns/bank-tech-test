require 'account'

describe Account do

    it { is_expected.to respond_to :balance }
    it { is_expected.to respond_to :t_history }
    amount = 500
    describe "#deposit" do
    #edge cases - someone tries to deposit something that isnt a number
    #also - amount cannot be zero
        it 'adds money to the balance' do
            expect { subject.deposit(amount) }.to change { subject.balance }.by amount
        end
        it 'fails if input is not a number' do
            expect { subject.deposit("hello") }.to raise_error("You must input a valid number.")
        end
    end

    describe "#withdraw" do
    # edge cases to come back to here. trying to withdraw money when there isn't enough. or do we want an overdraft function?
        it 'removes money from the balance' do
            expect { subject.withdraw(amount) }.to change { subject.balance }.by -amount
        end
        it 'fails if input is not a number' do
            expect { subject.withdraw("hello") }.to raise_error("You must input a valid number.")
        end
    end

    describe "#record_transaction" do
    let(:transaction) { double(:transaction, :date => DateTime.now) }
    let(:transaction_history) { double(:transaction_history) }
    subject { described_class.new(transaction_history) }
     it 'adds details of the transaction' do
        expect(transaction).to receive(:set_amount)
        expect(transaction).to receive(:set_balance_after)
        expect(transaction_history).to receive(:add_t)
        subject.record_transaction(amount, transaction)
     end
    end

    describe "#statement" do
        let(:transaction_history) { double(:transaction_history) }
        subject { described_class.new(transaction_history) }
        it 'prints the transaction history' do
            expect(transaction_history).to receive(:print_statement)
            subject.statement
        end
    end
end
require 'account'

describe Account do

    it { is_expected.to respond_to :balance }
    it { is_expected.to respond_to :t_history }

    describe "#deposit" do
    #edge cases - someone tries to deposit something that isnt a number
    #also - amount cannot be zero
        it 'adds money to the balance' do
            expect { subject.deposit(1000) }.to change { subject.balance }.by 1000
        end
    end

    describe "#withdraw" do
    # edge cases to come back to here. trying to withdraw money when there isn't enough. or do we want an overdraft function?
        it 'removes money from the balance' do
            expect { subject.withdraw(500) }.to change { subject.balance }.by -500
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
        subject.record_transaction(500, transaction)
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
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
            expect { subject.withdraw(-500) }.to change { subject.balance }.by -500
        end
    end

    describe "#record_transaction" do
    let(:transaction) { double(:transaction, :date => DateTime.now) }
     it 'adds transaction to the transaction history' do
        expect { subject.record_transaction(500) }.to change { subject.t_history.length }.by 1
     end
     it 'adds records details of the transaction' do
        expect(transaction).to receive(:set_amount)
        expect(transaction).to receive(:set_balance_after)
        subject.record_transaction(500, transaction)
        expect(subject.t_history).to include(transaction)
     end
    end

end
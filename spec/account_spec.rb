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

    describe '#print_transaction' do
        let(:deposit) { double(:transaction, :amount => 500.00, :deposit? => true, :withdrawal? => false, :balance_after => 1000.00, :date => DateTime.new(2021,4,6,15,56,7)) }
        let(:withdrawal) { double(:transaction, :amount => -500.00, :deposit? => false, :withdrawal? => true, :balance_after => 1000.00, :date => DateTime.new(2021,4,6,15,56,7)) }
        it 'returns a string in the specified format for withdrawals' do
            expect(subject.print_transaction(withdrawal)).to eq "06/04/2021 || || 500.00 || 1000.00"
        end
        it 'returns a string in the specified format' do
            expect(subject.print_transaction(deposit)).to eq "06/04/2021 || 500.00 || || 1000.00"
        end
    end

    describe "#print_statement" do
        let(:transaction1) { double(:transaction, :amount => 1000.00, :deposit? => true, :withdrawal? => false, :balance_after => 1000.00, :date => DateTime.new(2012,1,10,15,56,7)) }
        let(:transaction2) { double(:transaction, :amount => 2000.00, :deposit? => true, :withdrawal? => false, :balance_after => 3000.00, :date => DateTime.new(2012,1,13,15,56,7)) }
        let(:transaction3) { double(:transaction, :amount => -500.00, :deposit? => false, :withdrawal? => true, :balance_after => 2500.00, :date => DateTime.new(2012,1,14,15,56,7)) }
        
        it 'prints out the transactions in the required format' do
            subject.add_to_t_history(transaction1)
            subject.add_to_t_history(transaction2)
            subject.add_to_t_history(transaction3)
            expect(subject.print_statement).to eq "date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00\n13/01/2012 || 2000.00 || || 3000.00\n10/01/2012 || 1000.00 || || 1000.00"
        end
    end

    
end
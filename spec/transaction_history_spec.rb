require 'transaction_history'

describe TransactionHistory do
    it { is_expected.to respond_to :transactions }

    describe "#add_t" do
    let(:transaction1) { double(:transaction) }
    let(:transaction2) { double(:transaction) }
        it 'adds a transaction to the beginning of the array' do
            expect { subject.add_t(transaction1) }.to change { subject.transactions.length }.by 1
            subject.add_t(transaction1)
            subject.add_t(transaction2)
            expect(subject.transactions).to include transaction1
            expect(subject.transactions[0]).to eq transaction2
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
            subject.add_t(transaction1)
            subject.add_t(transaction2)
            subject.add_t(transaction3)
            expect(subject.print_statement).to eq "date || credit || debit || balance\n14/01/2012 || || 500.00 || 2500.00\n13/01/2012 || 2000.00 || || 3000.00\n10/01/2012 || 1000.00 || || 1000.00"
        end
    end
end
require 'transaction'

describe Transaction do
    it { is_expected.to respond_to :amount }
    it { is_expected.to respond_to :deposit? }
    it { is_expected.to respond_to :withdrawal? }
    it { is_expected.to respond_to :date }

    describe '#amount' do
    it 'is nil on initialize' do
        expect(subject.amount).to be nil
    end
    end

    describe '#set_amount' do
        it 'changes the amount of the transaction' do
            subject.set_amount(500)
            expect(subject.amount).to eq 500
        end
    end
        
end
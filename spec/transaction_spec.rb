require 'transaction'

describe Transaction do
    it { is_expected.to respond_to :amount }
    it { is_expected.to respond_to :deposit? }
    it { is_expected.to respond_to :withdrawal? }
    it { is_expected.to respond_to :date }
    it { is_expected.to respond_to :balance_after }

    describe '#amount' do
        it 'is nil on initialize' do
            expect(subject.amount).to be nil
        end
    end

    describe '#date' do
        it 'stores the date' do
            expect(subject.date).to be_an_instance_of DateTime
        end
    end

    describe '#set_amount' do
        it 'changes the amount of the transaction' do
            subject.set_amount(500)
            expect(subject.amount).to eq 500
        end
    end

    describe '#set_balance_after' do
        it 'changes the amount stored to balance_after' do
            subject.set_balance_after(1000)
            expect(subject.balance_after).to eq 1000
        end
    end

    describe '#deposit?' do
        it 'returns true if amount is above zero' do
            subject.set_amount(500)
            expect(subject.deposit?).to be true
        end
        it 'returns false if amount is below zero' do
            subject.set_amount(-500)
            expect(subject.deposit?).to be false
        end
    end

    describe '#withdrawal?' do
        it 'returns true if amount is below zero' do
            subject.set_amount(-500)
            expect(subject.withdrawal?).to be true
        end
        it 'returns false if amount is above zero' do
            subject.set_amount(500)
            expect(subject.withdrawal?).to be false
        end
    end
        
end
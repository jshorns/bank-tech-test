require 'account'

describe Account do

    it { is_expected.to respond_to :balance }

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
end
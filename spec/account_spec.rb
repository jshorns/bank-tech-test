require 'account'

describe Account do

    it { is_expected.to respond_to :balance }

    describe "#deposit" do
    # edge cases to come back to here. trying to withdraw money when there isn't enough.
        it 'adds money to the balance' do
            expect { subject.deposit(1000) }.to change { subject.balance }.by 1000
        end
    end
end
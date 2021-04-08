require 'account'
require 'date'

describe 'feature test' do
    subject { Account.new }
    date = DateTime.now.strftime("%d/%m/%Y")
    it 'meets the specifications' do
        subject.deposit("1000")
        subject.deposit("2000")
        subject.withdraw("500")
        expect(subject.statement).to eq(
        "date || credit || debit || balance\n"  +
        "#{date} || || 500.00 || 2500.00\n"  +
        "#{date} || 2000.00 || || 3000.00\n" +
        "#{date} || 1000.00 || || 1000.00"
      )
    end
end

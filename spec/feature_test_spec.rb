require 'account'
require 'date'


describe 'feature test' do
    subject { Account.new }
    date1 = DateTime.new(2012, 1, 10)
    date2 = DateTime.new(2012, 1, 13)
    date3 =  DateTime.new(2012, 1, 14)
    it 'meets the specifications' do
        subject.deposit("1000", Transaction.new(date1))
        subject.deposit("2000", Transaction.new(date2))
        subject.withdraw("500", Transaction.new(date3))
        expect(STDOUT).to receive(:puts).with(
        "date || credit || debit || balance\n"  +
        "14/01/2012 || || 500.00 || 2500.00\n"  +
        "13/01/2012 || 2000.00 || || 3000.00\n" +
        '10/01/2012 || 1000.00 || || 1000.00'
      )
      subject.statement
    end
end

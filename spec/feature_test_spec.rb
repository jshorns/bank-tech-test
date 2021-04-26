require 'account'
require 'date'


describe 'feature test' do

    subject { Account.new }
    
    it 'meets the specifications' do
        allow(DateTime).to receive(:now).and_return Date.new(2012, 1, 10)
        subject.deposit("1000")
        allow(DateTime).to receive(:now).and_return Date.new(2012, 1, 13)
        subject.deposit("2000")
        allow(DateTime).to receive(:now).and_return Date.new(2012, 1, 14)
        subject.withdraw("500")
        expect(STDOUT).to receive(:puts).with(
        "date || credit || debit || balance\n"  +
        "14/01/2012 || || 500.00 || 2500.00\n"  +
        "13/01/2012 || 2000.00 || || 3000.00\n" +
        '10/01/2012 || 1000.00 || || 1000.00'
      )
      subject.statement
    end
    
end

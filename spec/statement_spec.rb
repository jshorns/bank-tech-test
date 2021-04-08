require 'statement'
 
describe Statement do
  describe '#print_statement' do
  let(:transaction1) { double(:transaction, amount: 1000.00, deposit?: true, withdrawal?: false, balance_after: 1000.00, date: DateTime.new(2012, 1, 10)) }
  let(:transaction2) { double(:transaction, amount: 2000.00, deposit?: true, withdrawal?: false, balance_after: 3000.00, date: DateTime.new(2012, 1, 13)) }
  let(:transaction3) { double(:transaction, amount: -500.00, deposit?: false, withdrawal?: true, balance_after: 2500.00, date: DateTime.new(2012, 1, 14)) }
  let(:transaction_history) { double(:transaction_history, transactions: []) }
    it 'prints out the transactions in the required format' do
      transaction_history.transactions << transaction1
      transaction_history.transactions << transaction2
      transaction_history.transactions << transaction3
      expect(subject.print_statement(transaction_history)).to eq(
        "date || credit || debit || balance\n"  +
        "14/01/2012 || || 500.00 || 2500.00\n"  +
        "13/01/2012 || 2000.00 || || 3000.00\n" +
        '10/01/2012 || 1000.00 || || 1000.00'
      )
    end
  end
end
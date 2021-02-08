require 'account'
WITHDRAWAL_AMOUNT = 3
DEPOSIT_AMOUNT = 10

describe Account do
  include_context 'doubles'

  describe '#withdraw' do
    it 'adds transaction to transaction array' do
      allow(transaction_class_double).to receive(:new) { withdrawal_double }
      expect { subject.withdraw(WITHDRAWAL_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#deposit' do
    it 'adds transaction to transaction array' do
      allow(transaction_class_double).to receive(:new) { deposit_double }
      expect { subject.deposit(DEPOSIT_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#print_statement' do
    it 'prints transactions in reverse chronology with appropriate headings' do
      allow(transaction_class_double).to receive(:new) { deposit_double }
      subject.deposit(DEPOSIT_AMOUNT, time1)
      allow(transaction_class_double).to receive(:new) { withdrawal_double }
      subject.withdraw(WITHDRAWAL_AMOUNT, time2)
      headers = "date || credit || debit || balance\n"
      last_transaction = "11/01/2012 || || #{WITHDRAWAL_AMOUNT}.00 || #{DEPOSIT_AMOUNT - WITHDRAWAL_AMOUNT}.00\n"
      first_transaction = "10/01/2012 || #{DEPOSIT_AMOUNT}.00 || || #{DEPOSIT_AMOUNT}.00\n"
      expect { subject.print_statement }.to output(headers + last_transaction + first_transaction).to_stdout
    end
  end
end

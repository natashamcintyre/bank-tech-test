# frozen_string_literal: true

require 'account'

describe Account do
  include_context 'transaction_doubles'
  include_context 'statement_doubles'

  describe '#withdraw' do
    it 'adds transaction to transaction array' do
      allow(transaction_class_dbl).to receive(:new) { withdrawal_dbl }
      expect { subject.withdraw(WITHDRAWAL_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#deposit' do
    it 'adds transaction to transaction array' do
      allow(transaction_class_dbl).to receive(:new) { deposit_dbl }
      expect { subject.deposit(DEPOSIT_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#print_statement' do
    it 'prints transactions in reverse order with appropriate headings' do
      allow(transaction_class_dbl).to receive(:new) { deposit_dbl }
      subject.deposit(DEPOSIT_AMOUNT, time1)
      allow(transaction_class_dbl).to receive(:new) { withdrawal_dbl }
      subject.withdraw(WITHDRAWAL_AMOUNT, time2)
      expect { subject.print_statement }.to output(DESIRED_OUTPUT).to_stdout
    end
  end
end

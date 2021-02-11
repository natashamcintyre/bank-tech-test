# frozen_string_literal: true

WITHDRAWAL_AMOUNT = 3
DEPOSIT_AMOUNT = 10
YEAR = 2021
MON = '02'
DAY_1 = '08'
DAY_2 = '09'
DESIRED_OUTPUT = <<~STATEMENT
  date || credit || debit || balance
  #{DAY_2}/#{MON}/#{YEAR} || || #{WITHDRAWAL_AMOUNT}.00 || #{DEPOSIT_AMOUNT - WITHDRAWAL_AMOUNT}.00
  #{DAY_1}/#{MON}/#{YEAR} || #{DEPOSIT_AMOUNT}.00 || || #{DEPOSIT_AMOUNT}.00
STATEMENT

RSpec.shared_context 'transaction_doubles', { shared_context: :metadata } do
  let(:time1) { Time.new(YEAR, MON, DAY_1) }
  let(:time2) { Time.new(YEAR, MON, DAY_2) }
  let(:deposit_hash) { { date: time1, credit: DEPOSIT_AMOUNT, debit: '' } }
  let(:withdrawal_hash) { { date: time2, credit: '', debit: WITHDRAWAL_AMOUNT } }
  let(:deposit_dbl) do
    double :deposit, deposit?: true, amount: DEPOSIT_AMOUNT, date: time1, to_h: deposit_hash
  end
  let(:withdrawal_dbl) do
    double :withdrawal, deposit?: false, amount: WITHDRAWAL_AMOUNT, date: time2, to_h: withdrawal_hash
  end
  let(:transaction_class_dbl) { double :transaction_class }
end

RSpec.shared_context 'statement_doubles', { shared_context: :metadata } do
  let(:statement_dbl) { double :statement, display: DESIRED_OUTPUT }
  let(:statement_class_dbl) { double :statement_class, new: statement_dbl }
end

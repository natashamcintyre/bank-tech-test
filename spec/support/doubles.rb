RSpec.shared_context 'doubles', { shared_context: :metadata } do
  let(:time1) { Time.new(2012, 1, 10) }
  let(:time2) { Time.new(2012, 1, 11) }
  let(:deposit_double) { double :deposit, deposit?: true, amount: DEPOSIT_AMOUNT, date: time1 }
  let(:withdrawal_double) { double :withdrawal, deposit?: false, amount: WITHDRAWAL_AMOUNT, date: time2 }
  let(:transaction_class_double) { double :transaction_class }
  subject { Account.new(transaction_class: transaction_class_double) }
end

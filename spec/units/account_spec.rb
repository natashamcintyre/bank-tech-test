require 'account'

describe Account do
  WITHDRAWAL_AMOUNT = 3
  DEPOSIT_AMOUNT = 10
  let(:time1) { Time.new(2012, 1, 10) }
  let(:time2) { Time.new(2012, 1, 11) }
  let(:deposit_double) { double :deposit, is_deposit?: true, amount: DEPOSIT_AMOUNT, date: time1 }
  let(:withdrawal_double) { double :withdrawal, is_deposit?: false, amount: WITHDRAWAL_AMOUNT, date: time2 }
  let(:transaction_class_double) { double :transaction_class }
  subject { Account.new(transaction_class: transaction_class_double) }

  describe '#withdraw' do
    before(:each) do
      allow(transaction_class_double).to receive(:new) { withdrawal_double }
    end

    it "adds transaction to transaction array" do
      expect { subject.withdraw(WITHDRAWAL_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#deposit' do
    before(:each) do
      allow(transaction_class_double).to receive(:new) { deposit_double }
    end

    it "adds transaction to transaction array" do
      expect { subject.deposit(DEPOSIT_AMOUNT, time1) }.to change { subject.transactions.size }.by(1)
    end
  end

  describe '#print_statement' do
    before(:each) do
      allow(transaction_class_double).to receive(:new) { deposit_double }
      subject.deposit(DEPOSIT_AMOUNT, time1)
      allow(transaction_class_double).to receive(:new) { withdrawal_double }
      subject.withdraw(WITHDRAWAL_AMOUNT, time2)
    end

    it "prints transactions in reverse chronology with appropriate headings" do
      expect { subject.print_statement }.to output(
        "date || credit || debit || balance\n" +
        "11/01/2012 || || #{WITHDRAWAL_AMOUNT}.00 || #{DEPOSIT_AMOUNT-WITHDRAWAL_AMOUNT}.00\n" +
        "10/01/2012 || #{DEPOSIT_AMOUNT}.00 || || #{DEPOSIT_AMOUNT}.00\n"
        )
        .to_stdout
    end
  end
#
#   describe '#print_headings' do
#     it "prints table with headings Date, Credit, Debit and Balance" do
#       subject.print_headings
#       expect(subject.statement).to eq("date || credit || debit || balance\n")
#     end
#   end
#
#   describe '#print_transactions' do
#     it "generates string for deposit transaction (as if first transaction)" do
#       subject.print_transaction(deposit_double)
#       expect(subject.statement).to eq("10/01/2012 || 10.00 || || 10.00\n")
#     end
#
#     it "generates string for withdrawal transaction (as if first transaction)" do
#       subject.print_transaction(withdrawal_double)
#       expect(subject.statement).to eq("11/01/2012 || || 3.00 || -3.00\n")
#     end
#   end
#
#   describe '#balance_to_date' do
#     it "returns balance as 10 after initial deposit of 10" do
#       allow(transaction_class_double).to receive(:new) { deposit_double }
#       subject.deposit(DEPOSIT_AMOUNT, time1)
#       expect(subject.balance_to_date(subject.transactions[0])).to eq DEPOSIT_AMOUNT
#     end
#
#     it "returns balance as 7 after deposit of 10 and withdrawal of 3" do
#       allow(transaction_class_double).to receive(:new) { deposit_double }
#       subject.deposit(DEPOSIT_AMOUNT, time1)
#       subject.balance_to_date(subject.transactions[0])
#       allow(transaction_class_double).to receive(:new) { withdrawal_double }
#       subject.withdraw(WITHDRAWAL_AMOUNT, time1)
#       expect(subject.balance_to_date(subject.transactions[1])).to eq DEPOSIT_AMOUNT-WITHDRAWAL_AMOUNT
#     end
#   end
end

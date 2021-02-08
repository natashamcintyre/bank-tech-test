require 'transaction'

describe Transaction do
  let(:withdrawal) { Transaction.new(amount: 100, date: Time.new(2012, 01, 10), type: 'withdrawal') }
  let(:deposit) { Transaction.new(amount: 100, date: Time.new(2012, 01, 10), type: 'deposit') }
  it "stores amount" do
    expect(withdrawal.amount).to eq 100
  end

  it "stores date" do
    expect(withdrawal.date).to eq Time.new(2012, 01, 10)
  end

  describe '#is_withdrawal?' do
    it "returns true if transaction is a withdrawal" do
      expect(withdrawal.is_withdrawal?).to be true
    end

    it "returns false if transaction is not a withdrawal" do
      expect(deposit.is_withdrawal?).to be false
    end
  end

  describe '#is_deposit?' do
    it "returns true if transaction is a deposit" do
      expect(deposit.is_deposit?).to be true
    end

    it "returns false if transaction is a withdrawal" do
      expect(withdrawal.is_deposit?).to be false
    end
  end
end

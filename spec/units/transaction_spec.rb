# frozen_string_literal: true

require 'transaction'

describe Transaction do
  let(:withdrawal) { Transaction.new(amount: 100, date: Time.new(2012, 1, 10), type: :withdrawal) }
  let(:deposit) { Transaction.new(amount: 100, date: Time.new(2012, 1, 10), type: :deposit) }

  describe '#deposit?' do
    it 'returns true if transaction is a deposit' do
      expect(deposit.deposit?).to be true
    end

    it 'returns false if transaction is a withdrawal' do
      expect(withdrawal.deposit?).to be false
    end
  end

  describe '#to_h' do
    it 'for a deposit, it returns a hash with keys date, credit and debit, and values date, "" and amount' do
      deposit_hash = { date: deposit.date, credit: deposit.amount, debit: '' }
      expect(deposit.to_h).to eq deposit_hash
    end

    it 'for a withdrawal, it returns a hash with keys date, credit and debit, and values date, amount and ""' do
      withdrawal_hash = { date: withdrawal.date, credit: '', debit: withdrawal.amount }
      expect(withdrawal.to_h).to eq withdrawal_hash
    end
  end
end

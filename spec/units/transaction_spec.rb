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
end

# frozen_string_literal: true

require 'statement'

describe Statement do
  include_context 'transaction_doubles'

  let(:transactions) do
    [{ transaction: deposit_dbl, balance_after_transaction: deposit_dbl.amount },
     { transaction: withdrawal_dbl, balance_after_transaction: deposit_dbl.amount - withdrawal_dbl.amount }]
  end

  subject { described_class.new(transactions) }

  describe '#display' do
    it 'returns statement as string with headings, in reverse order and with correct balances' do
      expect(subject.display).to eq DESIRED_OUTPUT
    end
  end
end

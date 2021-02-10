# frozen_string_literal: true

require 'statement'

describe Statement do
  include_context 'transaction_doubles'

  let(:transactions) do
    [{ transaction: deposit_dbl, balance_after_transaction: deposit_dbl.amount },
     { transaction: withdrawal_dbl, balance_after_transaction: deposit_dbl.amount - withdrawal_dbl.amount }]
  end

  describe '#display' do
    it 'returns statement as string with headings, in reverse order and with correct balances' do
      expect(subject.display(transactions)).to eq DESIRED_OUTPUT
    end
  end
end

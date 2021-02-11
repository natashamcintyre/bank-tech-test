# frozen_string_literal: true

# Transaction responsible for knowing its transaction type and turning its data into a hash
class Transaction
  attr_reader :date, :amount

  def initialize(amount:, date:, type:)
    @amount = amount
    @date = date
    @type = type
  end

  def deposit?
    @type == :deposit
  end

  def to_h
    hash = { date: @date, credit: '', debit: '' }
    deposit? ? hash[:credit] = @amount : hash[:debit] = @amount
    hash
  end
end

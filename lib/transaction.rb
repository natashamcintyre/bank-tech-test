# frozen_string_literal: true

# Transaction responsible for knowing its amount, date and type (deposit or withdrawal)
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
end

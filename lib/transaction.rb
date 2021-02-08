class Transaction
  attr_reader :date, :amount

  def initialize(amount:, date:, type:)
    @amount = amount
    @date = date
    @type = type
  end

  def is_withdrawal?
    @type == 'withdrawal'
  end

  def is_deposit?
    @type == 'deposit'
  end

  private

  def type
    @type
  end
end

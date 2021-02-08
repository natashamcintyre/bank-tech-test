require 'transaction'

class Account
  attr_reader :balance, :transactions

  def initialize
    @balance = 0
    @transactions = []
  end

  def withdraw(amount, date)
    transaction = Transaction.new(amount: amount, date: date, type: 'withdrawal')
    @transactions << transaction
    @balance -= amount
  end

end

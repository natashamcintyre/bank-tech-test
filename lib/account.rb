# frozen_string_literal: true

require_relative './transaction'
require_relative './statement'

# Account class responsible for storing account transactions
class Account
  attr_reader :balance, :transactions

  def initialize(transaction_class: Transaction, statement_class: Statement)
    @balance = 0
    @transactions = []
    @transaction_class = transaction_class
    @statement_class = statement_class
  end

  def withdraw(amount, date = Time.now)
    transaction = @transaction_class.new(amount: amount, date: date, type: :withdrawal)
    add_transaction(transaction)
  end

  def deposit(amount, date = Time.now)
    transaction = @transaction_class.new(amount: amount, date: date, type: :deposit)
    add_transaction(transaction)
  end

  def print_statement
    statement = @statement_class.new
    puts statement.display(@transactions)
  end

  private

  def add_transaction(transaction)
    update_balance(transaction)
    @transactions << { transaction: transaction.to_h, balance: @balance }
  end

  def update_balance(transaction)
    transaction.deposit? ? @balance += transaction.amount : @balance -= transaction.amount
  end
end

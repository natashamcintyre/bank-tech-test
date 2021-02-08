require_relative './transaction'

# Account class responsible for storing account transactions
class Account
  attr_reader :balance, :transactions

  def initialize(transaction_class: Transaction)
    @statement_balance = 0
    @transactions = []
    @statement = ''
    @transaction_class = transaction_class
  end

  def withdraw(amount, date)
    transaction = @transaction_class.new(amount: amount, date: date, type: 'withdrawal')
    @transactions << transaction
  end

  def deposit(amount, date)
    transaction = @transaction_class.new(amount: amount, date: date, type: 'deposit')
    @transactions << transaction
  end

  def print_statement
    @statement = ''
    @transactions.each { |transaction| prepare_for_printing(transaction) }
    prepare_headings_for_printing
    puts @statement
  end

  private

  def prepare_headings_for_printing
    @statement.insert(0, "date || credit || debit || balance\n")
  end

  def prepare_for_printing(transaction)
    date = format_date(transaction.date)
    amount = format('%.2f', transaction.amount)
    balance_after_transaction = format('%.2f', cumulative_balance(transaction))
    row = if transaction.deposit?
            "#{date} || #{amount} || || #{balance_after_transaction}\n"
          else
            "#{date} || || #{amount} || #{balance_after_transaction}\n"
          end
    @statement.insert(0, row)
  end

  def cumulative_balance(transaction)
    if transaction.deposit?
      @statement_balance += transaction.amount
    else
      @statement_balance -= transaction.amount
    end
  end

  def format_date(date)
    date.strftime('%d/%m/%Y')
  end
end

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
    @transactions.each { |transaction| print_transaction(transaction) }
    print_headings
    puts @statement
  end

  private

  def print_headings
    @statement.insert(0, "date || credit || debit || balance\n")
  end

  def print_transaction(transaction)
    date = format_date(transaction.date)
    amount = format('%.2f', transaction.amount)
    cumulative_balance = format('%.2f', balance_to_date(transaction))
    row = if transaction.deposit?
            "#{date} || #{amount} || || #{cumulative_balance}\n"
          else
            "#{date} || || #{amount} || #{cumulative_balance}\n"
          end
    @statement.insert(0, row)
  end

  def balance_to_date(transaction)
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

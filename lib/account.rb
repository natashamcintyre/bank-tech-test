require_relative './transaction.rb'

class Account
  attr_reader :balance, :transactions

  def initialize(transaction_class: Transaction)
    @statement_balance = 0
    @transactions = []
    @statement = ""
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
    @transactions.each { |transaction| print_transaction(transaction) }
    print_headings
    puts statement
  end

  private

  def print_headings
    @statement.insert(0, "date || credit || debit || balance\n")
  end

  def print_transaction(transaction)
    if transaction.is_deposit?
      @statement.insert(0, "#{format_date(transaction.date)} || #{format_money(transaction.amount)} || || #{format_money(balance_to_date(transaction))}\n")
    else
      @statement.insert(0, "#{format_date(transaction.date)} || || #{format_money(transaction.amount)} || #{format_money(balance_to_date(transaction))}\n")
    end
  end

  def balance_to_date(transaction)
    if transaction.is_deposit?
      @statement_balance += transaction.amount
    else
      @statement_balance -= transaction.amount
    end
  end

  def format_date(date)
    date.strftime("%d/%m/%Y")
  end

  def format_money(amount)
    sprintf("%0.2f", amount)
  end

  def statement
    @statement
  end

end

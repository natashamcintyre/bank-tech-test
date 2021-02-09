# frozen_string_literal: true

# This class is responsible for generating the statement
class Statement
  def initialize(all_transactions)
    @all_transactions = all_transactions
  end

  def display
    statement = prepare_headers
    @all_transactions.reverse.each do |details|
      statement += prepare_transaction_row(details)
    end
    statement
  end

  private

  def prepare_headers
    "date || credit || debit || balance\n"
  end

  def prepare_transaction_row(details)
    transaction = details[:transaction]
    date_text = "#{format_date(transaction.date)} || "
    credit_or_debit_text = transaction.deposit? ? "#{transaction.amount}.00 ||" : "|| #{transaction.amount}.00"
    balance_after_transaction_text = " || #{details[:balance_after_transaction]}.00\n"
    date_text + credit_or_debit_text + balance_after_transaction_text
  end

  def format_date(date)
    date.strftime('%d/%m/%Y')
  end
end

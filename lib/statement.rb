# frozen_string_literal: true

# This class is responsible for generating the statement
class Statement
  def display(transactions)
    statement = prepare_headers(transactions[0])
    transactions.reverse.each do |details|
      statement += prepare_transaction_row(details)
    end
    statement
  end

  private

  def prepare_headers(details)
    "#{details[:transaction].keys.join(' || ')} || balance\n"
  end

  def prepare_transaction_row(details)
    transaction_hash = details[:transaction]
    transaction_hash[:balance] = details[:balance]
    formatted_transaction = formatting(transaction_hash)
    "#{formatted_transaction.join(' ||')}\n"
  end

  def formatting(transaction_hash)
    formatted = []
    transaction_hash.each_value do |value|
      formatted << format_date(value)
    end
    formatted
  end

  def format_date(value)
    return " #{format('%0.2f', value)}" if value.is_a? Numeric
    return value.strftime('%d/%m/%Y') if value.is_a? Time
  end
end

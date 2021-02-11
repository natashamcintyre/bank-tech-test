# frozen_string_literal: true

require 'account'

describe 'a feature' do
  it 'prints correct statement following series of transactions' do
    my_account = Account.new
    my_account.deposit(1000, Time.new(2012, 1, 10))
    my_account.deposit(2000, Time.new(2012, 1, 13))
    my_account.withdraw(500, Time.new(2012, 1, 14))
    desired_output = <<~STATEMENT
      date || credit || debit || balance
      14/01/2012 || || 500.00 || 2500.00
      13/01/2012 || 2000.00 || || 3000.00
      10/01/2012 || 1000.00 || || 1000.00
    STATEMENT
    expect { my_account.print_statement }.to output(desired_output).to_stdout
  end

  it 'prints correct statement if balance goes negative' do
    my_account = Account.new
    my_account.deposit(25.99, Time.new(2021, 1, 2))
    my_account.withdraw(50)
    desired_output = <<~STATEMENT
      date || credit || debit || balance
      #{Time.now.strftime('%d/%m/%Y')} || || 50.00 || -24.01
      02/01/2021 || 25.99 || || 25.99
    STATEMENT
    expect { my_account.print_statement }.to output(desired_output).to_stdout
  end
end

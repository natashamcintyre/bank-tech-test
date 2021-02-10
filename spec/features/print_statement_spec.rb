# frozen_string_literal: true

require 'account'

describe Account do
  it 'prints correct statement following series of transactions' do
    subject.deposit(100, Time.new(2021, 1, 2))
    subject.deposit(50.37, Time.new(2021, 1, 27))
    subject.withdraw(10, Time.new(2021, 2, 8))
    subject.withdraw(80.36)
    desired_output = <<~STATEMENT
      date || credit || debit || balance
      #{Time.now.strftime("%d/%m/%Y")} || || 80.36 || 60.01
      08/02/2021 || || 10.00 || 140.37
      27/01/2021 || 50.37 || || 150.37
      02/01/2021 || 100.00 || || 100.00
    STATEMENT
    expect { subject.print_statement }.to output(desired_output).to_stdout
  end

  it 'prints correct statement if balance goes negative' do
    subject.deposit(25.99, Time.new(2021, 1, 2))
    subject.withdraw(50)
    desired_output = <<~STATEMENT
      date || credit || debit || balance
      #{Time.now.strftime("%d/%m/%Y")} || || 50.00 || -24.01
      02/01/2021 || 25.99 || || 25.99
    STATEMENT
    expect { subject.print_statement }.to output(desired_output).to_stdout
  end
end

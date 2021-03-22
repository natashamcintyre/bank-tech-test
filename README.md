<h1 align=center> A Basic Account App </h1>

<h4 align=center> <a href="https://github.com/natashamcintyre/bank-tech-test/blob/main/README.md#installation">Installation</a> | <a href="https://github.com/natashamcintyre/bank-tech-test/blob/main/README.md#usage">Usage</a> | <a href="https://github.com/natashamcintyre/bank-tech-test/blob/main/README.md#testing">Testing</a> | <a href="https://github.com/natashamcintyre/bank-tech-test/blob/main/README.md#specification">Specification</a> </h4>


## Installation

Clone this repository and then run
```
$ cd bank-tech-test
$ bundle install
```

## Usage
For use in the console, eg irb. In the directory bank-tech-test:
```
$ irb -r './lib/account.rb'
2.7.0 :001 > my_account = Account.new
```
Make deposits and withdrawals using .deposit(amount, date) or .withdraw(amount, date)
```
2.7.0 :002 > my_account.deposit(500, Time.new(2021, 1, 27))
2.7.0 :003 > my_account.withdraw(100, Time.new(2021, 2, 11))
```
At any point, print your statement by running the following:
```
my_account.print_statement
```

![IRB screenshot](/images/Bank-Tech-Test-example.png)

**Note**
The statement prints as required in the [spec below](https://github.com/natashamcintyre/bank-tech-test/blob/main/README.md#acceptance-criteria).

## Testing

```
rspec
```

## Specification

### Requirements

- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance Criteria
  > **Given** a client makes a deposit of 1000 on 10-01-2012  
  > And a deposit of 2000 on 13-01-2012  
  > And a withdrawal of 500 on 14-01-2012  
  > 
  > **When** she prints her bank statement  
  > 
  > **Then** she would see  
  > date || credit || debit || balance  
  > 14/01/2012 || || 500.00 || 2500.00  
  > 13/01/2012 || 2000.00 || || 3000.00  
  > 10/01/2012 || 1000.00 || || 1000.00  

Self-assessment\
Once you have completed the challenge and feel happy with your solution, here's a form to help you reflect on the quality of your code: https://docs.google.com/forms/d/1Q-NnqVObbGLDHxlvbUfeAC7yBCf3eCjTmz6GOqC9Aeo/edit

## The Challenge
Please see the Wiki pages for details about my approach to solving the problem, the feedback I received and my next steps

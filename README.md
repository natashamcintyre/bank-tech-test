## Specification

### Requirements

- You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)
- Deposits, withdrawal.
- Account statement (date, amount, balance) printing.
- Data can be kept in memory (it doesn't need to be stored to a database or anything).

### Acceptance criteria
**Given** a client makes a deposit of 1000 on 10-01-2012
And a deposit of 2000 on 13-01-2012
And a withdrawal of 500 on 14-01-2012
**When** she prints her bank statement
**Then** she would see

date | credit | debit | balance
-|-|-|-
14/01/2012 | | 500.00 | 2500.00
13/01/2012 | 2000.00 || 3000.00
10/01/2012 | 1000.00 || 1000.00

Self-assessment
Once you have completed the challenge and feel happy with your solution, here's a form to help you reflect on the quality of your code: https://docs.google.com/forms/d/1Q-NnqVObbGLDHxlvbUfeAC7yBCf3eCjTmz6GOqC9Aeo/edit

### User Story broken down:
Client has an account: *my_account = Account.new*

Client can make deposits: *my_account.deposit(amount, date (optional) )*\
amount and date (IRL this date would be today but for this it needs setting):

Client can make withdrawals: *my_account.withdraw(amount, date (optional) )*

Client can print statement: *my_account.print_statement*\
no limit on dates needed for the requirements

Account is responsible for keeping track of account activity and balance.

Class | Account
-|-
Properties | Balance, account_activity (array of transactions)
Methods | print_statement, withdraw, deposit

Print_statement would access account_activity array and print in reverse order

Deposit class? Would have attributes amount and date.
Withdrawal class? Would have attributes amount and date.

Same attributes for 2 different classes. Perhaps an transaction class?
Transaction class? Attributes amount, date and type.

Class | Transaction
-|-
Properties | Amount, Date, Type
Methods | is_withdrawal? is_deposit?

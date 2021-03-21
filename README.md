<h1 align=center> A Basic Account App </h1>

<h4 align=center> <a href="">Installation</a> | <a href="">Usage</a> | <a href="">Testing</a> </h4>


**Installation:**

Clone this repository and then run
```
cd bank-tech-test
bundle install
```

**Testing:**

```
rspec
```

**Usage:**
For use in the console, eg irb. In the directory bank-tech-test:
```
[bank-tech-test]$ irb -r './lib/account.rb'
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
The statement prints as required in the spec below.

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

date || credit || debit || balance
14/01/2012 || || 500.00 || 2500.00
13/01/2012 || 2000.00 || || 3000.00
10/01/2012 || 1000.00 || || 1000.00

Self-assessment
Once you have completed the challenge and feel happy with your solution, here's a form to help you reflect on the quality of your code: https://docs.google.com/forms/d/1Q-NnqVObbGLDHxlvbUfeAC7yBCf3eCjTmz6GOqC9Aeo/edit

## My Approach ##
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

Hit a problem with printing the balance for each transaction. I have a few options:
- Store the balance in with the transaction:
  - pro: easy to retrieve for printing
  - con: encapsulation? Does the transaction class need to know the account balance?
- Make the balance an array which stores the updated balance after each transaction. (ie number of transactions in transaction array would equal number of balance figures in balance array):
  - pro: easy to retrieve for printing
  - cons:
    - lots of balances stored in array when value could just be calculated on the fly?
    - possible risk of balances becoming out of sync with transactions?
- Calculate balance when printing, transaction at a time, by doing previous balance +/- amount (depending on transaction type)
  - pro: perhaps a more accurate way of doing it?
  - con: makes the printing method more hefty?

Which one is best? Speed? Probably not too big a factor at this scale. Encapsulation? Code style is important. Readability and adaptability needs to be good. Will try the last one because it feels more secure.

## After initial self assessment ##

ToDo: Refactor out statement class. Calculate balances here. Consider using hash?

Class | Statement
-|-
Properties | all_transactions
Actions | display, prepare_headers, prepare_transaction_row, format_date

This took a lot of reformatting, but I feel I have got there in the end. The only bit I'm unsure about is the prepare_transaction_row method, which I think there may be a nicer way to go about. Perhaps converting each transaction into an array and using .join(" || "), or using a hash somehow?

-----------
## Feedback from first submission

Hi Natasha, thanks for submitting your Bank tech test!
This was a really good solution to the challenge! You’ve demonstrated a solid understanding of object oriented design as well as mocking. You’ve also shown that you think about trade-offs when structuring your code. Here’s my detailed feedback:
**Documentation**
- Nice README! It’s really useful to see the thought process you went through when making coding decisions.
- The comments explaining what each of your classes do are helpful and often part of company coding style guidelines -- well done!
**Object-oriented design**
- You’ve nicely separated the concerns of printing statements, keeping a transaction history and managing deposits and withdrawals from each other.
- Your code is also well encapsulated -- things that need to be private are.
- You’ve opted to have the user specify the transaction dates. Arguably this is a bit dangerous -- what if they doctor it? *I had considered this but incorrectly concluded that this was beyond the spec of the task (without writing that in my readme!). Now updated so that it is an optional argument should it need amending for any particular reason - this may still be a security issue (depending on how client intends to use app) and may need to be removed*
**Testing**
- Good job on getting 100% coverage and you’ve shown good use of mocking to isolate your unit tests!
- Consider testing some edge cases -- what if the balance becomes negative? Or what if someone deposits an amount with decimal numbers? *I misunderstood the aim of the task and was trying to duplicate the exact input as shown in the spec. Now implemented both decimals and negatives in tests*
- You’re missing a feature test that shows that all of your classes work together *I think this is now implemented although I would like to clarify structure of this with coach* *done:)*
- One could argue that by directly inspecting Account.transactions in your test, you’re testing state rather than behaviour. *I now have a question about this. If I remove these two tests, I still get 100% coverage, presumably because they are tested within the print_statement and feature tests? Does this imply these could/should be private methods? But they need to be called from outside class so can't be private. This is actually also happening if I remove the #deposit? test from transaction_spec. I am clearly testing this twice too, but where, and what is the right approach to testing here?*\
*Conclusion - 100% coverage should be for unit tests. Feature testing comes afterwards to check all classes are working together appropriately. Remember that SimpleCov isn't necessarily smart and 100% isn't everything - make sure the testing is meaningful and covers edge cases*
**Minor:**
- You could use symbols instead of strings for Transaction.type *done*
- You could make your life a little easier in prepare_transaction_row by formatting numbers using format strings. Right now your solution only works for whole integer amounts. *done*
- You don’t really need to store the transactions in an attribute of your Statement class -- you could pass them directly to the `display` method instead. It’s usually good to avoid storing unnecessary state because it’s a vector for bugs to creep in when if it gets inadvertently modified. *done*
- I feel like if you’re going to store the balance, you might as well store it inside the Transaction class just because it’s neater and easier to spot -- I had a hard time finding where it was coming from and it creates a dependency where your Statement class has implicit knowledge about how the Account class keeps a record of the balance. But regarding your reasoning in the README -- it’s true that you don’t need to store the balance separately at all thereby avoiding bugs like calculations going out of things. I think banks actually do something like that in practice.
- I see that you were trying to reduce duplication by putting your doubles in a separate helper file. This was good thinking but in tests is the one place where duplication can be helpful. It makes it easier to see what a test is actually testing and to verify that the test is doing what you want. *Whilst I did this partly to keep the code DRY, I also tried to reduce number of lines within the class because Rubocop was complaining about it. I have since researched and found some debate about this, including a suggestion that writing*
```
def method_with_too_many_lines #rubocop:disable Metrics/MethodLength
  ...
end
```
*perhaps including a reason for why you have done this, as this communicates with other devs that this has been considered and justifies your reasoning.*

The only blocker is the missing feature test. All other comments are nice to haves.  Once you’ve fixed that, feel free to resubmit for another coach review. And let me know if you have any questions about any of my comments, happy to chat. *done*

----------
NEXT STEPS

I am now looking into refactoring the Statement class as the way it processes the strings feels convoluted. My current thoughts are extracting the decision of whether the transaction is credit or debit to be the responsibility of the transaction class (perhaps it returns its details as a hash) which the Statement class can then format and 'stringify' (a technical term don't you know). Let's see if it works.

[Tech tests source](https://github.com/makersacademy/course/tree/master/individual_challenges)

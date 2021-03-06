## How to use

* These points are from my first attempt at this tech test. See below the irb screenshot for post-review comments and updates.
* This code covers basic bank account functionality. It is designed to meet the requirements and specifications detailed at the bottom of this README.
* The code can be used through IRB by requiring the 'account.rb' file.
* It is divided into 3 classes - the Account, which is designed as the user interface, for withdrawing money, depositing money, and adjusting the balance accordingly. The only user available methods should be .deposit, .withdraw and .statement in the Account class. The Transaction class records the details of the transaction. the TransactionHistory logs all transactions and prints out statements in the desired formats.
* Amounts can be deposited or withdrawn using the so-named methods. The amount should be entered as a string with maximum two decimal places (e.g. "450.00"). The decision was made to have this input as a string to enable regexp matching to check for valid inputs (inputting "54.6789", for example, will throw an error).
* Errors are also thrown if a user attempts to deposit or withdraw 0.
* An error is thrown if a user attempts to withdraw money they do not have, which could be changed or adjusted if overdraft features were desired.
* I have made 'record_transaction', which logs all the required transaction details, a private method in account. However I had previously written tests for this and I have left them in as commented in case this is not thought to be best practice.

![IRB runthrough.](/images/irb_runthrough.png "IRB runthrough")

### Post-review

* Changes made after review - printing statements extracted to a separate statement class
* More methods made private, further encapsulation.
* More detailed use of doubles in tests to ensure unit testing is totally independent, stubbing dates in feature test to ensure requirements are met.
* Making statement printing puts to STDOUT rather than simply returning a string.
* Tests are written with rspec - to run them, run bundle in the parent directory, and then run rspec.

## User stories

As a client,
so I can keep my money safe,
I want to be able to deposit my money in a bank account.

As a client,
so I can spend my money, 
I want to be able to withdraw my money from my account.

As a client,
so I can see how I'm using my money,
I want to be able to view my transaction history.

## Classes:

Account - knows how much money is stored in it. methods - deposit, withdraw, print_statement (will call a printing method on the statement class).
Transaction - knows when it was made, how much it was for (and whether it was + or -), knows what the bank balance was after. methods - .deposit? withdrawal?
Transaction history/statement - knows what transactions have been made.

## Design:

Assume bank accts are opened with a minimum starting deposit - ??500? this can be a default constant so that it can be easily changed. (actually scratch this - requirements specify the history starts with an empty balance)

Diagram.codes plan:

seq diagram
![sequence diagram.](/images/seq_diagram.png "Sequence diagram.")

```
alias client="client"
alias account="account "
alias transaction="transaction"
alias transaction_history="t_history"

account->account: "initialize w default deposit & empty t_history []"
client->account:".deposit(1000)"
account->account: "+1000 to current balance"
account->transaction: "initialise(1000, current balance, date)"
transaction->transaction: "deposit? withdrawal? based on whether int is + or -"
account->t_history: "push transaction"
client->account: ".statement"
account->t_history: "print_statement"
t_history->t_history: "putses itself to console"
```
## Requirements

You should be able to interact with your code via a REPL like IRB or the JavaScript console. (You don't need to implement a command line interface that takes input from STDIN.)

Deposits, withdrawal.

Account statement (date, amount, balance) printing.

Data can be kept in memory (it doesn't need to be stored to a database or anything).

## Acceptance criteria

Given a client makes a deposit of 1000 on 10-01-2012
And a deposit of 2000 on 13-01-2012
And a withdrawal of 500 on 14-01-2012
When she prints her bank statement
Then she would see

date || credit || debit || balance

14/01/2012 || || 500.00 || 2500.00

13/01/2012 || 2000.00 || || 3000.00

10/01/2012 || 1000.00 || || 1000.00

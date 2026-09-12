# financial-operations-support-lab

A financial database built to track the users savings, accounts, debts, and savings goals.

![Static Badge](https://img.shields.io/badge/MIT-license?label=license&labelColor=%2332CD30&color=%23A020F0&link=https%3A%2F%2Fopensource.org%2Flicense%2Fmit%2F)

## Table of Contents
- [About](#about)
- [Schema](#schema)
- [Getting Started](#getting-started)
- [Usage](#usage)
- [Configuration](#configuration)
- [Roadmap](#roadmap)
- [Author](#author)
- [License](#license)

## About
I originally built this project as a means for planning a move to Oregon. Currently it can record data manually typed into the seed file and present information in the form of SQL commands. 

## Schema
| Table | Holds | Relationships |
|-------|-------|---------------|
| `accounts` | One row per financial account — credit card, savings, investment | Parent of `transactions` and `debts` |
| `categories` | One row per financial category with directions such as - income, expense, and transfer | Parent of `transactions` |
| `merchants` | One row per merchant's normalized name along with type of merchant | Parent of `transactions` |
| `transaction_event_types` | One row per transaction type - transaction_direction, event_kind | Parent of `transactions` |
| `transactions` | One row per financial transaction containing details such as - what it is, source, and how it affects other accounts | Child of `accounts`, `categories`, `merchants`, `transaction_event_types` |
| `debts` | One row per financial debt - name, normalized_lender, status, balance | Child of `accounts` |
| `savings_goals` | One row per savings goal - name, target amount, status, current amount | None |



## Getting Started
### Prerequisites


### Installation


## Usage


## Configuration


## Roadmap


## Author
Daniel Pacheco — https://github.com/Daniel-0117

## License
![Static Badge](https://img.shields.io/badge/MIT-license?label=license&labelColor=%2332CD30&color=%23A020F0&link=https%3A%2F%2Fopensource.org%2Flicense%2Fmit%2F)


accounts
- This table represents fincial accounts where money can move in or out
- The collumns this table will need is the account_name, current_balance, opened_at, credit_limit, created_at, institution_name, account_type, is_active

categories
- This table represents the bussiness meaning of a given transaction ie groceries, rent, paycheck, etc.
- The columns of this table will consist of id, catagory_name, catagory_type, is_active

merchants
- This table represents the differnt bussiness vendors that a transaction may belong to. 
- This table will include id, merchant_name, normalized_name, merchant_type, is_active

transactions
-  This table is meant to record all the transactions that effects the accounts table. 
- The columns of this table will include the id, merchant_id(foriegn key), catagory_id(foreign key), amount, account_id(foreign key), transaction_type, created_at, posted_date, description, transaction_date, source, notes,

debts
- This table is meant to record all the debst the user currently has. Using the merchant table it also will list who the debt belongs to along with combining with the accounts if applicable
- table to show the id, debt_name, lender_name, account_id (foriegn key), original_balance, current_balance,status,minium_payment, interest rate, due_day, and date of creation. 

savings_goals
- this table is meant to record the users savings goals, such as a trip they wish to take. 
- The columnns of this table will include id, goal_name, target_amount, current_amount,status, created_at, target_date (if applicable)
-- expect: chk_accounts_account_type
-- test: account type must be checking, savings, credit, cash or investment

BEGIN;
INSERT INTO accounts (account_name, account_type, current_balance)
VALUES ('test_account', 'brokerage', 0);
ROLLBACK;

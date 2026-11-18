-- expect: chk_accounts_credit_limit
-- test: a credit limit has to be above zero

BEGIN;
INSERT INTO accounts (account_name, account_type, current_balance, credit_limit)
VALUES ('test_card', 'credit', 0, 0);
ROLLBACK;

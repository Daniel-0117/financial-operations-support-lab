-- expect: account_name_key
-- test: checks that the new account name is unique

BEGIN;
INSERT INTO accounts (account_name, account_type, institution_name, current_balance, credit_limit, opened_date, is_active)
VALUES ('main_checking_account', 'checking', 'capital_third', 300, NULL, '2026-11-12', true);
ROLLBACK;
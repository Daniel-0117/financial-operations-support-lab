-- expect: chk_accounts_limit_by_type
-- test: checks that credit accounts are not created without a credit limit

BEGIN;
INSERT INTO accounts (account_name, account_type, institution_name, current_balance, credit_limit, opened_date, is_active)
VALUES ('secondary_checking_account', 'credit', 'capital_third', 300, NULL, '2026-11-12', true);
ROLLBACK;
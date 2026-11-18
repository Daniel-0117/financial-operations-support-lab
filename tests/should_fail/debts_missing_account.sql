-- expect: debts_account_id_fkey
-- test: a debt cannot point to an account that does not exist

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day, account_id)
VALUES ('test_loan', 'test_bank', 'current', 100, 100, 10, 5, 15, 99);
ROLLBACK;

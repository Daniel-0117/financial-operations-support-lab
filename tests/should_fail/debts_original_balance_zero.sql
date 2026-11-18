-- expect: chk_original_balance_within_bounds
-- test: an original balance has to be above zero

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('test_loan', 'test_bank', 'current', 100, 0, 10, 5, 15);
ROLLBACK;

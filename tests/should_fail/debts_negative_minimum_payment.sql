-- expect: chk_min_pay_within_bounds
-- test: a minimum payment cannot be negative

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('test_loan', 'test_bank', 'current', 100, 100, -1, 5, 15);
ROLLBACK;

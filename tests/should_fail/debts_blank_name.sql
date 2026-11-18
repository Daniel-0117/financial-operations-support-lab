-- expect: chk_debt_name_not_empty
-- test: a debt name cannot be blank

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('', 'test_bank', 'current', 100, 100, 10, 5, 15);
ROLLBACK;

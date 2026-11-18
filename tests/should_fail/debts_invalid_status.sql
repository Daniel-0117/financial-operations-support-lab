-- expect: chk_debt_status
-- test: debt status must be current, delinquent, paid_off or transferred

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('test_loan', 'test_bank', 'late', 100, 100, 10, 5, 15);
ROLLBACK;

-- expect: chk_debt_name_lowercase
-- test: debt names must be stored in lowercase

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('Test_Loan', 'test_bank', 'current', 100, 100, 10, 5, 15);
ROLLBACK;

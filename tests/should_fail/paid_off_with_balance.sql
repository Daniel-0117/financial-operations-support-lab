-- expect: chk_debt_status_balance_consistency
-- test: checks balance is zero for status to be paid off

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('saphire_card', 'steam_first', 'paid_off', 500, 14, 12, 8, 5);
ROLLBACK;
-- expect: chk_due_day_within_month_bounds
-- test: checks credit payment due date stays within month

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('saphire_card', 'steam_first', 'current', 500, 14, 12, 8, 34);
ROLLBACK;
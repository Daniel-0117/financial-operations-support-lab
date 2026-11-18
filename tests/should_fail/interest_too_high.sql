-- expect: chk_interest_rate_within_bounds
-- test: checks interest rate stays below 100 limit

BEGIN;
INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day)
VALUES ('saphire_card', 'steam_first', 'current', 500, 14, 12, 120, 5);
ROLLBACK;
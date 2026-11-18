-- expect: transactions_from_account_id_fkey
-- test: money cannot come out of an account that does not exist

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id)
VALUES (25, 'expense', 'purchase', '2026-11-18', 'manual', 1, 99);
ROLLBACK;

-- expect: transactions_to_account_id_fkey
-- test: money cannot go into an account that does not exist

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, to_account_id)
VALUES (25, 'transfer', 'account_transfer', '2026-11-18', 'manual', 13, 1, 99);
ROLLBACK;

-- expect: transactions_merchant_id_fkey
-- test: a transaction cannot point to a merchant that does not exist

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, merchant_id)
VALUES (25, 'expense', 'purchase', '2026-11-18', 'manual', 1, 1, 99);
ROLLBACK;

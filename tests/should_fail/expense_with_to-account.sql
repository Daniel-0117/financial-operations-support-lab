-- expect: chk_valid_account_presence_by_transaction_direction
-- tests: checks accounts with an expense only take from one account

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, to_account_id, description, notes)
VALUES (25, 'expense', 'purchase', '2026-11-17', 'manual', 3, 1, 3, 'video game store', 'new game finally came out' );
ROLLBACK;
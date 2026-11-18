-- expect: fk_transaction_event_combination
-- test: Checks event combinations

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, description, notes)
VALUES (25, 'expense', 'refund', '2026-11-16', 'manual', 3, 1, 'place of distraction', 'New indie title came out');
ROLLBACK;
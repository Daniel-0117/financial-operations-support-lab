-- expect: chk_amount_is_positive
-- test: checks transactions amounts are only positive

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, description, notes)
VALUES (-25, 'expense', 'purchase', '2026-11-17', 'manual', 3, 1, 'video game store', 'new game finally came out' );
ROLLBACK;
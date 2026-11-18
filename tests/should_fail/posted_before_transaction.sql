-- expect: chk_posted_date_on_or_after_transaction
-- test: checks transactions amounts are only positive

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, posted_date, source, category_id, from_account_id, description, notes)
VALUES (25, 'expense', 'purchase', '2026-11-17', '2026-11-15', 'manual', 3, 1, 'video game store', 'new game finally came out' );
ROLLBACK;
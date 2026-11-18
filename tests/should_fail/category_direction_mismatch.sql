-- expect: fk_categories_direction_combinations
-- tests:  checks category direction mismatches

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, description, notes)
VALUES (25, 'expense', 'purchase', '2026-11-17', 'manual', 7, 1, 'video game store', 'new game finally came out' );
ROLLBACK;

-- expect: chk_normalized_transaction_direction
-- test: event directions must be stored in lowercase

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('Expense', 'bonus');
ROLLBACK;

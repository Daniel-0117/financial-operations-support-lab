-- expect: pk_transaction_event_types
-- test: the same direction and event kind pair cannot be added twice

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('expense', 'purchase');
ROLLBACK;

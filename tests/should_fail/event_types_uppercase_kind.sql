-- expect: chk_normalized_event_kind
-- test: event kinds must be stored in lowercase

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('expense', 'Bonus');
ROLLBACK;

-- expect: chk_transaction_direction_not_blank
-- test: an event direction cannot be blank

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('', 'bonus');
ROLLBACK;

-- expect: chk_event_kind_not_blank
-- test: an event kind cannot be blank

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('expense', '');
ROLLBACK;

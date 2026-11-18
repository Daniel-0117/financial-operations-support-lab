-- expect: chk_transaction_direction_values
-- test: an event direction must be expense, transfer or income

BEGIN;
INSERT INTO transaction_event_types (transaction_direction, event_kind)
VALUES ('outflow', 'bonus');
ROLLBACK;

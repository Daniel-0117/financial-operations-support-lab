-- expect: chk_distinct_transfer_accounts
-- test: checks to ensure a transfer cannot occur within the same account

BEGIN;
INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, source, category_id, from_account_id, to_account_id, description)
VALUES (25, 'transfer', 'account_transfer', '2026-11-17', 'manual', 13, 1, 1, 'moving money around' );
ROLLBACK;
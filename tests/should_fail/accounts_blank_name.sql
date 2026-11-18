-- expect: chk_account_name_not_blank
-- test: an account name cannot be blank

BEGIN;
INSERT INTO accounts (account_name, account_type, current_balance)
VALUES ('', 'checking', 0);
ROLLBACK;

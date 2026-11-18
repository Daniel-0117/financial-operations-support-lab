-- expect: chk_category_direction
-- test: category direction must be income, expense or transfer

BEGIN;
INSERT INTO categories (category_name, category_direction)
VALUES ('rent', 'outflow');
ROLLBACK;

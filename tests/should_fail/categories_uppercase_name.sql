-- expect: chk_category_name_lowercase
-- test: category names must be stored in lowercase

BEGIN;
INSERT INTO categories (category_name, category_direction)
VALUES ('Rent', 'expense');
ROLLBACK;

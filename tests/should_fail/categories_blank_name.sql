-- expect: chk_category_name_not_blank
-- test: a category name cannot be blank

BEGIN;
INSERT INTO categories (category_name, category_direction)
VALUES ('', 'expense');
ROLLBACK;

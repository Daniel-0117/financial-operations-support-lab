-- expect: categories_category_name_key
-- test: two categories cannot share a name

BEGIN;
INSERT INTO categories (category_name, category_direction)
VALUES ('groceries', 'expense');
ROLLBACK;

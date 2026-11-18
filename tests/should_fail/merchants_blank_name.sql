-- expect: chk_merchant_name_not_blank
-- test: a merchant name cannot be blank

BEGIN;
INSERT INTO merchants (merchant_name, merchant_type)
VALUES ('', 'retailer');
ROLLBACK;

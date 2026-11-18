-- expect: chk_merchant_type
-- test: merchant type must be one of the nine allowed types

BEGIN;
INSERT INTO merchants (merchant_name, merchant_type)
VALUES ('test_shop', 'restaurant');
ROLLBACK;

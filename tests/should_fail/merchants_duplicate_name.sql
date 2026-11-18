-- expect: merchants_normalized_name_key
-- test: a merchant cannot be added twice just by changing its capitals or spacing

BEGIN;
INSERT INTO merchants (merchant_name, merchant_type)
VALUES ('  Albertsons ', 'retailer');
ROLLBACK;

-- expect: chk_savings_is_fulfilled
-- test: checks balance matches goal before stating fulfilled

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, current_amount, target_date, status)
VALUES ('sweden', 12000, 100, '2028-01-05', 'fulfilled');
ROLLBACK;
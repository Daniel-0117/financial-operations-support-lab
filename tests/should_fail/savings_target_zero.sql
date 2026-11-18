-- expect: chk_target_amount_within_bounds
-- test: a goal target has to be above zero

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, status)
VALUES ('test_goal', 0, 'current');
ROLLBACK;

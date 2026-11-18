-- expect: chk_current_amount_within_bounds
-- test: the amount saved so far cannot be negative

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, current_amount, status)
VALUES ('test_goal', 1000, -1, 'current');
ROLLBACK;

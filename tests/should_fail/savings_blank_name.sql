-- expect: chk_goal_name_not_blank
-- test: a goal name cannot be blank

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, status)
VALUES ('', 1000, 'current');
ROLLBACK;

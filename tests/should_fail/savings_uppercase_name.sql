-- expect: chk_goal_name_lowercase
-- test: goal names must be stored in lowercase

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, status)
VALUES ('Test_Goal', 1000, 'current');
ROLLBACK;

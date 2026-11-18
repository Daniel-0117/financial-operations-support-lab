-- expect: savings_goals_goal_name_key
-- test: two savings goals cannot share a name

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, status)
VALUES ('oregon', 1000, 'current');
ROLLBACK;

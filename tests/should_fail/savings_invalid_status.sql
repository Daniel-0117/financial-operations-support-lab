-- expect: chk_savings_goals_status
-- test: goal status must be current, behind, fulfilled or shelved

BEGIN;
INSERT INTO savings_goals (goal_name, target_amount, status)
VALUES ('test_goal', 1000, 'paused');
ROLLBACK;

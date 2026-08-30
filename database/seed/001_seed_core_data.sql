INSERT INTO accounts (account_name, account_type, institution_name, current_balance, credit_limit, opened_date, is_active) VALUES
    ('main_checking_account', 'checking', 'chase', 83.45, NULL, '2019-03-12', true),
    ('toms_savings_account', 'savings', 'wells_fargo', 1005.34, NULL, '2021-08-04', true),
    ('ruby_card', 'credit', 'capital_second', 351, 12000, '2023-11-19', true),
    ('held_cash', 'cash', 'personal_safe', 860, NULL, NULL, true),
    ('portfolio', 'investment', 'fidelity', 9600, NULL, '2024-02-27', true),
    ('levy_card', 'credit', 'personal_1', 0, 1300, '2016-05-12', false)
    ;
INSERT INTO categories (category_name, category_direction) VALUES
    ('groceries', 'expense'),
    ('gas', 'expense'),
    ('video_game', 'expense'),
    ('laundry', 'expense'),
    ('clothes_shopping', 'expense'),
    ('utility_bill', 'expense'),
    ('paycheck', 'income'),
    ('investment', 'income'),
    ('tip', 'income'),
    ('savings_account', 'transfer'),
    ('uncategorized_income', 'income'),
    ('uncategorized_expense', 'expense'),
    ('uncategorized_transfer', 'transfer'),
    ('refund', 'income'),
    ('eating_out', 'expense'),
    ('interest_income', 'income')
    ;

INSERT INTO merchants (merchant_name, merchant_type) VALUES
    ('albertsons', 'retailer'),
    ('strong_man_movers', 'service_provider'),
    ('showmans_hvac', 'service_provider'),
    ('Tucson_medical_center', 'healthcare_provider'),
    ('safeway', 'employer'),
    ('Gary', 'individual'),
    ('paintball', 'other'),
    ('rageroom', 'other'),
    ('windows_and_doors', 'retailer'),
    ('quicktrip', 'retailer'),
    ('tucson_electric_power', 'service_provider'),
    ('tonys_glorious_pizza', 'retailer')
    ;

INSERT INTO transaction_event_types (transaction_direction, event_kind, description) VALUES
    ('expense','purchase','Bought goods or services from a merchant.'),
    ('expense','fee', 'A charge for holding or using an account, not for anything received.'),
    ('expense',  'interest_charge', 'Interest accrued on a borrowed balance.'),
    ('expense','withdrawal', 'Cash taken out of an account.'),
    ('expense','debt_payment', 'Money sent to a lender against an outstanding balance.'),
    ('income', 'deposit',  'Money placed into an account.'),
    ('income','refund','Money returned by a merchant for a prior purchase.'),
    ('income','interest_earned', 'Interest paid to me on a balance held.'),
    ('transfer', 'account_transfer','Money moved between two accounts I own.'),
    ('transfer', 'debt_payment', 'Money sent to a credit account I own against its balance')
    ;

INSERT INTO savings_goals (goal_name, target_amount, current_amount, target_date, status) VALUES
    ('oregon', 8000, 3257, '2027-05-29', 'current'),
    ('japan_trip', 1800, 12, '2027-07-13', 'behind'),
    ('house_down_payment', 210000, 0, NULL, 'behind'),
    ('emergency_fund', 1000, 1000, '2026-07-15', 'fulfilled')
    ;

WITH d (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day, account_name) AS (VALUES
        ('car_debt', 'capital_three', 'delinquent', 45000, 47250, 350, 2, 24, NULL),
        ('ruby_card', 'capital_second', 'current', 351, 500, 25, 15, 12, 'ruby_card'),
        ('mortgage', 'america_first', 'paid_off', 0, 650000, 1250, 8, 1, NULL)
    )
    INSERT INTO debts (debt_name, lender_name, status, current_balance, original_balance, minimum_payment, interest_rate, due_day, account_id)
    SELECT  d.debt_name, d.lender_name, d.status, d.current_balance, d.original_balance, d.minimum_payment, d.interest_rate, d.due_day, a.id
    FROM d
    LEFT JOIN accounts a ON d.account_name = a.account_name
    ;


WITH t (amount, transaction_direction, event_kind, transaction_date, posted_date, source, category_name, from_account_name, to_account_name, merchant_name, description, notes) AS (VALUES
        (45.0, 'expense', 'purchase', '2026-07-15', '2026-07-16', 'manual', 'eating_out', 'main_checking_account', NULL, NULL, 'dinner from new burger joint on oracle.', NULL),
        (112.47, 'expense', 'purchase', '2026-05-03', '2026-05-04', 'manual', 'groceries', 'main_checking_account', NULL, 'albertsons', 'weekly shop', NULL),
        (88.12, 'expense', 'purchase', '2026-05-19', '2026-05-20', 'manual', 'groceries', 'main_checking_account', NULL, 'albertsons', 'weekly shop', NULL),
        (134.9, 'expense', 'purchase', '2026-06-02', '2026-06-03', 'manual', 'groceries', 'main_checking_account', NULL, 'safeway', 'restock after payday', NULL),
        (76.55, 'expense', 'purchase', '2026-06-21', '2026-06-22', 'manual', 'groceries', 'ruby_card', NULL, 'albertsons', 'weekly shop', NULL),
        (101.03, 'expense', 'purchase', '2026-07-06', '2026-07-07', 'manual', 'groceries', 'main_checking_account', NULL, 'albertsons', 'weekly shop', NULL),
        (59.88, 'expense', 'purchase', '2026-07-24', '2026-07-25', 'manual', 'groceries', 'held_cash', NULL, 'safeway', 'quick trip, paid cash', NULL),
        (18.25, 'expense', 'purchase', '2026-05-11', '2026-05-12', 'manual', 'eating_out', 'held_cash', NULL, 'tonys_glorious_pizza', 'lunch during shift', NULL),
        (32.6, 'expense', 'purchase', '2026-06-08', '2026-06-09', 'manual', 'eating_out', 'ruby_card', NULL, NULL, 'dinner out', NULL),
        (9.75, 'expense', 'purchase', '2026-06-27', '2026-06-28', 'manual', 'eating_out', 'held_cash', NULL, NULL, 'coffee and a sandwich', NULL),
        (54.1, 'expense', 'purchase', '2026-07-19', '2026-07-20', 'manual', 'eating_out', 'ruby_card', NULL, NULL, 'dinner with friends', NULL),
        (41.2, 'expense', 'purchase', '2026-05-07', '2026-05-08', 'manual', 'gas', 'ruby_card', NULL, 'quicktrip', 'fill up', NULL),
        (38.95, 'expense', 'purchase', '2026-05-28', '2026-05-29', 'manual', 'gas', 'ruby_card', NULL, 'quicktrip', 'fill up', NULL),
        (44.6, 'expense', 'purchase', '2026-06-16', '2026-06-17', 'manual', 'gas', 'ruby_card', NULL, 'quicktrip', 'fill up', NULL),
        (43.15, 'expense', 'purchase', '2026-07-11', '2026-07-12', 'manual', 'gas', 'ruby_card', NULL, 'quicktrip', 'fill up', NULL),
        (147.8, 'expense', 'purchase', '2026-05-05', '2026-05-07', 'manual', 'utility_bill', 'main_checking_account', NULL, 'tucson_electric_power', 'electric', 'summer rates climbing'),
        (163.22, 'expense', 'purchase', '2026-06-05', '2026-06-08', 'manual', 'utility_bill', 'main_checking_account', NULL, 'tucson_electric_power', 'electric', NULL),
        (189.04, 'expense', 'purchase', '2026-07-05', '2026-07-07', 'manual', 'utility_bill', 'main_checking_account', NULL, 'tucson_electric_power', 'electric', 'july is brutal'),
        (320.0, 'expense', 'purchase', '2026-05-22', '2026-05-23', 'manual', 'uncategorized_expense', 'main_checking_account', NULL, 'showmans_hvac', 'ac tune-up before summer', NULL),
        (85.0, 'expense', 'purchase', '2026-06-13', '2026-06-14', 'manual', 'uncategorized_expense', 'main_checking_account', NULL, 'Tucson_medical_center', 'copay', NULL),
        (240.0, 'expense', 'purchase', '2026-07-02', '2026-07-03', 'manual', 'uncategorized_expense', 'ruby_card', NULL, 'windows_and_doors', 'replacement screen door', NULL),
        (69.99, 'expense', 'purchase', '2026-05-30', '2026-05-31', 'manual', 'video_game', 'ruby_card', NULL, NULL, 'preorder', NULL),
        (29.99, 'expense', 'purchase', '2026-07-09', '2026-07-10', 'manual', 'video_game', 'ruby_card', NULL, NULL, 'sale purchase', NULL),
        (55.0, 'expense', 'purchase', '2026-06-14', '2026-06-15', 'manual', 'uncategorized_expense', 'held_cash', NULL, 'paintball', 'saturday with the group', NULL),
        (120.0, 'expense', 'purchase', '2026-05-16', '2026-05-17', 'manual', 'uncategorized_expense', 'main_checking_account', NULL, 'strong_man_movers', 'helped move a couch', NULL),
        (22.0, 'expense', 'purchase', '2026-05-25', '2026-05-26', 'manual', 'laundry', 'held_cash', NULL, NULL, 'laundromat', NULL),
        (24.5, 'expense', 'purchase', '2026-06-29', '2026-06-30', 'manual', 'laundry', 'held_cash', NULL, NULL, 'laundromat', NULL),
        (35.0, 'expense', 'fee', '2026-06-18', '2026-06-19', 'manual', 'uncategorized_expense', 'ruby_card', NULL, NULL, 'late fee', 'missed the due date by a day'),
        (18.44, 'expense', 'interest_charge', '2026-07-01', '2026-07-01', 'system', 'uncategorized_expense', 'ruby_card', NULL, NULL, 'monthly interest accrual', NULL),
        (60.0, 'expense', 'withdrawal', '2026-06-24', '2026-06-24', 'manual', 'uncategorized_expense', 'main_checking_account', NULL, NULL, 'atm withdrawal', NULL),
        (250.0, 'expense', 'debt_payment', '2026-07-12', '2026-07-14', 'manual', 'uncategorized_expense', 'main_checking_account', NULL, NULL, 'payment toward car loan', NULL),
        (27.31, 'expense', 'purchase', '2026-07-21', '2026-07-22', 'csv_import', 'uncategorized_expense', 'ruby_card', NULL, NULL, 'POS DEBIT 4829', NULL),
        (14.99, 'expense', 'purchase', '2026-07-23', '2026-07-24', 'csv_import', 'uncategorized_expense', 'ruby_card', NULL, NULL, 'SQ *A8F2K', NULL),
        (1180.44, 'income', 'deposit', '2026-05-08', '2026-05-08', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly', NULL),
        (1204.1, 'income', 'deposit', '2026-05-22', '2026-05-22', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly', NULL),
        (1166.88, 'income', 'deposit', '2026-06-05', '2026-06-05', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly', NULL),
        (1241.02, 'income', 'deposit', '2026-06-19', '2026-06-19', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly, picked up a shift', NULL),
        (1189.73, 'income', 'deposit', '2026-07-03', '2026-07-03', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly', NULL),
        (1215.6, 'income', 'deposit', '2026-07-17', '2026-07-17', 'manual', 'paycheck', NULL, 'main_checking_account', 'safeway', 'biweekly', NULL),
        (40.0, 'income', 'deposit', '2026-06-11', '2026-06-11', 'manual', 'tip', NULL, 'held_cash', 'Gary', 'paid me back and rounded up', NULL),
        (25.0, 'income', 'deposit', '2026-07-08', '2026-07-08', 'manual', 'tip', NULL, 'held_cash', NULL, 'side cash', NULL),
        (6.12, 'income', 'interest_earned', '2026-07-01', '2026-07-01', 'system', 'interest_income', NULL, 'toms_savings_account', NULL, 'monthly interest', NULL),
        (31.8, 'income', 'refund', '2026-06-26', '2026-06-28', 'manual', 'refund', NULL, 'ruby_card', 'albertsons', 'returned an item', NULL),
        (52.0, 'income', 'deposit', '2026-07-26', '2026-07-27', 'bank_import', 'uncategorized_income', NULL, 'main_checking_account', NULL, 'ACH CREDIT UNKNOWN', NULL),
        (300.0, 'transfer', 'account_transfer', '2026-05-09', '2026-05-09', 'manual', 'savings_account', 'main_checking_account', 'toms_savings_account', NULL, 'payday transfer', NULL),
        (300.0, 'transfer', 'account_transfer', '2026-06-06', '2026-06-06', 'manual', 'savings_account', 'main_checking_account', 'toms_savings_account', NULL, 'payday transfer', NULL),
        (150.0, 'transfer', 'account_transfer', '2026-07-18', '2026-07-18', 'manual', 'savings_account', 'main_checking_account', 'held_cash', NULL, 'cash for the week', NULL),
        (72.40, 'expense', 'purchase', '2026-05-14', '2026-05-15', 'manual', 'clothes_shopping', 'levy_card', NULL, NULL, 'work shirts and a pair of jeans', NULL),
        (36.80, 'expense', 'purchase', '2026-05-27', '2026-05-28', 'manual', 'gas', 'levy_card', NULL, 'quicktrip', 'fill up', NULL),
        (12.50, 'expense', 'interest_charge', '2026-06-01', '2026-06-01', 'system', 'uncategorized_expense', 'levy_card', NULL, NULL, 'monthly interest accrual', 'carried a balance while deciding whether to close it'),
        (121.70, 'transfer', 'debt_payment', '2026-06-22', '2026-06-23', 'manual', 'uncategorized_transfer', 'main_checking_account', 'levy_card', NULL, 'paid off levy card before closing it', NULL)
    )
    INSERT INTO transactions (amount, transaction_direction, event_kind, transaction_date, posted_date, source, category_id, from_account_id, to_account_id, merchant_id, description, notes)
    SELECT t.amount, t.transaction_direction, t.event_kind, t.transaction_date::date, t.posted_date::date, t.source, ca.id, fro.id, too.id, mer.id, t.description, t.notes
    FROM t
    LEFT JOIN categories ca ON t.category_name = ca.category_name
    LEFT JOIN accounts fro ON t.from_account_name = fro.account_name
    LEFT JOIN accounts too ON t.to_account_name = too.account_name
    LEFT JOIN merchants mer ON lower(BTRIM(t.merchant_name)) = mer.normalized_name
    ;
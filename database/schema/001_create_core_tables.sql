CREATE TABLE accounts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name VARCHAR(150) UNIQUE 
        NOT NULL
        CONSTRAINT chk_account_name_not_blank
            CHECK (
                BTRIM(account_name) <> ''
            )
        CONSTRAINT chk_account_name_lower_case
            CHECK (
                account_name = lower(BTRIM(account_name))
            ),
    account_type VARCHAR(150) NOT NULL,
    institution_name VARCHAR(150),
    current_balance NUMERIC(12, 2) NOT NULL,
    credit_limit NUMERIC(12, 2),
    opened_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,

    CONSTRAINT chk_accounts_account_type
        CHECK (
            account_type IN (
                'checking',
                'savings',
                'credit',
                'cash',
                'investment'
            )
        ),

    CONSTRAINT chk_accounts_credit_limit
        CHECK (
            credit_limit IS NULL OR credit_limit > 0
        ),
    
    CONSTRAINT chk_accounts_credit_limit_by_type
        CHECK(
            (
                account_type = 'credit'
                AND credit_limit IS NOT NULL
            )
            OR
            (
                account_type <> 'credit'
                AND credit_limit IS NULL
            )
        )
);

     

CREATE TABLE categories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(150) UNIQUE 
        NOT NULL
        CONSTRAINT chk_category_name_not_blank
            CHECK  (
                BTRIM(category_name) <> ''
            )
        CONSTRAINT chk_category_name_lowercase
            CHECK (
               category_name = lower(BTRIM(category_name))
            ),
    category_direction VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,

    CONSTRAINT chk_category_direction
        CHECK (
            category_direction IN (
                'income',
                'expense',
                'transfer'
            )
        ),

    CONSTRAINT uq_categories_id_direction
        UNIQUE (id, category_direction)
);

CREATE TABLE merchants (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name VARCHAR(150) NOT NULL,
    normalized_name VARCHAR(150)
        GENERATED ALWAYS AS (lower(BTRIM(merchant_name))) STORED 
        UNIQUE NOT NULL,
    merchant_type VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    
   
    CONSTRAINT chk_merchant_type
        CHECK (
            merchant_type IN (
                'retailer',
                'service_provider',
                'employer',
                'government',
                'financial_institution',
                'healthcare_provider',
                'individual',
                'other',
                'unknown'
            )
        ),

    CONSTRAINT chk_merchant_name_not_blank
        CHECK (
            BTRIM(merchant_name) <> ''
        )
);

CREATE TABLE transaction_event_types (
    transaction_direction VARCHAR(150) 
        NOT NULL
        CONSTRAINT chk_transaction_direction_not_blank
            CHECK (
                BTRIM(transaction_direction) <> ''
            )
        CONSTRAINT chk_normalized_transaction_direction
            CHECK  (transaction_direction = lower(BTRIM(transaction_direction))),
    event_kind VARCHAR(40) 
        NOT NULL
        CONSTRAINT chk_event_kind_not_blank
            CHECK (
                BTRIM(event_kind) <> ''
            )
        CONSTRAINT chk_normalized_event_kind
            CHECK (event_kind = lower(BTRIM(event_kind))),
    description TEXT,

    CONSTRAINT chk_transaction_direction_values
        CHECK (
            transaction_direction IN (
                'expense',
                'transfer',
                'income'
            )
        ),

    CONSTRAINT pk_transaction_event_types
        PRIMARY KEY (
            transaction_direction,
            event_kind
        )
    
);


CREATE TABLE transactions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,

    amount NUMERIC(12,2)
        NOT NULL
        CONSTRAINT chk_amount_is_positive
            CHECK (
                amount > 0
            ),
    transaction_direction VARCHAR(150) NOT NULL,
    event_kind VARCHAR(40) NOT NULL,
    description TEXT,
    transaction_date DATE NOT NULL,

    source VARCHAR(150)
        NOT NULL
        CONSTRAINT chk_source
            CHECK (
                source IN (
                    'manual',
                    'csv_import',
                    'bank_import',
                    'system'
                )
            ),
    notes TEXT,
    posted_date DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    merchant_id INT REFERENCES merchants(id),
    category_id INT NOT NULL,
    from_account_id INT REFERENCES accounts(id),
    to_account_id INT REFERENCES accounts(id),

    CONSTRAINT chk_posted_date_on_or_after_transaction_date
        CHECK (
            posted_date IS NULL
            OR posted_date >= transaction_date
        ),    

    CONSTRAINT fk_transaction_event_combination 
        FOREIGN KEY (transaction_direction, event_kind) 
        REFERENCES transaction_event_types (transaction_direction, event_kind),

    CONSTRAINT chk_valid_account_presence_by_transaction_direction
        CHECK (
            (
                transaction_direction = 'expense' 
                AND from_account_id IS NOT NULL
                AND to_account_id IS NULL
            )
            OR
            (
                transaction_direction = 'income'
                AND from_account_id IS NULL
                AND to_account_id IS NOT NULL
            )
            OR
            (
                transaction_direction = 'transfer'
                AND from_account_id IS NOT NULL
                AND to_account_id IS NOT NULL
            )
        ),
    CONSTRAINT chk_distinct_transfer_accounts
        CHECK (
            (from_account_id IS NULL OR to_account_id IS NULL)
            OR
            (from_account_id IS DISTINCT FROM to_account_id)
        ),
        
    CONSTRAINT fk_categories_direction_combinations
        FOREIGN KEY (category_id, transaction_direction)
        REFERENCES categories (id, category_direction)
);


CREATE TABLE debts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    debt_name VARCHAR(150) 
        NOT NULL
        CONSTRAINT chk_debt_name_not_empty
            CHECK (
                BTRIM(debt_name) <> ''
            )
        CONSTRAINT chk_debt_name_lowercase
            CHECK (
                debt_name = lower(BTRIM(debt_name))
            ),
    lender_name VARCHAR(150) 
        NOT NULL
        CONSTRAINT chk_lender_name_not_empty
            CHECK (
                BTRIM(lender_name) <> ''
            ),
    normalized_lender_name VARCHAR(150)
        GENERATED ALWAYS AS (lower(BTRIM(lender_name))) STORED 
        NOT NULL,
    status VARCHAR(50) NOT NULL,
    current_balance NUMERIC(12,2) NOT NULL,
    original_balance NUMERIC(12,2)
        NOT NULL 
        CONSTRAINT chk_original_balance_within_bounds
            CHECK (original_balance > 0),
    minimum_payment NUMERIC(12,2)
        NOT NULL 
        CONSTRAINT chk_min_pay_within_bounds
            CHECK (minimum_payment >= 0),
    interest_rate NUMERIC(5,2) 
        NOT NULL
        CONSTRAINT chk_interest_rate_within_bounds
            CHECK (interest_rate >= 0 AND interest_rate <= 100),
    due_day SMALLINT 
        NOT NULL
        CONSTRAINT chk_due_day_within_month_bounds
            CHECK (due_day >= 1 AND due_day <= 31),
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    account_id INT UNIQUE REFERENCES accounts(id),

 CONSTRAINT chk_debt_status_balance_consistency
    CHECK (
        (
            status IN ('current', 'delinquent')
            AND current_balance > 0
        )
        OR
        (
            status IN ('paid_off', 'transferred')
            AND current_balance = 0
        )
    ),

    CONSTRAINT chk_debt_status
        CHECK (
            status IN (
                'current',
                'delinquent',
                'paid_off',
                'transferred'
            )
        )
    
);

CREATE TABLE savings_goals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    goal_name VARCHAR(150) UNIQUE 
        NOT NULL
        CONSTRAINT chk_goal_name_not_blank
            CHECK (
                BTRIM(goal_name) <> ''
            )
        CONSTRAINT chk_goal_name_lowercase
            CHECK (
                goal_name = lower(BTRIM(goal_name))
            ),
    target_amount NUMERIC(12,2) 
        NOT NULL
        CONSTRAINT chk_target_amount_within_bounds
            CHECK (target_amount > 0),
    current_amount NUMERIC(12,2) DEFAULT 0
        NOT NULL
        CONSTRAINT chk_current_amount_within_bounds
            CHECK (current_amount >= 0),
    status VARCHAR(50) 
        NOT NULL
        CONSTRAINT chk_savings_goals_status
            CHECK (
                status IN (
                    'current',
                    'behind',
                    'fulfilled',
                    'shelved'
                )
            ),
    target_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,

    CONSTRAINT chk_savings_is_fulfilled
        CHECK (
            (
                status = 'fulfilled'
                AND current_amount >= target_amount
            )
            OR 
            (
                status IN ('current', 'behind', 'shelved')
            )
        )

);
  

CREATE INDEX idx_transactions_merchant_id ON transactions (merchant_id);
CREATE INDEX idx_transactions_from_account_id ON transactions (from_account_id);
CREATE INDEX idx_transactions_to_account_id ON transactions (to_account_id);
CREATE INDEX idx_transactions_category_direction ON transactions (category_id, transaction_direction);
CREATE INDEX idx_transactions_event_type ON transactions (transaction_direction, event_kind);
CREATE TABLE accounts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name VARCHAR(150) 
        NOT NULL
        CONSTRAINT chk_account_name_not_blank
            CHECK (
                BTRIM(account_name) <> ''
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
    
    CONSTRAINT chk_accounts_current_balance
        CHECK (
            current_balance >= 0
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
    category_name VARCHAR(150) UNIQUE NOT NULL,
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
        )
);

CREATE TABLE merchants (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name VARCHAR(150) NOT NULL,
    normalized_name VARCHAR(150)
        GENERATED ALWAYS AS (lower(trim(merchant_name))) STORED 
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
            CHECK  lower(transaction_direction),
    event_kind VARCHAR(40) 
        NOT NULL
        CONSTRAINT chk_event_kind_not_blank
            CHECK (
                BTRIM(event_kind) <> ''
            )
        CONSTRAINT chk_normalized_event_kind
            CHECK lower(event_kind),
    description TEXT,

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
    category_id INT REFERENCES categories(id),
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
            from_account_id <> to_account_id
        )
);


CREATE TABLE debts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    debt_name VARCHAR(150) NOT NULL,
    lender_name VARCHAR(150) NOT NULL,
    status VARCHAR(50) NOT NULL,
    current_balance NUMERIC(12,2) NOT NULL,
    original_balance NUMERIC(12,2) 
        CHECK (original_balance >= 0),
    minimum_payment NUMERIC(12,2) 
        CHECK (minimum_payment >= 0),
    interest_rate DECIMAL(5,2) NOT NULL,
    due_day DATE NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    account_id INT REFERENCES accounts(id),

    chk_interest_rate (
        CHECK (
            interest_rate >= 0
        )
    ), 

    chk_current_balance (
        CHECK (
            current_balance >= 0
        )
    ),

    chk_status (
        CHECK (
            status IN (
                'current',
                'delinquent',
                'paid_off',
                'transferred'
            )
        )
    )
);

CREATE TABLE savings_goals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    goal_name VARCHAR(150) UNIQUE NOT NULL,
    target_amount NUMERIC(12,2) NOT NULL,
    current_amount NUMERIC(12,2) NOT NULL,
    status VARCHAR(150) NOT NULL,
    target_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL

);
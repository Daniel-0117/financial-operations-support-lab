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


CREATE TABLE transactions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMERIC(12,2) 
        NOT NULL
        CONSTRAINT chk_amount_is_positive 
            CHECK (amount > 0),
    transaction_direction VARCHAR(150) NOT NULL,
    event_kind VARCHAR(40) 
        NOT NULL
        CONSTRAINT chk_event_kind
            CHECK (
                event_kind IN (
                    'purchase',
                    'payroll',
                    'refund',
                    'fee',
                    'transfer'
                )
            ),

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
    account_id INT NOT NULL REFERENCES accounts(id),

    CONSTRAINT chk_transaction_direction
        CHECK (
            transaction_direction IN (
                'income',
                'expense',
                'transfer'
            )
        ),

    CONSTRAINT chk_posted_date_on_or_after_transaction_date
        CHECK (
            posted_date IS NULL OR posted_date >= transaction_date
        ),

    
    
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
CREATE TABLE accounts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name VARCHAR(150) NOT NULL,
    account_type VARCHAR(150) NOT NULL,
    institution_name VARCHAR(150),
    current_balance NUMERIC(12,2) NOT NULL,
    credit_limit NUMERIC(12,2),
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
            credit_limit IS NULL
            OR credit_limit >= 0
        )
);


CREATE TABLE categories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(150) UNIQUE NOT NULL,
    category_type VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,

    CONSTRAINT chk_categories_category_type
        CHECK (
            category_type IN (
                'income',
                'expense',
                'transfer'
            )
        )
);


CREATE TABLE merchants (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name VARCHAR(150) NOT NULL,
    normalized_name VARCHAR(150) UNIQUE NOT NULL,
    merchant_type VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,

    CONSTRAINT chk_merchants_merchant_type
        CHECK (
            merchant_type IN (
                'retailer',
                'service_provider',
                'financial_institution',
                'employer',
                'government',
                'healthcare_provider',
                'individual',
                'other',
                'unknown'
            )
        ),
    
    CONSTRAINT chk_merchants_name_not_blank
        CHECK (
            BTRIM(merchant_name) <> ''
        ),

    CONSTRAINT chk_merchants_normalized_name_not_blank
        CHECK (
            BTRIM(normalized_name) <> ''
        )
);


CREATE TABLE transactions (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    amount NUMERIC(12,2) NOT NULL,
    transaction_type VARCHAR(150) NOT NULL,
    description TEXT,
    transaction_date DATE NOT NULL,
    source VARCHAR(150) NOT NULL,
    notes TEXT,
    posted_date DATE,
    created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
    merchant_id INT REFERENCES merchants(id),
    category_id INT REFERENCES categories(id),
    account_id INT NOT NULL REFERENCES accounts(id)
);


CREATE TABLE debts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    debt_name VARCHAR(150) NOT NULL,
    lender_name VARCHAR(150) NOT NULL,
    status VARCHAR(50) NOT NULL,
    current_balance NUMERIC(5,2) NOT NULL,
    original_balance NUMERIC(5,2)
        CHECK (original_balance >= 0),
    minimum_payment NUMERIC(5,2)
        CHECK (minimum_payment >= 0),
    interest_rate DECIMAL(5,2) NOT NULL,
    due_day INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    account_id INT REFERENCES accounts(id)
);


CREATE TABLE savings_goals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    goal_name VARCHAR(150) UNIQUE NOT NULL,
    target_amount NUMERIC(5,2) NOT NULL,
    current_amount NUMERIC(5,2) NOT NULL,
    status VARCHAR(150) NOT NULL,
    target_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);
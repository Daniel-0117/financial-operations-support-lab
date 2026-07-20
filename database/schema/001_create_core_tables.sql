CREATE TABLE accounts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    account_name VARCHAR(150) UNIQUE NOT NULL,
    account_type VARCHAR(150) NOT NULL,
    institution_name VARCHAR(150),
    current_balance NUMERIC(12, 2) NOT NULL,
    credit_limit NUMERIC(12, 2),
    opened_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE 
);

CREATE TABLE categories (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    category_name VARCHAR(150) UNIQUE NOT NULL,
    category_type VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
);

CREATE TABLE merchants (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    merchant_name VARCHAR(150) UNIQUE NOT NULL,
    normalized_name VARCHAR(150) UNIQUE NOT NULL,
    merchant_type VARCHAR(150) NOT NULL,
    is_active BOOLEAN NOT NULL DEFAULT TRUE
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL
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
    created_at TIMESTAMPTZ DEFAULT NOW(),
    merchant_id INT REFERENCES merchants(id),
    category_id INT REFERENCES categories(id),
    account_id INT NOT NULL REFERENCES accounts(id)
);

CREATE TABLE debts (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    debt_name VARCHAR(150) NOT NULL,
    lender_name VARCHAR(150) NOT NULL,
    status VARCHAR(50) NOT NULL,
    current_balance NUMERIC(12,2)NOT NULL,
    original_balance NUMERIC(12,2)NOT NULL,
    minimum_payment NUMERIC(12,2)NOT NULL,
    interest_rate DECIMAL(5,2) NOT NULL,
    due_day INT NOT NULL,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL,
    account_id INT REFERENCES accounts(id)
);

CREATE TABLE savings_goals (
    id INT GENERATED ALWAYS AS IDENTITY PRIMARY KEY,
    goal_name VARCHAR(150) UNIQUE NOT NULL,
    target_amount NUMERIC(12,2)NOT NULL,
    current_amount NUMERIC(12,2)NOT NULL,
    status VARCHAR(150) NOT NULL,
    target_date DATE,
    created_at TIMESTAMPTZ DEFAULT NOW() NOT NULL

);
-- CREATE DATABASE opay_app;
USE opay_app;

CREATE TABLE users (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    full_name VARCHAR(255),
    email VARCHAR(255),
    phone VARCHAR(20) UNIQUE,
    password_hash VARCHAR(255),
    date_of_birth DATE,
    gender VARCHAR(20),
    bvn VARCHAR(20) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP 
        ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(50)
);

CREATE TABLE wallets (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    balance DECIMAL(15,2),
    currency VARCHAR(10),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,
    status VARCHAR(50),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE transactions (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    wallet_id BIGINT,
    type VARCHAR(50),
    amount DECIMAL(15,2),
    fee DECIMAL(15,2),
    currency VARCHAR(10),
    reference VARCHAR(255) UNIQUE,
    description VARCHAR(255),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (wallet_id)
        REFERENCES wallets(id)
);

CREATE TABLE accounts (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    account_number VARCHAR(20) UNIQUE,
    bank_code VARCHAR(20),
    bank_name VARCHAR(255),
    account_name VARCHAR(255),
    type VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50),

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE cards (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    card_number VARCHAR(30) UNIQUE,
    card_type VARCHAR(50),
    expiry_month VARCHAR(5),
    expiry_year VARCHAR(5),
    cvv VARCHAR(5),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE beneficiaries (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    bank_code VARCHAR(20),
    account_number VARCHAR(20),
    account_name VARCHAR(255),
    nickname VARCHAR(255),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE user_keys (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    type VARCHAR(50),
    `key` VARCHAR(255) UNIQUE,
    is_primary BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE loans (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    loan_type VARCHAR(50),
    principal_amount DECIMAL(15,2),
    interest_rate DECIMAL(5,2),
    tenure INT,
    status VARCHAR(50),
    disbursed_at TIMESTAMP,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE loan_repayments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    loan_id BIGINT,
    wallet_id BIGINT,
    amount DECIMAL(15,2),
    paid_at TIMESTAMP,
    reference VARCHAR(255),
    status VARCHAR(50),

    FOREIGN KEY (loan_id)
        REFERENCES loans(id),

    FOREIGN KEY (wallet_id)
        REFERENCES wallets(id)
);

CREATE TABLE billers (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(255),
    category VARCHAR(100),
    code VARCHAR(100) UNIQUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status VARCHAR(50)
);

CREATE TABLE bill_payments (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    wallet_id BIGINT,
    biller_id BIGINT,
    customer_reference VARCHAR(255),
    amount DECIMAL(15,2),
    status VARCHAR(50),
    paid_at TIMESTAMP,
    reference VARCHAR(255) UNIQUE,

    FOREIGN KEY (user_id)
        REFERENCES users(id),

    FOREIGN KEY (wallet_id)
        REFERENCES wallets(id),

    FOREIGN KEY (biller_id)
        REFERENCES billers(id)
);

CREATE TABLE merchants (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    merchant_name VARCHAR(255),
    business_name VARCHAR(255),
    category VARCHAR(100),
    phone VARCHAR(20),
    email VARCHAR(255),
    address VARCHAR(255),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
        ON UPDATE CURRENT_TIMESTAMP
);

CREATE TABLE merchant_settlements (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    merchant_id BIGINT,
    wallet_id BIGINT,
    amount DECIMAL(15,2),
    settlement_date DATE,
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (merchant_id)
        REFERENCES merchants(id),

    FOREIGN KEY (wallet_id)
        REFERENCES wallets(id)
);

CREATE TABLE referrals (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    referrer_id BIGINT,
    referee_id BIGINT,
    reward_amount DECIMAL(15,2),
    status VARCHAR(50),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (referrer_id)
        REFERENCES users(id),

    FOREIGN KEY (referee_id)
        REFERENCES users(id)
);

CREATE TABLE notifications (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    user_id BIGINT,
    title VARCHAR(255),
    message TEXT,
    type VARCHAR(50),
    is_read BOOLEAN,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (user_id)
        REFERENCES users(id)
);

CREATE TABLE transaction_parties (
    id BIGINT PRIMARY KEY AUTO_INCREMENT,
    transaction_id BIGINT,
    party_type VARCHAR(50),
    party_id BIGINT,
    debit_credit VARCHAR(20),
    amount DECIMAL(15,2),

    FOREIGN KEY (transaction_id)
        REFERENCES transactions(id)
);
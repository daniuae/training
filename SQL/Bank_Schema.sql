


CREATE TABLE bankcustomers (
    customer_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    email VARCHAR(100),
    phone VARCHAR(15),
    address TEXT,
    date_of_birth DATE
);


INSERT INTO bankcustomers (full_name, email, phone, address, date_of_birth) VALUES
('Dhandapani', 'daniyk2020@gmail.com', '9786441887', 'Coimbatore, TN', '1990-05-15'),
('Priya Singh', 'priya.s@gmail.com', '9123456780', 'Bangalore, KA', '1988-11-22'),
('John David', 'john.d@hotmail.com', '9988776655', 'Hyderabad, TS', '1985-02-10');


CREATE TABLE bankbranches (
    branch_id SERIAL PRIMARY KEY,
    branch_name VARCHAR(100),
    city VARCHAR(100),
    ifsc_code VARCHAR(11) UNIQUE
);

INSERT INTO bankbranches (branch_name, city, ifsc_code) VALUES
('T Nagar Branch', 'Chennai', 'BANK0001TN'),
('MG Road Branch', 'Bangalore', 'BANK0002KA'),
('Jubilee Hills Branch', 'Hyderabad', 'BANK0003TS');


CREATE TABLE bankaccounts (
    account_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES bankcustomers(customer_id),
    branch_id INT REFERENCES bankbranches(branch_id),
    account_type VARCHAR(20) CHECK (account_type IN ('Savings', 'Current')),
    balance NUMERIC(12,2),
    opened_on DATE DEFAULT CURRENT_DATE
);

INSERT INTO bankaccounts (customer_id, branch_id, account_type, balance) VALUES
(1, 1, 'Savings', 25000.00),
(2, 2, 'Current', 500000.00),
(3, 3, 'Savings', 12000.50);


CREATE TABLE banktransactions (
    transaction_id SERIAL PRIMARY KEY,
    account_id INT REFERENCES bankaccounts(account_id),
    transaction_type VARCHAR(10) CHECK (transaction_type IN ('Credit', 'Debit')),
    amount NUMERIC(10,2),
    transaction_date TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    description TEXT
);

INSERT INTO banktransactions (account_id, transaction_type, amount, description) VALUES
(1, 'Credit', 5000.00, 'Salary Deposit'),
(1, 'Debit', 1500.00, 'ATM Withdrawal'),
(2, 'Debit', 20000.00, 'Vendor Payment'),
(3, 'Credit', 2000.00, 'Cash Deposit');


CREATE TABLE bankloans (
    loan_id SERIAL PRIMARY KEY,
    customer_id INT REFERENCES bankcustomers(customer_id),
    branch_id INT REFERENCES bankbranches(branch_id),
    loan_amount NUMERIC(12,2),
    interest_rate NUMERIC(4,2),
    start_date DATE,
    end_date DATE,
    loan_type VARCHAR(50)
);

INSERT INTO bankloans (customer_id, branch_id, loan_amount, interest_rate, start_date, end_date, loan_type) VALUES
(1, 1, 500000.00, 7.5, '2023-01-01', '2028-01-01', 'Home Loan'),
(2, 2, 200000.00, 10.5, '2024-06-15', '2027-06-15', 'Car Loan');


CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;
drop database ecommerce_db;
CREATE TABLE IF NOT EXISTS customer (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL
);

-- Step 3: Create the Category table
CREATE TABLE IF NOT EXISTS category (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

-- Step 4: Create the Product table
CREATE TABLE IF NOT EXISTS product (
    id INT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    count INT NOT NULL CHECK (count >= 0),
    status VARCHAR(20) NOT NULL CHECK (status IN ('Available', 'Out of Stock')),
    category_id INT,
    price DOUBLE NOT NULL CHECK (price > 0),
    FOREIGN KEY (category_id) REFERENCES category(id)
);

-- Step 5: Create the Purchase table
CREATE TABLE IF NOT EXISTS purchase (
    id INT PRIMARY KEY,
    customer_id INT,
    product_id INT,
    purchase_date DATE,
    coupon_code VARCHAR(20),
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);

-- Step 6: Insert sample data

-- Categories
INSERT INTO category (id, name) VALUES
(1, 'Personal Care'),
(2, 'Electronics'),
(3, 'Books');

-- Customers
INSERT INTO customer (id, name, email) VALUES
(1, 'Alice Johnson', 'alice@example.com'),
(2, 'Bob Smith', 'bob@example.com');

-- Products
INSERT INTO product (id, name, count, status, category_id, price) VALUES
(101, 'Dove Soap', 50, 'Available', 1, 200.00),
(102, 'Electric Toothbrush', 10, 'Available', 1, 1499.00),
(103, 'Smartphone', 5, 'Available', 2, 29999.00),
(104, 'Java Programming Book', 0, 'Out of Stock', 3, 899.00);

-- Purchases
INSERT INTO purchase (id, customer_id, product_id, purchase_date, coupon_code) VALUES
(201, 1, 101, '2025-05-10', 'DIWALI_05'),
(202, 2, 103, '2025-05-15', 'FREE_10');
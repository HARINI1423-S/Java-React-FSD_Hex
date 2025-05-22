CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

CREATE TABLE category (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL
);

CREATE TABLE product (
    id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    price DOUBLE NOT NULL,
    description VARCHAR(255),
    category_id INT,
    FOREIGN KEY (category_id) REFERENCES category(id)
);


CREATE TABLE customer (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    city VARCHAR(100)
);

CREATE TABLE purchase (
    id INT AUTO_INCREMENT PRIMARY KEY,
    date_of_purchase VARCHAR(50),
    customer_id INT,
    product_id INT,
    FOREIGN KEY (customer_id) REFERENCES customer(id),
    FOREIGN KEY (product_id) REFERENCES product(id)
);


INSERT INTO category (name) VALUES 
('Mobiles'),
('Laptops');


INSERT INTO customer (name, city) VALUES 
('John Doe', 'Mumbai'),
('Jane Doe', 'Chennai');

INSERT INTO product (title, price, description, category_id) VALUES 
('iPhone 14', 79999, 'Apple smartphone', 1),
('Samsung Galaxy S22', 69999, 'Samsung flagship phone', 1),
('HP Pavilion', 65999, 'Gaming laptop', 2),
('Dell Inspiron', 60999, 'Work laptop', 2);


INSERT INTO purchase (date_of_purchase, customer_id, product_id) VALUES 
('2025-05-10', 1, 1), 
('2025-05-12', 2, 3); 
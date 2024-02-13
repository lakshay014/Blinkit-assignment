Create Database bookstore_db;

use bookstore_db;

CREATE TABLE
    authors (
        author_id INT PRIMARY KEY AUTO_INCREMENT,
        author_name VARCHAR(100) NOT NULL
    );


INSERT INTO
    authors (author_name)
VALUES
    ('J.K. Rowling'),
    ('Stephen King'),
    ('George R.R. Martin');


CREATE TABLE
    books (
        book_id INT PRIMARY KEY AUTO_INCREMENT,
        title VARCHAR(255) NOT NULL,
        author_id INT,
        price DECIMAL(10, 2) NOT NULL,
        stock_quantity INT NOT NULL,
        FOREIGN KEY (author_id) REFERENCES authors (author_id)
    );


INSERT INTO
    books (title, author_id, price, stock_quantity)
VALUES
    (
        'Harry Potter and the Philosopher''s Stone',
        1,
        12.99,
        100
    ),
    (
        'Harry Potter and the Chamber of Secrets',
        1,
        14.99,
        80
    ),
    ('The Shining', 2, 9.99, 50),
    ('Misery', 2, 11.99, 60),
    ('A Game of Thrones', 3, 19.99, 120),
    ('A Clash of Kings', 3, 21.99, 90);


CREATE TABLE
    customers (
        customer_id INT PRIMARY KEY AUTO_INCREMENT,
        customer_name VARCHAR(100) NOT NULL,
        email VARCHAR(255) NOT NULL,
        phone VARCHAR(20)
    );


INSERT INTO
    customers (customer_name, email, phone)
VALUES
    ('John Doe', 'john@example.com', '123-456-7890'),
    ('Jane Smith', 'jane@example.com', '987-654-3210');


CREATE TABLE
    orders (
        order_id INT PRIMARY KEY AUTO_INCREMENT,
        customer_id INT,
        order_date DATE NOT NULL,
        total_amount DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (customer_id) REFERENCES customers (customer_id)
    );


INSERT INTO
    orders (customer_id, order_date, total_amount)
VALUES
    (1, '2024-01-15', 28.98),
    (2, '2024-01-20', 31.98),
    (1, '2024-02-05', 19.99),
    (2, '2024-02-10', 23.98);


CREATE TABLE
    order_items (
        order_item_id INT PRIMARY KEY AUTO_INCREMENT,
        order_id INT,
        book_id INT,
        quantity INT NOT NULL,
        unit_price DECIMAL(10, 2) NOT NULL,
        FOREIGN KEY (order_id) REFERENCES orders (order_id),
        FOREIGN KEY (book_id) REFERENCES books (book_id)
    );


INSERT INTO
    order_items (order_id, book_id, quantity, unit_price)
VALUES
    (1, 1, 1, 12.99),
    (1, 3, 1, 9.99),
    (2, 2, 1, 14.99),
    (2, 5, 1, 19.99),
    (3, 1, 1, 12.99),
    (4, 4, 1, 11.99),
    (4, 6, 1, 21.99);
    
CREATE TABLE lesson4.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE lesson4.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_amount DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES lesson4.customers(customer_id)
);

CREATE TABLE lesson4.order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_name VARCHAR(100),
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES lesson4.orders(order_id)
);

INSERT INTO lesson4.customers (customer_id, customer_name, city)
VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Da Nang'),
(3, 'Le Van C', 'Ho Chi Minh'),
(4, 'Pham Thi D', 'Ha Noi');

INSERT INTO lesson4.orders (order_id, customer_id, order_date, total_amount)
VALUES
(101, 1, '2025-01-10', 5000),
(102, 2, '2025-01-15', 3000),
(103, 1, '2025-02-01', 7000),
(104, 3, '2025-02-10', 4500),
(105, 4, '2025-03-05', 2000);

INSERT INTO lesson4.order_items (item_id, order_id, product_name, quantity, price)
VALUES
(1, 101, 'Laptop Dell', 1, 5000),
(2, 102, 'IPhone 15', 1, 3000),
(3, 103, 'Ban hoc go', 2, 3500),
(4, 104, 'Ghe xoay', 3, 1500),
(5, 105, 'Tai nghe', 2, 1000);

SELECT
    c.customer_name AS customer_name,
    o.order_date AS order_date,
    o.total_amount AS total_amount
FROM lesson4.customers c
JOIN lesson4.orders o
    ON c.customer_id = o.customer_id;

SELECT
    SUM(total_amount) AS total_revenue,
    AVG(total_amount) AS average_order,
    MAX(total_amount) AS highest_order,
    MIN(total_amount) AS lowest_order,
    COUNT(order_id) AS order_count
FROM lesson4.orders;

SELECT
    c.city,
    SUM(o.total_amount) AS total_revenue
FROM lesson4.customers c
JOIN lesson4.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_amount) > 10000;

SELECT
    c.customer_name,
    o.order_date,
    oi.product_name,
    oi.quantity,
    oi.price
FROM lesson4.customers c
JOIN lesson4.orders o
    ON c.customer_id = o.customer_id
JOIN lesson4.order_items oi
    ON o.order_id = oi.order_id;

SELECT
    c.customer_name,
    SUM(o.total_amount) AS total_revenue
FROM lesson4.customers c
JOIN lesson4.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_amount) = (
    SELECT MAX(customer_total)
    FROM (
        SELECT SUM(total_amount) AS customer_total
        FROM lesson4.orders
        GROUP BY customer_id
    ) AS revenue_table
);
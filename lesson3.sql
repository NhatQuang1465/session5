CREATE TABLE lesson3.customers (
    customer_id INT PRIMARY KEY,
    customer_name VARCHAR(100),
    city VARCHAR(100)
);

CREATE TABLE lesson3.orders (
    order_id INT PRIMARY KEY,
    customer_id INT,
    order_date DATE,
    total_price DECIMAL(10,2),
    FOREIGN KEY (customer_id) REFERENCES lesson3.customers(customer_id)
);

CREATE TABLE lesson3.order_items (
    item_id INT PRIMARY KEY,
    order_id INT,
    product_id INT,
    quantity INT,
    price DECIMAL(10,2),
    FOREIGN KEY (order_id) REFERENCES lesson3.orders(order_id)
);

INSERT INTO lesson3.customers (customer_id, customer_name, city)
VALUES
(1, 'Nguyen Van A', 'Ha Noi'),
(2, 'Tran Thi B', 'Da Nang'),
(3, 'Le Van C', 'Ho Chi Minh'),
(4, 'Pham Thi D', 'Ha Noi');

INSERT INTO lesson3.orders (order_id, customer_id, order_date, total_price)
VALUES
(101, 1, '2024-12-20', 3000),
(102, 2, '2025-01-05', 1500),
(103, 1, '2025-02-10', 2500),
(104, 3, '2025-02-15', 4000),
(105, 4, '2025-03-01', 800);

INSERT INTO lesson3.order_items (item_id, order_id, product_id, quantity, price)
VALUES
(1, 101, 1, 2, 1500),
(2, 102, 2, 1, 1500),
(3, 103, 3, 5, 500),
(4, 104, 2, 4, 1000);

SELECT
    c.customer_name,
    SUM(o.total_price) AS total_revenue,
    COUNT(o.order_id) AS order_count
FROM lesson3.customers c
JOIN lesson3.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > 2000;

SELECT
    c.customer_name,
    SUM(o.total_price) AS total_revenue
FROM lesson3.customers c
JOIN lesson3.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.customer_id, c.customer_name
HAVING SUM(o.total_price) > (
    SELECT AVG(customer_revenue)
    FROM (
        SELECT SUM(total_price) AS customer_revenue
        FROM lesson3.orders
        GROUP BY customer_id
    ) AS revenue_table
);

SELECT
    c.city,
    SUM(o.total_price) AS total_revenue
FROM lesson3.customers c
JOIN lesson3.orders o
    ON c.customer_id = o.customer_id
GROUP BY c.city
HAVING SUM(o.total_price) = (
    SELECT MAX(city_revenue)
    FROM (
        SELECT SUM(o.total_price) AS city_revenue
        FROM lesson3.customers c
        JOIN lesson3.orders o
            ON c.customer_id = o.customer_id
        GROUP BY c.city
    ) AS city_table
);

SELECT
    c.customer_name,
    c.city,
    SUM(oi.quantity) AS total_products,
    SUM(oi.quantity * oi.price) AS total_spent
FROM lesson3.customers c
JOIN lesson3.orders o
    ON c.customer_id = o.customer_id
JOIN lesson3.order_items oi
    ON o.order_id = oi.order_id
GROUP BY c.customer_id, c.customer_name, c.city;
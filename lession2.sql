CREATE TABLE lession2.products (
    product_id INT PRIMARY KEY,
    product_name VARCHAR(100),
    category VARCHAR(50)
);

CREATE TABLE lession2.orders (
    order_id INT PRIMARY KEY,
    product_id INT,
    quantity INT,
    total_price DECIMAL(10,2),
    FOREIGN KEY (product_id) REFERENCES lession2.products(product_id)
);

INSERT INTO lession2.products (product_id, product_name, category)
VALUES
(1, 'Laptop Dell', 'Electronics'),
(2, 'IPhone 15', 'Electronics'),
(3, 'Ban hoc go', 'Furniture'),
(4, 'Ghe xoay', 'Furniture');

INSERT INTO lession2.orders (order_id, product_id, quantity, total_price)
VALUES
(101, 1, 2, 2200),
(102, 2, 3, 3300),
(103, 3, 5, 2500),
(104, 4, 4, 1600),
(105, 1, 1, 1100);

SELECT 
    p.product_name,
    SUM(o.total_price) AS total_revenue
FROM lession2.products p
JOIN lession2.orders o
    ON p.product_id = o.product_id
GROUP BY p.product_id, p.product_name
HAVING SUM(o.total_price) = (
    SELECT MAX(product_revenue)
    FROM (
        SELECT SUM(total_price) AS product_revenue
        FROM lession2.orders
        GROUP BY product_id
    ) AS revenue_table
);

SELECT
    p.category,
    SUM(o.total_price) AS total_revenue
FROM lession2.products p
JOIN lession2.orders o
    ON p.product_id = o.product_id
GROUP BY p.category;
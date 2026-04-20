CREATE TABLE lesson6.departments (
    dept_id SERIAL PRIMARY KEY,
    dept_name VARCHAR(100)
);

CREATE TABLE lesson6.employees (
    emp_id SERIAL PRIMARY KEY,
    emp_name VARCHAR(100),
    dept_id INT REFERENCES lesson6.departments(dept_id),
    salary NUMERIC(12,2),
    hire_date DATE
);

CREATE TABLE lesson6.projects (
    project_id SERIAL PRIMARY KEY,
    project_name VARCHAR(100),
    dept_id INT REFERENCES lesson6.departments(dept_id)
);

INSERT INTO lesson6.departments (dept_name)
VALUES
('IT'),
('Ke toan'),
('Nhan su');

INSERT INTO lesson6.employees (emp_name, dept_id, salary, hire_date)
VALUES
('Nguyen Van A', 1, 18000000, '2023-01-10'),
('Tran Thi B', 1, 22000000, '2022-05-12'),
('Le Van C', 2, 14000000, '2024-02-20'),
('Pham Thi D', 2, 17000000, '2021-09-15'),
('Hoang Van E', 3, 12000000, '2023-06-01');

INSERT INTO lesson6.projects (project_name, dept_id)
VALUES
('Website ban hang', 1),
('Bao cao tai chinh', 2),
('Tuyen dung 2026', 3);

SELECT
    e.emp_name AS "Ten nhan vien",
    d.dept_name AS "Phong ban",
    e.salary AS "Luong"
FROM lesson6.employees e
JOIN lesson6.departments d
    ON e.dept_id = d.dept_id;

SELECT
    SUM(salary) AS total_salary_fund,
    AVG(salary) AS average_salary,
    MAX(salary) AS highest_salary,
    MIN(salary) AS lowest_salary,
    COUNT(emp_id) AS employee_count
FROM lesson6.employees;

SELECT
    d.dept_name,
    AVG(e.salary) AS average_salary
FROM lesson6.employees e
JOIN lesson6.departments d
    ON e.dept_id = d.dept_id
GROUP BY d.dept_name
HAVING AVG(e.salary) > 15000000;

SELECT
    p.project_name,
    d.dept_name,
    e.emp_name
FROM lesson6.projects p
JOIN lesson6.departments d
    ON p.dept_id = d.dept_id
JOIN lesson6.employees e
    ON d.dept_id = e.dept_id
ORDER BY p.project_name;

SELECT
    e.emp_name,
    d.dept_name,
    e.salary
FROM lesson6.employees e
JOIN lesson6.departments d
    ON e.dept_id = d.dept_id
WHERE (e.dept_id, e.salary) IN (
    SELECT
        dept_id,
        MAX(salary)
    FROM lesson6.employees
    GROUP BY dept_id
);
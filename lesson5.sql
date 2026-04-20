CREATE TABLE lesson5.students (
    student_id SERIAL PRIMARY KEY,
    full_name VARCHAR(100),
    major VARCHAR(50)
);

CREATE TABLE lesson5.courses (
    course_id SERIAL PRIMARY KEY,
    course_name VARCHAR(100),
    credit INT
);

CREATE TABLE lesson5.enrollments (
    student_id INT REFERENCES lesson5.students(student_id),
    course_id INT REFERENCES lesson5.courses(course_id),
    score NUMERIC(5,2)
);

INSERT INTO lesson5.students (full_name, major)
VALUES
('Nguyen Van A', 'Cong nghe thong tin'),
('Tran Thi B', 'Ke toan'),
('Le Van C', 'Cong nghe thong tin'),
('Pham Thi D', 'Quan tri kinh doanh');

INSERT INTO lesson5.courses (course_name, credit)
VALUES
('Co so du lieu', 3),
('Lap trinh Java', 4),
('Ke toan tai chinh', 3),
('Marketing', 2);

INSERT INTO lesson5.enrollments (student_id, course_id, score)
VALUES
(1, 1, 8.5),
(1, 2, 9.0),
(2, 3, 7.0),
(3, 1, 8.0),
(3, 2, 7.5),
(4, 4, 6.5);

SELECT
    s.full_name AS "Ten sinh vien",
    c.course_name AS "Mon hoc",
    e.score AS "Diem"
FROM lesson5.students s
JOIN lesson5.enrollments e
    ON s.student_id = e.student_id
JOIN lesson5.courses c
    ON c.course_id = e.course_id;

SELECT
    s.full_name,
    AVG(e.score) AS average_score,
    MAX(e.score) AS highest_score,
    MIN(e.score) AS lowest_score
FROM lesson5.students s
JOIN lesson5.enrollments e
    ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name;

SELECT
    s.major,
    AVG(e.score) AS average_major_score
FROM lesson5.students s
JOIN lesson5.enrollments e
    ON s.student_id = e.student_id
GROUP BY s.major
HAVING AVG(e.score) > 7.5;

SELECT
    s.full_name,
    c.course_name,
    c.credit,
    e.score
FROM lesson5.students s
JOIN lesson5.enrollments e
    ON s.student_id = e.student_id
JOIN lesson5.courses c
    ON c.course_id = e.course_id;

SELECT
    s.full_name,
    AVG(e.score) AS average_score
FROM lesson5.students s
JOIN lesson5.enrollments e
    ON s.student_id = e.student_id
GROUP BY s.student_id, s.full_name
HAVING AVG(e.score) > (
    SELECT AVG(score)
    FROM lesson5.enrollments
);
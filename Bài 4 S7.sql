CREATE DATABASE CoursePlatform;
USE CoursePlatform;

CREATE TABLE Courses (
    course_id INT PRIMARY KEY AUTO_INCREMENT,
    course_name VARCHAR(100) NOT NULL,
    price DECIMAL(10,2)
);


CREATE TABLE Enrollments (
    enrollment_id INT PRIMARY KEY AUTO_INCREMENT,
    student_name VARCHAR(100),
    course_id INT NULL
);

INSERT INTO Courses (course_name, price)
VALUES
('SQL Cơ Bản', 1000000),
('Python Backend', 2000000),
('ReactJS', 1800000),
('Machine Learning', 3000000),
('Docker DevOps', 2500000);


INSERT INTO Enrollments (student_name, course_id)
VALUES
('Nguyễn Văn A', 1),
('Trần Thị B', 2),
('Lỗi Network 1', NULL),
('Lỗi Network 2', NULL);

SELECT *
FROM Courses
WHERE course_id NOT IN (
    SELECT course_id
    FROM Enrollments
);

SELECT *
FROM Courses
WHERE course_id NOT IN (
    SELECT course_id
    FROM Enrollments
    WHERE course_id IS NOT NULL
);
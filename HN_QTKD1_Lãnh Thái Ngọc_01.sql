CREATE DATABASE StudentManagement;
USE StudentManagement;

-- 1. Tạo bảng Students 
CREATE TABLE Students (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    student_name VARCHAR(100) NOT NULL,
    email VARCHAR(100) NOT NULL UNIQUE,
    phone VARCHAR(15),
    address VARCHAR(255)
);

-- 2.Tạo bảng Courses 
CREATE TABLE Courses (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_name VARCHAR(100) NOT NULL,
    description TEXT,
    credits INT NOT NULL,
    CONSTRAINT (credits > 0)
);

-- 3.Tạo bảng Enrollments
CREATE TABLE Enrollments (
    enrollment_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT NOT NULL,
    course_id INT NOT NULL,
    score DECIMAL(4,2),
    enrollment_date DATE,
    CONSTRAINT chk_score_range CHECK (score BETWEEN 0 AND 10),
	FOREIGN KEY (student_id) REFERENCES Students(student_id) 
    FOREIGN KEY (course_id) REFERENCES Courses(course_id) 
);

-- Câu 2: 
-- 1 Thêm dữ liệu vào Students
INSERT INTO Students (student_name, email, phone, address) VALUES
('Nguyen Van An', 'an@example.com', '0901111111', 'Ha Noi'),
('Tran Thi Bich', 'bich@example.com', '0902222222', 'Hai Phong'),
('Le Van Cuong', 'cuong@example.com', '0903333333', 'Da Nang'),
('Nguyen Thi Dung', 'dung@example.com', '0904444444', 'Hue'),
('Pham Van Em', 'em@example.com', '0905555555', 'TP HCM'),
('Hoang Thi Phuong', 'phuong@example.com', '0906666666', 'Can Tho'),
('Ngo Van Giang', 'giang@example.com', '0907777777', 'Ha Noi'),
('Vu Thi Hoa', 'hoa@example.com', '0908888888', 'Nam Dinh'),
('Bui Van Hung', 'hung@example.com', '0909999999', 'Ha Noi'),
('Nguyen Van Khoi', 'khoi@example.com', '0910000000', 'TP HCM');

-- 2 Thêm dữ liệu vào Courses
INSERT INTO Courses (course_name, description, credits) VALUES
('Co so du lieu', 'Nhap mon SQL', 3),
('Lap trinh Web', 'HTML, CSS, JS', 3),
('Cau truc du lieu', 'Giai thuat C++', 4),
('He dieu hanh', 'Linux, Windows', 3),
('Mang may tinh', 'TCP/IP', 3),
('Tri tue nhan tao', 'AI basics', 4),
('Ky thuat phan mem', 'Quan ly du an', 3),
('Toan cao cap', 'Toan A1', 4),
('Vat ly dai cuong', 'Vat ly co ban', 3),
('Lich su my thuat', 'Mon tu chon', 2);

-- 3 Thêm dữ liệu vào Enrollments
INSERT INTO Enrollments (student_id, course_id, score, enrollment_date) VALUES
(1, 1, 8.50, '2024-01-10'),
(2, 2, 7.00, '2024-01-11'),
(3, 3, 9.00, '2024-01-12'),
(4, 4, 6.50, '2024-01-13'),
(5, 5, 8.00, '2024-01-14'),
(6, 6, 5.50, '2024-01-15'),
(7, 7, 9.50, '2024-01-16'),
(8, 8, 4.00, '2024-01-17'),
(9, 9, 7.50, '2024-01-18'),
(10, 10, 1.50, '2024-01-19');

-- Câu 3: Cập nhật dữ liệu
-- Cập nhật credits của môn "Lap trinh Web" thành 4
UPDATE Courses
SET credits = 4
WHERE course_name = 'Lap trinh Web';

-- 3.2. Cập nhật điểm số (score) của sinh viên có student_id = 1 thành 9.0
UPDATE Enrollments
SET score = 9.00
WHERE student_id = 1;

-- Câu 4: Xóa dữ liệu
-- 4.1. Xóa các bản ghi trong Enrollments có score < 2.0
DELETE FROM Enrollments
WHERE score < 2.0;

-- 4.2. Xóa môn học "Lich su my thuat" có course_id = 10
DELETE FROM Courses
WHERE course_id = 10;

-- Câu 5: Truy vấn cơ bản
-- 5.1 Lấy ra danh sách sinh viên có address = 'Ha Noi'
SELECT *
 FROM Students
WHERE address = 'Ha Noi';

-- 5.2 Lấy ra danh sách các môn học có credits > 3
SELECT *
 FROM Courses
WHERE credits > 3;

-- 5.3 Tìm kiếm các môn học có tên bắt đầu bằng chữ 'C'
SELECT *
 FROM Courses
WHERE course_name LIKE 'C%';

-- 5.4 Lấy ra danh sách điểm số (score) trong khoảng từ 6.0 đến 8.0
SELECT *
 FROM Enrollments
WHERE score BETWEEN 6.0 AND 8.0;

-- 5.5 Lấy ra 3 sinh viên có student_id cao nhất
SELECT *
 FROM Students
ORDER BY student_id DESC
LIMIT 3;

-- Câu 6: Truy vấn nhiều bảng (JOIN)
-- 6.1 Lấy danh sách: Tên sinh viên, Tên môn học và điểm (score)
SELECT s.student_name, c.course_name, e.score
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id;

-- 6.2 Lấy tên sinh viên và địa chỉ của những bạn đã đăng ký học môn "Co so du lieu"
SELECT DISTINCT s.student_name, s.address
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
JOIN Courses c ON e.course_id = c.course_id
WHERE c.course_name = 'Co so du lieu';

-- 6.3 Hiển thị tên môn học và điểm số của những môn có điểm > 8.0
SELECT c.course_name, e.score
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
WHERE e.score > 8.0;

-- 6.4 Hiển thị danh sách các môn có credits = 3 và tên của sinh viên đang theo học môn đó
SELECT c.course_name, s.student_name
FROM Enrollments e
JOIN Courses c ON e.course_id = c.course_id
JOIN Students s ON e.student_id = s.student_id
WHERE c.credits = 3
ORDER BY c.course_name, s.student_name;

-- Câu 7: Truy vấn gom nhóm 
-- 7.1 Thống kê số lượng sinh viên theo từng address
SELECT address, COUNT(*) AS student_count
FROM Students
GROUP BY address
ORDER BY student_count DESC;

-- 7.2 Tính điểm số trung bình 
SELECT AVG(score) AS avg_score
FROM Enrollments;

-- 7.3 Tìm những address có từ 2 sinh viên trở lên đang cư trú
SELECT address, COUNT(*) AS student_count
FROM Students
GROUP BY address
HAVING COUNT(*) >= 2;

-- Câu 8: Truy vấn lồng 
-- 8.1 Tìm thông tin những sinh viên (student_name, score) có điểm số cao nhất trong bảng Enrollments
SELECT s.student_name, e.score
FROM Enrollments e
JOIN Students s ON e.student_id = s.student_id
WHERE e.score = (SELECT MAX(score) FROM Enrollments);







    
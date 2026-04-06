-- show user
show user

-- tạo bảng
-- REGIONS
CREATE TABLE REGIONS (
    region_id NUMBER PRIMARY KEY,
    region_name VARCHAR2(25)
);

-- COUNTRIES
CREATE TABLE COUNTRIES (
    country_id CHAR(2) PRIMARY KEY,
    country_name VARCHAR2(40),
    region_id NUMBER,
    CONSTRAINT FK_COUNTRIES_REGIONS FOREIGN KEY (region_id) REFERENCES REGIONS(region_id)
);

-- LOCATIONS
CREATE TABLE LOCATIONS (
    location_id NUMBER PRIMARY KEY,
    street_address VARCHAR2(40),
    postal_code VARCHAR2(12),
    city VARCHAR2(30),
    state_province VARCHAR2(25),
    country_id CHAR(2),
    CONSTRAINT FK_LOCATIONS_COUNTRIES FOREIGN KEY (country_id) REFERENCES COUNTRIES(country_id)
);

-- JOBS
CREATE TABLE JOBS (
    job_id VARCHAR2(10) PRIMARY KEY,
    job_title VARCHAR2(35),
    min_salary NUMBER(8,0),
    max_salary NUMBER(8,0)
);

-- DEPARTMENTS
CREATE TABLE DEPARTMENTS (
    department_id NUMBER PRIMARY KEY,
    department_name VARCHAR2(30),
    manager_id NUMBER,
    location_id NUMBER,
    CONSTRAINT FK_DEPT_LOCATIONS FOREIGN KEY (location_id) REFERENCES LOCATIONS(location_id)
);

-- EMPLOYEES
CREATE TABLE EMPLOYEES (
    employee_id NUMBER PRIMARY KEY,
    first_name VARCHAR2(20),
    last_name VARCHAR2(25),
    email VARCHAR2(25),
    hire_date DATE,
    job_id VARCHAR2(10),
    salary NUMBER(8,2),
    commission_pct NUMBER(2,2),
    manager_id NUMBER,
    department_id NUMBER,
    CONSTRAINT FK_EMP_JOBS FOREIGN KEY (job_id) REFERENCES JOBS(job_id),
    CONSTRAINT FK_EMP_DEPT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id),
    CONSTRAINT FK_EMP_MANAGER FOREIGN KEY (manager_id) REFERENCES EMPLOYEES(employee_id)
);

-- Thêm Khóa Ngoại Cho Bảng DEPARTMENTS, Lý do là bảng EMPLOYEES đã tồn tại, dùng lệnh ALTER TABLE để cập nhật liên kết manager_id cho phòng ban.
ALTER TABLE DEPARTMENTS 
ADD CONSTRAINT FK_DEPT_MANAGER FOREIGN KEY (manager_id) REFERENCES EMPLOYEES(employee_id);

-- JOB_HISTORY
CREATE TABLE JOB_HISTORY (
    employee_id NUMBER,
    start_date DATE,
    end_date DATE,
    job_id VARCHAR2(10),
    department_id NUMBER,
    CONSTRAINT PK_JOB_HISTORY PRIMARY KEY (employee_id, start_date),
    CONSTRAINT FK_JH_EMPLOYEES FOREIGN KEY (employee_id) REFERENCES EMPLOYEES(employee_id),
    CONSTRAINT FK_JH_JOBS FOREIGN KEY (job_id) REFERENCES JOBS(job_id),
    CONSTRAINT FK_JH_DEPT FOREIGN KEY (department_id) REFERENCES DEPARTMENTS(department_id)
);

-- INSERT DỮ LIỆU
-- CHÈN DỮ LIỆU VÙNG VÀ QUỐC GIA
INSERT INTO REGIONS (region_id, region_name) VALUES (1, 'Europe');
INSERT INTO REGIONS (region_id, region_name) VALUES (2, 'Americas');
SELECT * FROM REGIONS

INSERT INTO COUNTRIES (country_id, country_name, region_id) VALUES ('CA', 'Canada', 2);
INSERT INTO COUNTRIES (country_id, country_name, region_id) VALUES ('US', 'United States of America', 2);
SELECT * FROM COUNTRIES

-- CHÈN ĐỊA CHỈ
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) 
VALUES (1700, '2004 Charade Rd', '98199', 'Seattle', 'Washington', 'US');
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) 
VALUES (1800, '147 Spadina Ave', 'M5V 2L7', 'Toronto', 'Ontario', 'CA');
INSERT INTO LOCATIONS (location_id, street_address, postal_code, city, state_province, country_id) 
VALUES (1900, '2014 Jabberwocky Rd', '94080', 'South San Francisco', 'California', 'US');
SELECT * FROM LOCATIONS

-- CHÈN CÔNG VIỆC
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('AD_PRES', 'President', 20000, 40000);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('ST_MAN', 'Stock Manager', 5500, 8500);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('IT_PROG', 'Programmer', 4000, 10000);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('SA_REP', 'Sales Representative', 6000, 12000);
INSERT INTO JOBS (job_id, job_title, min_salary, max_salary) VALUES ('ST_CLERK', 'Stock Clerk', 2000, 5000);
SELECT * FROM JOBS

-- CHÈN PHÒNG BAN
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (10, 'Administration', NULL, 1700); 
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (20, 'Marketing', NULL, 1800); -- Ở Toronto (Câu 17)
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (50, 'Shipping', NULL, 1900); -- Ở California (Câu 33)
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (60, 'IT', NULL, 1700);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (80, 'Sales', NULL, 1700);
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (500, 'Empty Dept 1', NULL, 1700); 
INSERT INTO DEPARTMENTS (department_id, department_name, manager_id, location_id) 
VALUES (600, 'Empty Dept 2', NULL, 1700); 
SELECT * FROM DEPARTMENTS

-- CHÈN NHÂN VIÊN
INSERT INTO EMPLOYEES VALUES (1, 'Steven', 'King', 'SKING', TO_DATE('17/06/1987', 'DD/MM/YYYY'), 'AD_PRES', 24000, NULL, NULL, 10);
INSERT INTO EMPLOYEES VALUES (3, 'John', 'Smith', 'JSMITH', TO_DATE('21/09/1989', 'DD/MM/YYYY'), 'ST_CLERK', 800, NULL, 1, 20);
INSERT INTO EMPLOYEES VALUES (4, 'Curtis', 'Davies', 'CDAVIES', TO_DATE('29/01/1997', 'DD/MM/YYYY'), 'ST_CLERK', 3100, NULL, 5, 50);
INSERT INTO EMPLOYEES VALUES (5, 'Adam', 'Fripp', 'AFRIPP', TO_DATE('10/04/1998', 'DD/MM/YYYY'), 'ST_MAN', 8200, NULL, 1, 50);
INSERT INTO EMPLOYEES VALUES (6, 'Eleni', 'Zlotkey', 'EZLOTKEY', TO_DATE('29/01/1996', 'DD/MM/YYYY'), 'SA_REP', 10500, 0.20, 1, 80);
INSERT INTO EMPLOYEES VALUES (7, 'Peter', 'Tucker', 'PTUCKER', TO_DATE('30/01/1997', 'DD/MM/YYYY'), 'SA_REP', 10000, 0.30, 6, 80);
INSERT INTO EMPLOYEES VALUES (8, 'David', 'Austin', 'DAUSTIN', TO_DATE('25/06/1997', 'DD/MM/YYYY'), 'IT_PROG', 4800, NULL, 1, 60);
INSERT INTO EMPLOYEES VALUES (10, 'Jennifer', 'Whalen', 'JWHALEN', TO_DATE('17/09/1995', 'DD/MM/YYYY'), 'AD_PRES', 4400, NULL, 1, 10);
INSERT INTO EMPLOYEES VALUES (11, 'Michael', 'Abel', 'MABEL', TO_DATE('01/03/1998', 'DD/MM/YYYY'), 'SA_REP', 11000, 0.30, 6, 80);
INSERT INTO EMPLOYEES VALUES (12, 'Jonathon', 'Taylor', 'JTAYLOR', TO_DATE('24/03/1994', 'DD/MM/YYYY'), 'SA_REP', 8600, 0.20, 6, 80);
INSERT INTO EMPLOYEES VALUES (13, 'Mat', 'Lee', 'MLEE', TO_DATE('23/02/1996', 'DD/MM/YYYY'), 'ST_CLERK', 2400, NULL, 5, 50);
SELECT * FROM EMPLOYEES

-- CẬP NHẬT LẠI QUẢN LÝ CHO PHÒNG BAN (manager_id)
UPDATE DEPARTMENTS SET manager_id = 1 WHERE department_id = 10;
UPDATE DEPARTMENTS SET manager_id = 3 WHERE department_id = 20;
UPDATE DEPARTMENTS SET manager_id = 5 WHERE department_id = 50;
SELECT * FROM DEPARTMENTS

-- CHÈN LỊCH SỬ CÔNG VIỆC
INSERT INTO JOB_HISTORY (employee_id, start_date, end_date, job_id, department_id) 
VALUES (3, TO_DATE('17/09/1987', 'DD/MM/YYYY'), TO_DATE('17/06/1993', 'DD/MM/YYYY'), 'ST_CLERK', 20);
SELECT * FROM JOB_HISTORY

COMMIT;

-- PHẦN 2:
-- CÂU 1
SELECT last_name, salary
FROM   employees
WHERE  salary > 12000;

-- CÂU 2
SELECT last_name, salary
FROM   employees
WHERE  salary < 5000 OR salary > 12000;

-- CÂU 3
SELECT last_name, job_id, hire_date
FROM   employees
WHERE  hire_date BETWEEN TO_DATE('20/02/1998','DD/MM/YYYY')
                     AND TO_DATE('01/05/1998','DD/MM/YYYY')
ORDER BY hire_date ASC;

-- CÂU 4
SELECT last_name, department_id
FROM   employees
WHERE  department_id IN (20, 50)
ORDER BY last_name ASC;

-- CÂU 5
SELECT last_name, hire_date
FROM   employees
WHERE  TO_CHAR(hire_date, 'YYYY') = '1994';

-- CÂU 6
SELECT last_name, job_id
FROM   employees
WHERE  manager_id IS NULL;

-- CÂU 7
SELECT last_name, salary, commission_pct
FROM   employees
WHERE  commission_pct IS NOT NULL
ORDER BY salary DESC, commission_pct DESC;

-- CÂU 8
SELECT last_name
FROM   employees
WHERE  last_name LIKE '__a%';

-- CÂU 9
SELECT last_name
FROM   employees
WHERE  last_name LIKE '%a%'
  AND  last_name LIKE '%e%';

-- CÂU 10
SELECT last_name, job_id, salary
FROM   employees
WHERE  job_id IN ('SA_REP', 'ST_CLERK')
  AND  salary NOT IN (2500, 3500, 7000);

-- CÂU 11
SELECT employee_id,
       last_name,
       ROUND(salary * 1.15, 0) AS "New Salary"
FROM   employees;

-- CÂU 12
SELECT INITCAP(last_name)  AS "Ten Nhan Vien",
       LENGTH(last_name)   AS "Chieu Dai"
FROM   employees
WHERE  SUBSTR(last_name, 1, 1) IN ('J','A','L','M')
ORDER BY last_name ASC;

-- câu 13
SELECT last_name,
       TRUNC(MONTHS_BETWEEN(SYSDATE, hire_date)) AS "So Thang Lam Viec"
FROM   employees
ORDER BY MONTHS_BETWEEN(SYSDATE, hire_date) ASC;

-- CÂU 14
SELECT last_name || ' earns '
    || TO_CHAR(salary, '$99,999') || ' monthly but wants '
    || TO_CHAR(salary*3, '$99,999') AS "Dream Salaries"
FROM   employees;

-- CÂU 15
SELECT last_name,
       CASE WHEN commission_pct IS NULL THEN 'No commission'
            ELSE TO_CHAR(commission_pct)
       END AS "Commission"
FROM   employees

-- CÂU 16
SELECT job_id,
       DECODE(job_id,
              'AD_PRES',  'A',
              'ST_MAN',   'B',
              'IT_PROG',  'C',
              'SA_REP',   'D',
              'ST_CLERK', 'E',
              '0') AS "GRADE"
FROM   employees;

-- CÂU 17
SELECT e.last_name, e.department_id, d.department_name
FROM   employees e, departments d, locations l
WHERE  e.department_id = d.department_id
  AND  d.location_id   = l.location_id
  AND  UPPER(l.city)   = 'TORONTO';
  
-- CÂU 18
SELECT e.employee_id  AS "Ma NV",
       e.last_name     AS "Ten NV",
       m.employee_id  AS "Ma Quan Ly",
       m.last_name     AS "Ten Quan Ly"
FROM   employees e, employees m
WHERE  e.manager_id = m.employee_id;

-- CÂU 19
SELECT e1.last_name AS "Nhan Vien 1",
       e2.last_name AS "Nhan Vien 2",
       e1.department_id AS "Phong Ban"
FROM   employees e1, employees e2
WHERE  e1.department_id = e2.department_id
  AND  e1.employee_id   < e2.employee_id
ORDER BY e1.department_id, e1.last_name;

-- CÂU 20
SELECT last_name, hire_date
FROM   employees
WHERE  hire_date > (SELECT hire_date
                    FROM   employees
                    WHERE  last_name = 'Davies');

-- CÂU 21
SELECT e.last_name   AS "Nhan Vien",
       e.hire_date   AS "Ngay Vao",
       m.last_name   AS "Quan Ly",
       m.hire_date   AS "Quan Ly Vao"
FROM   employees e, employees m
WHERE  e.manager_id = m.employee_id
  AND  e.hire_date  < m.hire_date;

-- CÂU 22
SELECT job_id,
       MIN(salary)          AS "Luong Thap Nhat",
       MAX(salary)          AS "Luong Cao Nhat",
       ROUND(AVG(salary),2) AS "Luong Trung Binh",
       SUM(salary)          AS "Tong Luong"
FROM   employees
GROUP BY job_id
ORDER BY job_id;

-- CÂU 23
-- Phần A: Số lượng nhân viên từng phòng:
SELECT d.department_id,
       d.department_name,
       COUNT(e.employee_id) AS "So Nhan Vien"
FROM   departments d LEFT JOIN employees e
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
ORDER BY d.department_id;

-- Phần B: Thống kê tuyển dụng theo từng năm:
SELECT COUNT(*) AS "Tong NV",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1995' THEN 1 ELSE 0 END) AS "Nam 1995",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1996' THEN 1 ELSE 0 END) AS "Nam 1996",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1997' THEN 1 ELSE 0 END) AS "Nam 1997",
  SUM(CASE WHEN TO_CHAR(hire_date,'YYYY')='1998' THEN 1 ELSE 0 END) AS "Nam 1998"
FROM   employees;

-- CÂU 25
SELECT last_name, hire_date
FROM   employees
WHERE  department_id = (SELECT department_id
                        FROM   employees
                        WHERE  last_name = 'Zlotkey')
  AND  last_name <> 'Zlotkey';

-- CÂU 26
SELECT last_name, department_id, job_id
FROM   employees
WHERE  department_id IN (SELECT department_id
                         FROM   departments
                         WHERE  location_id = 1700);

-- CÂU 27
SELECT last_name, manager_id
FROM   employees
WHERE  manager_id IN (SELECT employee_id
                      FROM   employees
                      WHERE  last_name = 'King');

-- CÂU 28
SELECT last_name, salary, department_id
FROM   employees
WHERE  salary > (SELECT AVG(salary) FROM employees)
  AND  department_id IN (SELECT department_id
                         FROM   employees
                         WHERE  last_name LIKE '%n');

-- CÂU 29
SELECT d.department_id, d.department_name, COUNT(e.employee_id) AS "So NV"
FROM   departments d LEFT JOIN employees e
       ON d.department_id = e.department_id
GROUP BY d.department_id, d.department_name
HAVING COUNT(e.employee_id) < 3
ORDER BY d.department_id;

-- CÂU 30
SELECT department_id, COUNT(*) AS "So Nhan Vien", 'Dong nhat' AS "Loai"
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM employees GROUP BY department_id)
UNION ALL
SELECT department_id, COUNT(*), 'It nhat'
FROM   employees
GROUP BY department_id
HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM employees GROUP BY department_id);

-- CÂU 31
SELECT last_name, hire_date,
       TO_CHAR(hire_date,'Day') AS "Thu trong tuan"
FROM   employees
WHERE  TO_CHAR(hire_date,'Day') IN (
    SELECT TO_CHAR(hire_date,'Day')
    FROM   employees
    GROUP BY TO_CHAR(hire_date,'Day')
    HAVING COUNT(*) = (
        SELECT MAX(COUNT(*))
        FROM   employees
        GROUP BY TO_CHAR(hire_date,'Day')
    )
);

-- CÂU 32
SELECT last_name, salary
FROM (
    SELECT last_name, salary
    FROM   employees
    ORDER BY salary DESC
)
WHERE ROWNUM <= 3;

-- CÂU 33
SELECT e.last_name, e.department_id
FROM   employees    e,
       departments  d,
       locations    l
WHERE  e.department_id = d.department_id
  AND  d.location_id   = l.location_id
  AND  UPPER(l.state_province) = 'CALIFORNIA';

-- CÂU 34
-- Kiem tra truoc
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

-- Cap nhat
UPDATE employees
SET    last_name = 'Drexler'
WHERE  employee_id = 3;

COMMIT;

-- Xac nhan sau khi cap nhat
SELECT employee_id, last_name FROM employees WHERE employee_id = 3;

-- CÂU 35
SELECT e1.last_name, e1.salary, e1.department_id
FROM   employees e1
WHERE  e1.salary < (SELECT AVG(e2.salary)
                    FROM   employees e2
                    WHERE  e2.department_id = e1.department_id)
ORDER BY e1.department_id;

-- CÂU 36
-- Kiem tra truoc: xem ai bi anh huong
SELECT employee_id, last_name, salary
FROM   employees
WHERE  salary < 900;

-- Tang luong
UPDATE employees
SET    salary = salary + 100
WHERE  salary < 900;

COMMIT;

-- câu 37
-- Kiem tra: co nhan vien trong phong 500 khong?
SELECT COUNT(*) FROM employees WHERE department_id = 500;
-- Truong hop 1: Phong trong (khong co nhan vien)
DELETE FROM departments WHERE department_id = 500;
COMMIT;

-- Truong hop 2: Phong co nhan vien -> phai xu ly truoc
UPDATE employees SET department_id = NULL WHERE department_id = 500;
DELETE FROM departments WHERE department_id = 500;
COMMIT;

-- CÂU 38
-- Kiem tra truoc
SELECT department_id, department_name FROM departments
WHERE  department_id NOT IN (
    SELECT DISTINCT department_id FROM employees
    WHERE  department_id IS NOT NULL
);

-- Thực hiện xoá
DELETE FROM departments d
WHERE NOT EXISTS (
    SELECT 1 FROM employees e
    WHERE e.department_id = d.department_id
);
COMMIT;

-- PHẦN 3
-- A1
-- Bảng DMKHOA
CREATE TABLE DMKHOA (
    MAKHOA CHAR(2) PRIMARY KEY, -- Mã khoa [cite: 112]
    TENKHOA NVARCHAR2(30) -- Tên khoa [cite: 112]
);

-- Bảng DMMH
CREATE TABLE DMMH (
    MAMH CHAR(2) PRIMARY KEY,
    TENMH NVARCHAR2(35), 
    SOTIET NUMBER(3)
);

-- Bảng DMSV
CREATE TABLE DMSV (
    MASV CHAR(3) PRIMARY KEY,
    HOSV NVARCHAR2(30),
    TENSV NVARCHAR2(10),
    PHAI NVARCHAR2(3),
    NGAYSINH DATE,
    NOISINH NVARCHAR2(25),
    MAKH CHAR(2),
    HOCBONG NUMBER(10,0),
    CONSTRAINT FK_DMSV_DMKHOA FOREIGN KEY (MAKH) REFERENCES DMKHOA(MAKHOA)
);

-- Bảng KETQUA
CREATE TABLE KETQUA (
    MASV CHAR(3),
    MAMH CHAR(2),
    CONSTRAINT PK_KETQUA PRIMARY KEY (MASV, MAMH),
    CONSTRAINT FK_KETQUA_DMSV FOREIGN KEY (MASV) REFERENCES DMSV(MASV),
    CONSTRAINT FK_KETQUA_DMMH FOREIGN KEY (MAMH) REFERENCES DMMH(MAMH)
);

-- CHÈN DỮ LIỆU
-- CHÈN DỮ LIỆU BẢNG DMKHOA (5 KHOA)
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('CN', N'Công nghệ thông tin');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('KT', N'Kế toán');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('QT', N'Quản trị kinh doanh');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('NN', N'Ngoại ngữ');
INSERT INTO DMKHOA (MAKHOA, TENKHOA) VALUES ('DT', N'Điện tử viễn thông');
SELECT * FROM DMKHOA

-- CHÈN DỮ LIỆU BẢNG DMMH (10 MÔN HỌC)
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('C1', N'Cơ sở dữ liệu', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('C2', N'Cấu trúc dữ liệu', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('M1', N'Mạng máy tính', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('L1', N'Lập trình Java', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('T1', N'Toán cao cấp', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('T2', N'Toán rời rạc', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('K1', N'Kinh tế vi mô', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('K2', N'Kinh tế vĩ mô', 45);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('N1', N'Tiếng Anh giao tiếp', 60);
INSERT INTO DMMH (MAMH, TENMH, SOTIET) VALUES ('N2', N'Tiếng Anh chuyên ngành', 45);
SELECT * FROM DMMH


-- CHÈN DỮ LIỆU BẢNG DMSV (20 SINH VIÊN)
INSERT INTO DMSV VALUES ('S01', N'Nguyễn Văn', N'An', N'Nam', TO_DATE('15/05/2004', 'DD/MM/YYYY'), N'Hà Nội', 'CN', 1500000);
INSERT INTO DMSV VALUES ('S02', N'Trần Thị', N'Bình', N'Nữ', TO_DATE('20/08/2004', 'DD/MM/YYYY'), N'Hải Phòng', 'CN', 0);
INSERT INTO DMSV VALUES ('S03', N'Lê Hoàng', N'Cường', N'Nam', TO_DATE('10/02/2003', 'DD/MM/YYYY'), N'Nam Định', 'KT', 2000000);
INSERT INTO DMSV VALUES ('S04', N'Phạm Thị', N'Dung', N'Nữ', TO_DATE('25/11/2004', 'DD/MM/YYYY'), N'Thái Bình', 'KT', 0);
INSERT INTO DMSV VALUES ('S05', N'Hoàng Minh', N'Duy', N'Nam', TO_DATE('05/09/2004', 'DD/MM/YYYY'), N'Thanh Hóa', 'QT', 1000000);
INSERT INTO DMSV VALUES ('S06', N'Đinh Thu', N'Hà', N'Nữ', TO_DATE('12/12/2003', 'DD/MM/YYYY'), N'Nghệ An', 'NN', 500000);
INSERT INTO DMSV VALUES ('S07', N'Vũ Đức', N'Hải', N'Nam', TO_DATE('28/02/2004', 'DD/MM/YYYY'), N'Hà Nội', 'DT', 0);
INSERT INTO DMSV VALUES ('S08', N'Bùi Thị', N'Hoa', N'Nữ', TO_DATE('19/04/2004', 'DD/MM/YYYY'), N'Nam Định', 'CN', 1200000);
INSERT INTO DMSV VALUES ('S09', N'Đỗ Trọng', N'Hùng', N'Nam', TO_DATE('01/07/2003', 'DD/MM/YYYY'), N'Hải Phòng', 'KT', 0);
INSERT INTO DMSV VALUES ('S10', N'Ngô Thị', N'Lan', N'Nữ', TO_DATE('14/06/2004', 'DD/MM/YYYY'), N'Hà Nội', 'NN', 2500000);
INSERT INTO DMSV VALUES ('S11', N'Lý Công', N'Lý', N'Nam', TO_DATE('30/01/2004', 'DD/MM/YYYY'), N'Bắc Ninh', 'QT', 0);
INSERT INTO DMSV VALUES ('S12', N'Đào Mai', N'Phương', N'Nữ', TO_DATE('08/03/2004', 'DD/MM/YYYY'), N'Thái Bình', 'DT', 800000);
INSERT INTO DMSV VALUES ('S13', N'Phan Thanh', N'Quang', N'Nam', TO_DATE('22/10/2003', 'DD/MM/YYYY'), N'Thanh Hóa', 'CN', 0);
INSERT INTO DMSV VALUES ('S14', N'Trịnh Yến', N'Nhi', N'Nữ', TO_DATE('11/11/2004', 'DD/MM/YYYY'), N'Hà Nội', 'KT', 1500000);
INSERT INTO DMSV VALUES ('S15', N'Trương Cát', N'Tường', N'Nữ', TO_DATE('04/04/2004', 'DD/MM/YYYY'), N'Đà Nẵng', 'NN', 0);
INSERT INTO DMSV VALUES ('S16', N'Cao Tuấn', N'Tài', N'Nam', TO_DATE('16/08/2003', 'DD/MM/YYYY'), N'Hải Dương', 'QT', 1800000);
INSERT INTO DMSV VALUES ('S17', N'Tạ Phương', N'Thảo', N'Nữ', TO_DATE('27/05/2004', 'DD/MM/YYYY'), N'Nghệ An', 'DT', 0);
INSERT INTO DMSV VALUES ('S18', N'Lâm Chí', N'Vỹ', N'Nam', TO_DATE('09/09/2004', 'DD/MM/YYYY'), N'TP HCM', 'CN', 2000000);
INSERT INTO DMSV VALUES ('S19', N'Hồ Bảo', N'Ngọc', N'Nữ', TO_DATE('21/01/2004', 'DD/MM/YYYY'), N'Đồng Nai', 'KT', 0);
INSERT INTO DMSV VALUES ('S20', N'Nguyễn Tấn', N'Phát', N'Nam', TO_DATE('02/02/2003', 'DD/MM/YYYY'), N'Bình Dương', 'QT', 500000);
SELECT * FROM DMSV

-- CHÈN DỮ LIỆU BẢNG KETQUA
INSERT INTO KETQUA VALUES ('S01', 'C1');
INSERT INTO KETQUA VALUES ('S01', 'C2');
INSERT INTO KETQUA VALUES ('S01', 'L1');
INSERT INTO KETQUA VALUES ('S02', 'C1');
INSERT INTO KETQUA VALUES ('S02', 'M1');
INSERT INTO KETQUA VALUES ('S08', 'C2');
INSERT INTO KETQUA VALUES ('S08', 'L1');
INSERT INTO KETQUA VALUES ('S08', 'T2');
INSERT INTO KETQUA VALUES ('S13', 'C1');
INSERT INTO KETQUA VALUES ('S13', 'M1');
INSERT INTO KETQUA VALUES ('S18', 'L1');
INSERT INTO KETQUA VALUES ('S18', 'T2');
INSERT INTO KETQUA VALUES ('S03', 'T1');
INSERT INTO KETQUA VALUES ('S03', 'K1');
INSERT INTO KETQUA VALUES ('S04', 'K1');
INSERT INTO KETQUA VALUES ('S04', 'K2');
INSERT INTO KETQUA VALUES ('S05', 'T1');
INSERT INTO KETQUA VALUES ('S05', 'K2');
INSERT INTO KETQUA VALUES ('S09', 'K1');
INSERT INTO KETQUA VALUES ('S11', 'K2');
INSERT INTO KETQUA VALUES ('S14', 'T1');
INSERT INTO KETQUA VALUES ('S14', 'K1');
INSERT INTO KETQUA VALUES ('S16', 'K2');
INSERT INTO KETQUA VALUES ('S19', 'T1');
INSERT INTO KETQUA VALUES ('S20', 'K1');
INSERT INTO KETQUA VALUES ('S20', 'K2');
INSERT INTO KETQUA VALUES ('S06', 'N1');
INSERT INTO KETQUA VALUES ('S06', 'N2');
INSERT INTO KETQUA VALUES ('S10', 'N1');
INSERT INTO KETQUA VALUES ('S10', 'N2');
INSERT INTO KETQUA VALUES ('S15', 'N1');
INSERT INTO KETQUA VALUES ('S07', 'T1');
INSERT INTO KETQUA VALUES ('S07', 'M1');
INSERT INTO KETQUA VALUES ('S12', 'M1');
INSERT INTO KETQUA VALUES ('S12', 'C1');
INSERT INTO KETQUA VALUES ('S17', 'T1');
INSERT INTO KETQUA VALUES ('S17', 'C1');
INSERT INTO KETQUA VALUES ('S01', 'N1');
INSERT INTO KETQUA VALUES ('S03', 'N1');
INSERT INTO KETQUA VALUES ('S08', 'N1');
INSERT INTO KETQUA VALUES ('S12', 'N1');
SELECT * FROM KETQUA

COMMIT;

-- A2
-- Tạo bảng
-- Bảng PHONGBAN (Tạo trước, chưa gắn khóa ngoại TRPHG)
CREATE TABLE PHONGBAN (
    MAPHG NUMBER(2) PRIMARY KEY,
    TENPHG NVARCHAR2(50),
    TRPHG CHAR(9), 
    NG_NHANCHUC DATE
);

-- Bảng NHANVIEN (Có khóa ngoại tham chiếu đến PHONGBAN và tự kết)
CREATE TABLE NHANVIEN (
    MANV CHAR(9) PRIMARY KEY,
    HONV NVARCHAR2(20),
    TENLOT NVARCHAR2(20),
    TENNV NVARCHAR2(20),
    NGAYSINH DATE,
    DCHI NVARCHAR2(100),
    PHAI NVARCHAR2(10),
    LUONG NUMBER(10,2),
    MA_NQL CHAR(9),
    PHG NUMBER(2),
    CONSTRAINT FK_NV_PHG FOREIGN KEY (PHG) REFERENCES PHONGBAN(MAPHG),
    CONSTRAINT FK_NV_NQL FOREIGN KEY (MA_NQL) REFERENCES NHANVIEN(MANV)
);

-- Cập nhật khóa ngoại TRPHG cho bảng PHONGBAN
ALTER TABLE PHONGBAN 
ADD CONSTRAINT FK_PB_TRPHG FOREIGN KEY (TRPHG) REFERENCES NHANVIEN(MANV);

-- Bảng DIADIEM_PHG (Khóa chính ghép, tham chiếu đến PHONGBAN)
CREATE TABLE DIADIEM_PHG (
    MAPHG NUMBER(2),
    DIADIEM NVARCHAR2(50),
    CONSTRAINT PK_DIADIEM_PHG PRIMARY KEY (MAPHG, DIADIEM),
    CONSTRAINT FK_DDP_PB FOREIGN KEY (MAPHG) REFERENCES PHONGBAN(MAPHG)
);

-- Bảng DEAN (Tham chiếu đến PHONGBAN)
CREATE TABLE DEAN (
    MADA NUMBER(3) PRIMARY KEY,
    TENDA NVARCHAR2(50),
    DDIEM_DA NVARCHAR2(50),
    PHONG NUMBER(2),
    CONSTRAINT FK_DA_PB FOREIGN KEY (PHONG) REFERENCES PHONGBAN(MAPHG)
);

-- Bảng PHANCONG (Khóa chính ghép, tham chiếu đến NHANVIEN và DEAN)
CREATE TABLE PHANCONG (
    MA_NVIEN CHAR(9),
    MADA NUMBER(3),
    THOIGIAN NUMBER(5,1),
    CONSTRAINT PK_PHANCONG PRIMARY KEY (MA_NVIEN, MADA),
    CONSTRAINT FK_PC_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV),
    CONSTRAINT FK_PC_DA FOREIGN KEY (MADA) REFERENCES DEAN(MADA)
);

-- Bảng THANNHAN (Khóa chính ghép, tham chiếu đến NHANVIEN)
CREATE TABLE THANNHAN (
    MA_NVIEN CHAR(9),
    TENTN NVARCHAR2(50),
    PHAI NVARCHAR2(10),
    NGSINH DATE,
    QUANHE NVARCHAR2(20),
    CONSTRAINT PK_THANNHAN PRIMARY KEY (MA_NVIEN, TENTN),
    CONSTRAINT FK_TN_NV FOREIGN KEY (MA_NVIEN) REFERENCES NHANVIEN(MANV)
);

-- NHẬP DỮ LIỆU
-- CHÈN PHÒNG BAN (TẠM ĐỂ TRPHG = NULL)
INSERT INTO PHONGBAN VALUES (1, N'Quản lý', NULL, TO_DATE('01/01/2015', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (4, N'Điều hành', NULL, TO_DATE('01/02/2018', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (5, N'Nghiên cứu', NULL, TO_DATE('22/05/2019', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (6, N'Kế toán', NULL, TO_DATE('15/06/2020', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (7, N'Nhân sự', NULL, TO_DATE('10/10/2021', 'DD/MM/YYYY'));
INSERT INTO PHONGBAN VALUES (8, N'Công nghệ (IT)', NULL, TO_DATE('05/05/2022', 'DD/MM/YYYY'));
SELECT * FROM PHONGBAN

-- CHÈN NHÂN VIÊN (18 NHÂN VIÊN)
INSERT INTO NHANVIEN VALUES ('888665555', N'Vương', N'Ngọc', N'Quyền', TO_DATE('10/10/1955', 'DD/MM/YYYY'), N'450 Trưng Vương, Hà Nội', N'Nam', 75000, NULL, 1);
INSERT INTO NHANVIEN VALUES ('987654321', N'Lê', N'Thị', N'Nhàn', TO_DATE('20/06/1951', 'DD/MM/YYYY'), N'291 Hồ Văn Huê, QPN, TPHCM', N'Nữ', 63000, '888665555', 4);
INSERT INTO NHANVIEN VALUES ('333445555', N'Phạm', N'Văn', N'Vinh', TO_DATE('08/12/1965', 'DD/MM/YYYY'), N'638 Nguyễn Văn Cừ, Q5, TPHCM', N'Nam', 50000, '888665555', 5);

INSERT INTO NHANVIEN VALUES ('111223344', N'Trần', N'Trọng', N'Kim', TO_DATE('15/04/1975', 'DD/MM/YYYY'), N'123 Lê Lợi, Q1, TPHCM', N'Nam', 48000, '888665555', 6);
INSERT INTO NHANVIEN VALUES ('555667788', N'Nguyễn', N'Mai', N'Anh', TO_DATE('22/09/1982', 'DD/MM/YYYY'), N'45 Cầu Giấy, Hà Nội', N'Nữ', 45000, '888665555', 7);
INSERT INTO NHANVIEN VALUES ('999000111', N'Lý', N'Tuấn', N'Hải', TO_DATE('01/11/1985', 'DD/MM/YYYY'), N'789 Điện Biên Phủ, Đà Nẵng', N'Nam', 55000, '888665555', 8);

INSERT INTO NHANVIEN VALUES ('123456789', N'Đinh', N'Bá', N'Tiến', TO_DATE('09/01/1965', 'DD/MM/YYYY'), N'731 Trần Hưng Đạo, Q1, TPHCM', N'Nam', 30000, '333445555', 5);
INSERT INTO NHANVIEN VALUES ('453453453', N'Nguyễn', N'Thanh', N'Tùng', TO_DATE('31/07/1972', 'DD/MM/YYYY'), N'563 Hai Bà Trưng, Q3, TPHCM', N'Nam', 25000, '333445555', 5);
INSERT INTO NHANVIEN VALUES ('777888999', N'Hoàng', N'Thị', N'Quyên', TO_DATE('15/03/1990', 'DD/MM/YYYY'), N'12 An Dương Vương, Q5, TPHCM', N'Nữ', 28000, '333445555', 5);
INSERT INTO NHANVIEN VALUES ('101010101', N'Vũ', N'Trọng', N'Phụng', TO_DATE('20/12/1988', 'DD/MM/YYYY'), N'88 Lý Thường Kiệt, Q10, TPHCM', N'Nam', 32000, '123456789', 5);

INSERT INTO NHANVIEN VALUES ('999887777', N'Bùi', N'Thúy', N'Vũ', TO_DATE('19/07/1968', 'DD/MM/YYYY'), N'332 Nguyễn Thái Học, Q1, TPHCM', N'Nữ', 25000, '987654321', 4);
INSERT INTO NHANVIEN VALUES ('202020202', N'Đào', N'Nhật', N'Nam', TO_DATE('14/02/1995', 'DD/MM/YYYY'), N'111 Phan Đăng Lưu, PN, TPHCM', N'Nam', 22000, '987654321', 4);
INSERT INTO NHANVIEN VALUES ('303030303', N'Lê', N'Hồng', N'Hạnh', TO_DATE('28/08/1992', 'DD/MM/YYYY'), N'222 Quang Trung, GV, TPHCM', N'Nữ', 24000, '999887777', 4);

INSERT INTO NHANVIEN VALUES ('404040404', N'Ngô', N'Tất', N'Tố', TO_DATE('10/05/1980', 'DD/MM/YYYY'), N'55 Hai Bà Trưng, Hoàn Kiếm, HN', N'Nam', 29000, '111223344', 6);
INSERT INTO NHANVIEN VALUES ('505050505', N'Nguyễn', N'Thị', N'Bính', TO_DATE('19/11/1989', 'DD/MM/YYYY'), N'66 Đinh Tiên Hoàng, Q1, TPHCM', N'Nữ', 27000, '111223344', 6);
INSERT INTO NHANVIEN VALUES ('606060606', N'Phạm', N'Xuân', N'Diệu', TO_DATE('02/09/1996', 'DD/MM/YYYY'), N'77 Xã Đàn, Đống Đa, HN', N'Nam', 26000, '555667788', 7);

INSERT INTO NHANVIEN VALUES ('707070707', N'Cù', N'Huy', N'Cận', TO_DATE('11/11/1993', 'DD/MM/YYYY'), N'99 Nguyễn Văn Linh, Đà Nẵng', N'Nam', 35000, '999000111', 8);
INSERT INTO NHANVIEN VALUES ('808080808', N'Nguyễn', N'Tố', N'Hữu', TO_DATE('04/04/1998', 'DD/MM/YYYY'), N'101 Tôn Đức Thắng, Đà Nẵng', N'Nam', 31000, '999000111', 8);

SELECT * FROM NHANVIEN

-- CẬP NHẬT TRƯỞNG PHÒNG
UPDATE PHONGBAN SET TRPHG = '888665555' WHERE MAPHG = 1;
UPDATE PHONGBAN SET TRPHG = '987654321' WHERE MAPHG = 4;
UPDATE PHONGBAN SET TRPHG = '333445555' WHERE MAPHG = 5;
UPDATE PHONGBAN SET TRPHG = '111223344' WHERE MAPHG = 6;
UPDATE PHONGBAN SET TRPHG = '555667788' WHERE MAPHG = 7;
UPDATE PHONGBAN SET TRPHG = '999000111' WHERE MAPHG = 8;
SELECT * FROM PHONGBAN

-- CHÈN ĐỊA ĐIỂM PHÒNG
INSERT INTO DIADIEM_PHG VALUES (1, N'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (4, N'TPHCM');
INSERT INTO DIADIEM_PHG VALUES (5, N'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (5, N'TPHCM');
INSERT INTO DIADIEM_PHG VALUES (5, N'Nha Trang');
INSERT INTO DIADIEM_PHG VALUES (6, N'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (6, N'TPHCM');
INSERT INTO DIADIEM_PHG VALUES (7, N'Hà Nội');
INSERT INTO DIADIEM_PHG VALUES (8, N'Đà Nẵng');
INSERT INTO DIADIEM_PHG VALUES (8, N'TPHCM');
SELECT * FROM DIADIEM_PHG


-- CHÈN ĐỀ ÁN (10 ĐỀ ÁN)
INSERT INTO DEAN VALUES (1, N'Sản phẩm X', N'Nha Trang', 5);
INSERT INTO DEAN VALUES (2, N'Sản phẩm Y', N'Vũng Tàu', 5);
INSERT INTO DEAN VALUES (3, N'Sản phẩm Z', N'Hà Nội', 5);
INSERT INTO DEAN VALUES (10, N'Tin học hóa', N'Hà Nội', 4);
INSERT INTO DEAN VALUES (20, N'Tổ chức lại', N'TPHCM', 1);
INSERT INTO DEAN VALUES (30, N'Kiểm toán nội bộ', N'Hà Nội', 6);
INSERT INTO DEAN VALUES (40, N'Đào tạo hội nhập', N'Hà Nội', 7);
INSERT INTO DEAN VALUES (50, N'Hệ thống ERP', N'Đà Nẵng', 8);
INSERT INTO DEAN VALUES (60, N'Bảo mật dữ liệu', N'TPHCM', 8);
INSERT INTO DEAN VALUES (70, N'Tối ưu kho bãi', N'TPHCM', 4);
SELECT * FROM DEAN

-- CHÈN PHÂN CÔNG (26 PHÂN CÔNG)
INSERT INTO PHANCONG VALUES ('123456789', 1, 32.5);
INSERT INTO PHANCONG VALUES ('123456789', 2, 7.5);
INSERT INTO PHANCONG VALUES ('453453453', 1, 20.0);
INSERT INTO PHANCONG VALUES ('453453453', 2, 20.0);
INSERT INTO PHANCONG VALUES ('333445555', 2, 10.0);
INSERT INTO PHANCONG VALUES ('333445555', 3, 10.0);
INSERT INTO PHANCONG VALUES ('333445555', 10, 10.0);
INSERT INTO PHANCONG VALUES ('333445555', 20, 10.0);
INSERT INTO PHANCONG VALUES ('987654321', 20, 15.0);
INSERT INTO PHANCONG VALUES ('987654321', 30, 20.0);
INSERT INTO PHANCONG VALUES ('888665555', 20, NULL);
INSERT INTO PHANCONG VALUES ('777888999', 1, 15.0);
INSERT INTO PHANCONG VALUES ('777888999', 3, 10.0);
INSERT INTO PHANCONG VALUES ('101010101', 2, 25.0);
INSERT INTO PHANCONG VALUES ('999887777', 10, 10.0);
INSERT INTO PHANCONG VALUES ('999887777', 30, 30.0);
INSERT INTO PHANCONG VALUES ('202020202', 10, 35.0);
INSERT INTO PHANCONG VALUES ('303030303', 70, 40.0);
INSERT INTO PHANCONG VALUES ('111223344', 30, 25.0);
INSERT INTO PHANCONG VALUES ('404040404', 30, 20.0);
INSERT INTO PHANCONG VALUES ('505050505', 30, 15.0);
INSERT INTO PHANCONG VALUES ('555667788', 40, 20.0);
INSERT INTO PHANCONG VALUES ('606060606', 40, 35.0);
INSERT INTO PHANCONG VALUES ('999000111', 50, 15.0);
INSERT INTO PHANCONG VALUES ('999000111', 60, 20.0);
INSERT INTO PHANCONG VALUES ('707070707', 50, 40.0);
INSERT INTO PHANCONG VALUES ('808080808', 60, 35.0);
SELECT * FROM PHANCONG

-- CHÈN THÂN NHÂN
INSERT INTO THANNHAN VALUES ('333445555', N'Trương', N'Nữ', TO_DATE('05/04/1958', 'DD/MM/YYYY'), N'Vợ chồng');
INSERT INTO THANNHAN VALUES ('333445555', N'Minh', N'Nam', TO_DATE('01/01/1982', 'DD/MM/YYYY'), N'Con trai');
INSERT INTO THANNHAN VALUES ('333445555', N'Khánh', N'Nam', TO_DATE('05/05/1988', 'DD/MM/YYYY'), N'Con trai');
INSERT INTO THANNHAN VALUES ('987654321', N'Đăng', N'Nam', TO_DATE('28/02/1952', 'DD/MM/YYYY'), N'Vợ chồng');
INSERT INTO THANNHAN VALUES ('123456789', N'Châu', N'Nữ', TO_DATE('30/12/1988', 'DD/MM/YYYY'), N'Con gái');
INSERT INTO THANNHAN VALUES ('111223344', N'Kim Anh', N'Nữ', TO_DATE('14/02/1980', 'DD/MM/YYYY'), N'Vợ chồng');
INSERT INTO THANNHAN VALUES ('777888999', N'Tuấn', N'Nam', TO_DATE('15/06/2015', 'DD/MM/YYYY'), N'Con trai');
INSERT INTO THANNHAN VALUES ('999000111', N'Lan', N'Nữ', TO_DATE('20/10/1990', 'DD/MM/YYYY'), N'Vợ chồng');
SELECT * FROM THANNHAN

COMMIT;
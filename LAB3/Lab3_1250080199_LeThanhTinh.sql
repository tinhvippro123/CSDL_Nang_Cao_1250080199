-- Tạo bảng COURSE
CREATE TABLE COURSE (
    CourseNo NUMBER(8, 0) NOT NULL,
    Description VARCHAR2(50),
    Cost NUMBER(9, 2),
    Prerequisite NUMBER(8, 0),
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_COURSE PRIMARY KEY (CourseNo)
);

-- Tạo bảng INSTRUCTOR
CREATE TABLE INSTRUCTOR (
    InstructorID NUMBER(8) NOT NULL,
    Salutation VARCHAR2(5),
    FirstName VARCHAR2(25),
    LastName VARCHAR2(25),
    Address VARCHAR2(50),
    Phone VARCHAR2(15),
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_INSTRUCTOR PRIMARY KEY (InstructorID)
);

-- Tạo bảng STUDENT
CREATE TABLE STUDENT (
    StudentID NUMBER(8, 0) NOT NULL,
    Salutation VARCHAR2(5),
    FirstName VARCHAR2(25),
    LastName VARCHAR2(25) NOT NULL,
    Address VARCHAR2(50),
    Phone VARCHAR2(15),
    Employer VARCHAR2(50),
    RegistrationDate DATE NOT NULL,
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_STUDENT PRIMARY KEY (StudentID)
);

-- Tạo bảng CLASS
CREATE TABLE CLASS (
    ClassID NUMBER(8, 0) NOT NULL,
    CourseNo NUMBER(8, 0) NOT NULL,
    ClassNo NUMBER(3) NOT NULL,
    StartDateTime DATE,
    Location VARCHAR2(50),
    InstructorID NUMBER(8, 0) NOT NULL,
    Capacity NUMBER(3, 0),
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_CLASS PRIMARY KEY (ClassID),
    CONSTRAINT FK_CLASS_COURSE FOREIGN KEY (CourseNo) REFERENCES COURSE(CourseNo),
    CONSTRAINT FK_CLASS_INSTRUCTOR FOREIGN KEY (InstructorID) REFERENCES INSTRUCTOR(InstructorID)
);

-- Tạo bảng ENROLLMENT
CREATE TABLE ENROLLMENT (
    StudentID NUMBER(8, 0) NOT NULL,
    ClassID NUMBER(8, 0) NOT NULL,
    EnrollDate DATE NOT NULL,
    FinalGrade NUMBER(3, 0),
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_ENROLLMENT PRIMARY KEY (StudentID, ClassID),
    CONSTRAINT FK_ENROLL_STUDENT FOREIGN KEY (StudentID) REFERENCES STUDENT(StudentID),
    CONSTRAINT FK_ENROLL_CLASS FOREIGN KEY (ClassID) REFERENCES CLASS(ClassID)
);

-- Tạo bảng GRADE
CREATE TABLE GRADE (
    StudentID NUMBER(8) NOT NULL,
    ClassID NUMBER(8) NOT NULL,
    Grade NUMBER(3) NOT NULL,
    Comments VARCHAR2(2000),
    CreatedBy VARCHAR2(30) NOT NULL,
    CreatedDate DATE NOT NULL,
    ModifiedBy VARCHAR2(30) NOT NULL,
    ModifiedDate DATE NOT NULL,
    CONSTRAINT PK_GRADE PRIMARY KEY (StudentID, ClassID, Grade),
    CONSTRAINT FK_GRADE_ENROLL FOREIGN KEY (StudentID, ClassID) REFERENCES ENROLLMENT(StudentID, ClassID)
);

-- Thêm ràng buộc tự tham chiếu cho bảng COURSE
ALTER TABLE COURSE ADD CONSTRAINT FK_COURSE_PREREQ FOREIGN KEY (Prerequisite) REFERENCES COURSE(CourseNo);

show user

-- Thêm dự liệu
-- INSTRUCTOR
INSERT INTO INSTRUCTOR VALUES (1, 'ThS.', 'Minh Tuấn', 'Nguyễn', 'Quận 1, TP.HCM', '0901234567', 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO INSTRUCTOR VALUES (2, 'TS.', 'Thu Hà', 'Trần', 'Quận 3, TP.HCM', '0987654321', 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

-- COURSE
INSERT INTO COURSE VALUES (10, 'Tổng quan Cơ sở dữ liệu', 1000, NULL, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO COURSE VALUES (20, 'Nhập môn Lập trình', 1200, 10, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

-- CLASS
INSERT INTO CLASS VALUES (101, 10, 1, SYSDATE, 'Phòng A1', 1, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO CLASS VALUES (102, 10, 2, SYSDATE, 'Phòng A2', 1, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO CLASS VALUES (103, 20, 1, SYSDATE, 'Phòng B1', 1, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO CLASS VALUES (104, 20, 2, SYSDATE, 'Phòng B2', 1, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO CLASS VALUES (105, 10, 3, SYSDATE, 'Phòng A3', 1, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

-- STUDENT
INSERT INTO STUDENT VALUES (12580199, 'Nam', 'Thanh Tùng', 'Lê', 'Gò Vấp, TP.HCM', '0911000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

INSERT INTO STUDENT VALUES (12580201, 'Nữ', 'Thị Hoa', 'Vũ', 'Tân Bình, TP.HCM', '0922000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580202, 'Nam', 'Thái Sơn', 'Đặng', 'Quận 10, TP.HCM', '0933000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580203, 'Nam', 'Văn Tiến', 'Bùi', 'Quận 1, TP.HCM', '0944000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580204, 'Nam', 'Minh Tuấn', 'Đỗ', 'Quận 3, TP.HCM', '0955000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580205, 'Nữ', 'Thị Lan', 'Ngô', 'Quận 5, TP.HCM', '0966000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580206, 'Nam', 'Trung Kiên', 'Dương', 'Bình Thạnh, TP.HCM', '0977000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580207, 'Nữ', 'Hải Yến', 'Lý', 'Quận 7, TP.HCM', '0988000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580208, 'Nam', 'Bảo Trọng', 'Đào', 'Thủ Đức, TP.HCM', '0999000111', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580209, 'Nữ', 'Thanh Trúc', 'Đoàn', 'Quận 2, TP.HCM', '0901111222', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580210, 'Nam', 'Gia Bảo', 'Lâm', 'Quận 4, TP.HCM', '0902222333', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580211, 'Nam', 'Hoài Nam', 'Trịnh', 'Quận 6, TP.HCM', '0903333444', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580212, 'Nữ', 'Thu Thảo', 'Mai', 'Quận 8, TP.HCM', '0904444555', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580213, 'Nam', 'Khắc Tiệp', 'Phan', 'Quận 9, TP.HCM', '0905555666', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580214, 'Nữ', 'Tú Quỳnh', 'Chu', 'Quận 11, TP.HCM', '0906666777', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580215, 'Nam', 'Quang Hiếu', 'Hồ', 'Quận 12, TP.HCM', '0907777888', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO STUDENT VALUES (12580216, 'Nam', 'Xuân Đạt', 'Cao', 'Phú Nhuận, TP.HCM', '0908888999', 'Sinh viên', SYSDATE, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

-- ENROLLMENT
INSERT INTO ENROLLMENT VALUES (12580201, 101, SYSDATE, 95, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580202, 101, SYSDATE, 85, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580203, 101, SYSDATE, 75, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580204, 101, SYSDATE, 65, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580205, 101, SYSDATE, 45, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580206, 101, SYSDATE, 90, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580207, 101, SYSDATE, 80, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580208, 101, SYSDATE, 70, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580209, 101, SYSDATE, 55, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580210, 101, SYSDATE, 40, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580211, 101, SYSDATE, 92, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580212, 101, SYSDATE, 88, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580213, 101, SYSDATE, 72, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580214, 101, SYSDATE, 60, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580215, 101, SYSDATE, 30, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580216, 101, SYSDATE, 99, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

INSERT INTO ENROLLMENT VALUES (12580199, 102, SYSDATE, 85, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580199, 103, SYSDATE, 70, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);
INSERT INTO ENROLLMENT VALUES (12580199, 104, SYSDATE, 90, 'ADMIN', SYSDATE, 'ADMIN', SYSDATE);

COMMIT;


-- bài 1
-- 1.
-- câu a
CREATE TABLE Cau1 ( 
    ID NUMBER, 
    NAME VARCHAR2(20) 
);
show user


-- câu b
CREATE SEQUENCE Cau1Seq 
    START WITH 5 
    INCREMENT BY 5;
show user


-- câu c -> j
SET SERVEROUTPUT ON; 
DECLARE 
    v_name VARCHAR2(50); 
    v_id NUMBER; 
BEGIN 
    -- [d] Them sinh vien dang ki nhieu mon nhat 
    SELECT firstname || ' ' || lastname 
    INTO v_name 
    FROM student 
    WHERE studentid = ( 
        SELECT studentid FROM enrollment 
        GROUP BY studentid 
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM enrollment GROUP BY studentid) 
        FETCH FIRST 1 ROWS ONLY 
    ); 
    INSERT INTO Cau1 (ID, NAME) 
    VALUES (Cau1Seq.NEXTVAL, v_name); 
    SAVEPOINT sp_a; -- Savepoint A 
    
    -- [e] Them sinh vien dang ki it mon nhat 
    SELECT firstname || ' ' || lastname 
    INTO v_name 
    FROM student 
    WHERE studentid = ( 
        SELECT studentid FROM enrollment 
        GROUP BY studentid 
        HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM enrollment GROUP BY studentid) 
        FETCH FIRST 1 ROWS ONLY 
    ); 
    INSERT INTO Cau1 (ID, NAME) 
    VALUES (Cau1Seq.NEXTVAL, v_name); 
    SAVEPOINT sp_b; -- Savepoint B 
    
    -- [f] Them giao vien day nhieu lop nhat 
    SELECT i.firstname || ' ' || i.lastname 
    INTO v_name 
    FROM instructor i 
    WHERE i.instructorid = ( 
        SELECT instructorid FROM class 
        GROUP BY instructorid 
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM class GROUP BY instructorid) 
        FETCH FIRST 1 ROWS ONLY 
    ); 
    
    INSERT INTO Cau1 (ID, NAME) 
    VALUES (Cau1Seq.NEXTVAL, v_name); 
    SAVEPOINT sp_c; -- Savepoint C 
    
    -- [g] SELECT INTO: lay ID cua giao vien vua them vao bien v_id 
    SELECT ID INTO v_id 
    FROM Cau1 
    WHERE NAME = v_name; 
    
    DBMS_OUTPUT.PUT_LINE('ID giao vien nhieu lop: ' || v_id); 
    
    -- [h] Rollback giao vien nhieu lop (ve Savepoint B)
    
    ROLLBACK TO sp_b; 
    -- [i] Them giao vien it lop nhat, dung v_id da luu 
    SELECT i.firstname || ' ' || i.lastname 
    INTO v_name 
    FROM instructor i 
    WHERE i.instructorid = ( 
        SELECT instructorid FROM class 
        GROUP BY instructorid 
        HAVING COUNT(*) = (SELECT MIN(COUNT(*)) FROM class GROUP BY 
        instructorid) 
        FETCH FIRST 1 ROWS ONLY 
    ); 
    INSERT INTO Cau1 (ID, NAME) 
    VALUES (v_id, v_name); -- Dung v_id (khong phai sequence) 
    
    -- [j] Them lai giao vien nhieu lop, dung sequence 
    SELECT i.firstname || ' ' || i.lastname 
    INTO v_name 
    FROM instructor i 
        WHERE i.instructorid = ( 
        SELECT instructorid FROM class 
        GROUP BY instructorid 
        HAVING COUNT(*) = (SELECT MAX(COUNT(*)) FROM class GROUP BY instructorid) 
        FETCH FIRST 1 ROWS ONLY 
    ); 
    
    INSERT INTO Cau1 (ID, NAME) 
    VALUES (Cau1Seq.NEXTVAL, v_name); -- Dung sequence 
    
    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('Hoan tat! Kiem tra: SELECT * FROM Cau1;'); 
    
    EXCEPTION 
        WHEN NO_DATA_FOUND THEN 
            DBMS_OUTPUT.PUT_LINE('Loi: Khong tim thay du lieu!'); 
            ROLLBACK; 
        WHEN OTHERS THEN 
            DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM); 
            ROLLBACK; 
        END; 
/ 
show user

-- 2.
SET SERVEROUTPUT ON; 

DECLARE 
    v_sid NUMBER := &ma_sinh_vien; 
    v_fname VARCHAR2(25) := '&ho_sinh_vien'; 
    v_lname VARCHAR2(25) := '&ten_sinh_vien'; 
    v_addr VARCHAR2(50) := '&dia_chi'; 
    v_found VARCHAR2(50); 
    v_classes NUMBER; 
BEGIN 
    -- Thu tim sinh vien theo ma vua nhap 
    SELECT firstname || ' ' || lastname 
    INTO v_found 
    FROM student 
    WHERE studentid = v_sid; 
    -- Neu tim thay: dem so lop dang hoc 
    SELECT COUNT(*) 
    INTO v_classes 
    FROM enrollment 
    WHERE studentid = v_sid; 
    DBMS_OUTPUT.PUT_LINE('Ho ten: ' || v_found); 
    DBMS_OUTPUT.PUT_LINE('So lop dang hoc: ' || v_classes); 
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        -- Sinh vien chua ton tai: them moi 
        DBMS_OUTPUT.PUT_LINE('Sinh vien chua ton tai. Dang them moi...'); INSERT INTO student (studentid, firstname, lastname, address, 
        registrationdate, createdby, createddate, 
        modifiedby, modifieddate) 
        VALUES (v_sid, v_fname, v_lname, v_addr, 
        SYSDATE, USER, SYSDATE, USER, SYSDATE); 
        COMMIT; 
        DBMS_OUTPUT.PUT_LINE('Da them sinh vien moi: ' || v_fname || ' ' || v_lname); 
    END; 
/ 
show user
select * from student

-- bài 2
-- câu 1
SET SERVEROUTPUT ON; 

DECLARE 
    v_instructor_id NUMBER := &ma_giao_vien; 
    v_so_lop NUMBER; 
BEGIN 
    -- Dem so lop giao vien dang day 
    SELECT COUNT(*) 
    INTO v_so_lop 
    FROM class 
    WHERE instructorid = v_instructor_id; 
    
    -- Phan nhanh theo ket qua 
    IF v_so_lop >= 5 THEN 
        DBMS_OUTPUT.PUT_LINE('Giao vien nay nen nghi ngoi!'); 
    ELSE 
        DBMS_OUTPUT.PUT_LINE('So lop giao vien dang day: ' || v_so_lop); 
    END IF; 
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Khong tim thay giao vien co ma: ' || 
v_instructor_id); 
END; 
/ 
show user

-- câu 2
SET SERVEROUTPUT ON; 

DECLARE 
    v_sid NUMBER := &ma_sinh_vien; 
    v_cid NUMBER := &ma_lop; 
    v_score NUMBER; 
    v_grade VARCHAR2(2); 
    v_check NUMBER; 
BEGIN 
    -- Kiem tra sinh vien ton tai 
    SELECT COUNT(*) INTO v_check 
    FROM student WHERE studentid = v_sid; 
    IF v_check = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Loi: Ma sinh vien ' || v_sid || ' khong ton tai!'); 
        RETURN; 
    END IF; 
    
    -- Kiem tra lop ton tai 
    SELECT COUNT(*) INTO v_check 
        FROM class WHERE classid = v_cid; 
        IF v_check = 0 THEN 
        DBMS_OUTPUT.PUT_LINE('Loi: Ma lop ' || v_cid || ' khong ton tai!'); RETURN; 
    END IF; 
    
    -- Lay diem cua sinh vien trong lop 
    SELECT finalgrade 
    INTO v_score 
    FROM enrollment 
    WHERE studentid = v_sid AND classid = v_cid; 
    
-- Quy doi diem so sang diem chu bang CASE 
    CASE 
        WHEN v_score >= 90 THEN v_grade := 'A'; 
        WHEN v_score >= 80 THEN v_grade := 'B'; 
        WHEN v_score >= 70 THEN v_grade := 'C'; 
        WHEN v_score >= 50 THEN v_grade := 'D'; 
        ELSE v_grade := 'F'; 
    END CASE; 
    
    DBMS_OUTPUT.PUT_LINE('Diem so: ' || v_score || ' -> Diem chu: ' || v_grade); 
    
EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        DBMS_OUTPUT.PUT_LINE('Sinh vien chua dang ky lop nay hoac chua co diem!'); 
END; 
/ 
show user

-- bài 3
SET SERVEROUTPUT ON; 

DECLARE 
    -- Cursor 1: Duyet tung mon hoc 
    CURSOR cur_course IS 
        SELECT courseno, description 
        FROM course 
        ORDER BY courseno; 
    -- Cursor 2: Lay lop hoc cua mot mon (co doi so) 
    CURSOR cur_class (p_courseno NUMBER) IS 
        SELECT c.classno, 
        COUNT(e.studentid) AS so_sv 
        FROM class c 
        LEFT JOIN enrollment e ON c.classid = e.classid 
        WHERE c.courseno = p_courseno 
        GROUP BY c.classno 
        ORDER BY c.classno; 
    v_courseno course.courseno%TYPE; 
    v_desc course.description%TYPE; 
    v_classno class.classno%TYPE; 
    v_count NUMBER; 
BEGIN 
    -- Duyet cursor ngoai: tung mon hoc 
    OPEN cur_course; 
    LOOP 
        FETCH cur_course INTO v_courseno, v_desc; 
        EXIT WHEN cur_course%NOTFOUND; 
        
        -- In ten mon hoc 
        DBMS_OUTPUT.PUT_LINE(v_courseno || ' ' || v_desc); 
        
        -- Mo cursor trong voi doi so la ma mon hoc hien tai 
        OPEN cur_class(v_courseno); 
            LOOP 
            FETCH cur_class INTO v_classno, v_count; 
            EXIT WHEN cur_class%NOTFOUND; 
            DBMS_OUTPUT.PUT_LINE('Lop: ' || v_classno || ' co so luong sinh vien dang ki: ' || v_count); 
        END LOOP; 
        CLOSE cur_class; 
        
    END LOOP; 
    CLOSE cur_course; 
EXCEPTION 
    WHEN OTHERS THEN 
        IF cur_course%ISOPEN THEN CLOSE cur_course; END IF; 
        IF cur_class%ISOPEN THEN CLOSE cur_class; END IF; 
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM); 
END; 
/ 
show user

-- bài 4
-- 4.1a
CREATE OR REPLACE PROCEDURE find_sname 
    (i_student_id IN student.studentid%TYPE, 
    o_first_name OUT student.firstname%TYPE, 
    o_last_name OUT student.lastname%TYPE) 
IS 
BEGIN 
    SELECT firstname, lastname 
    INTO o_first_name, o_last_name 
    FROM student 
    WHERE studentid = i_student_id; 

EXCEPTION 
    WHEN NO_DATA_FOUND THEN 
        o_first_name := NULL; 
        o_last_name := NULL; 
        DBMS_OUTPUT.PUT_LINE('Khong tim thay sinh vien ID: ' || i_student_id); 
END find_sname; 
/
show user

-- câu 4.1b
CREATE OR REPLACE PROCEDURE print_student_name 
    (i_student_id IN student.studentid%TYPE) 
IS 
    v_first student.firstname%TYPE; 
    v_last student.lastname%TYPE; 
BEGIN 
    -- Goi thu tuc find_sname da co san 
    find_sname(i_student_id, v_first, v_last); 
    IF v_first IS NOT NULL OR v_last IS NOT NULL THEN 
    DBMS_OUTPUT.PUT_LINE('Ho ten sinh vien: ' || v_first || ' ' || v_last); 
    END IF; 
END print_student_name; 
/ 

-- Goi thu tuc de kiem tra: 
BEGIN 
    print_student_name(12580202); 
END; 
/
show user

-- câu 4.2
CREATE OR REPLACE PROCEDURE Discount 
IS 
BEGIN 
    FOR rec IN ( 
    SELECT c.courseno, c.description, c.cost 
    FROM course c 
    WHERE (SELECT COUNT(*) FROM enrollment e 
        JOIN class cl ON e.classid = cl.classid 
        WHERE cl.courseno = c.courseno) > 15 
    ) LOOP 
        -- Giam gia 5% 
        UPDATE course 
        SET cost = cost * 0.95 
        WHERE courseno = rec.courseno; 
        
        DBMS_OUTPUT.PUT_LINE('Da giam gia mon hoc: ' || rec.description || ' | Gia cu: ' || rec.cost || ' | Gia moi: ' || ROUND(rec.cost * 0.95, 2)); 
    END LOOP; 
    
    COMMIT; 
    DBMS_OUTPUT.PUT_LINE('Hoan tat giam gia.'); 
EXCEPTION 
    WHEN OTHERS THEN 
        ROLLBACK; 
        DBMS_OUTPUT.PUT_LINE('Loi: ' || SQLERRM); 
END Discount; 
/ 
show user

-- Goi thu tuc: 
BEGIN 
    Discount;
END; 
/ 
show user

-- câu 4.3
CREATE OR REPLACE FUNCTION Total_cost_for_student 
    (p_student_id IN student.studentid%TYPE) 
RETURN NUMBER 
IS 
    v_total NUMBER; 
    v_check NUMBER; 
BEGIN 
    -- Kiem tra sinh vien co ton tai khong 
    SELECT COUNT(*) INTO v_check 
    FROM student WHERE studentid = p_student_id; 
    
    IF v_check = 0 THEN 
        RETURN NULL; -- Sinh vien khong ton tai 
    END IF; 
    
    -- Tinh tong chi phi: sum(cost cua tung mon da dang ky) 
    SELECT NVL(SUM(co.cost), 0) 
    INTO v_total 
    FROM enrollment e 
    JOIN class cl ON e.classid = cl.classid 
    JOIN course co ON cl.courseno = co.courseno 
    WHERE e.studentid = p_student_id; 
    
    RETURN v_total; 
EXCEPTION 
    WHEN OTHERS THEN 
        RETURN NULL; 
END Total_cost_for_student; 
/ 

-- Goi ham de kiem tra: 
SELECT Total_cost_for_student(12580201) AS "Tong chi phi" FROM DUAL; 
-- Hoac trong PL/SQL: 
BEGIN 
    DBMS_OUTPUT.PUT_LINE('Tong chi phi: ' || Total_cost_for_student(12580201)); 
END; 
/ 
show user

-- bài 5
-- trigger cho bảng COURSE
CREATE OR REPLACE TRIGGER trg_course_audit
BEFORE INSERT OR UPDATE ON course
FOR EACH ROW
BEGIN
    IF INSERTING THEN
        :NEW.createdby := USER;
        :NEW.createddate := SYSDATE;
    END IF;
    -- Luon cap nhat modified (ca khi INSERT lan UPDATE) 
    :NEW.modifiedby := USER;
    :NEW.modifieddate := SYSDATE;
END trg_course_audit;
/
show user

-- trigger cho bảng CLASS
CREATE OR REPLACE TRIGGER trg_class_audit 
BEFORE INSERT OR UPDATE ON class 
FOR EACH ROW 
BEGIN 
    IF INSERTING THEN 
        :NEW.createdby := USER; 
        :NEW.createddate := SYSDATE; 
    END IF; 
    :NEW.modifiedby := USER; 
    :NEW.modifieddate := SYSDATE; 
END trg_class_audit; 
/
show user


-- trigger cho bảng STUDENT
CREATE OR REPLACE TRIGGER trg_student_audit 
BEFORE INSERT OR UPDATE ON student FOR EACH ROW 
BEGIN 
    IF INSERTING THEN :NEW.createdby:=USER; :NEW.createddate:=SYSDATE; END IF; 
    :NEW.modifiedby:=USER; :NEW.modifieddate:=SYSDATE; 
END; 
/ 
show user

-- trigger cho bảng ENROLLMENT
CREATE OR REPLACE TRIGGER trg_enrollment_audit 
BEFORE INSERT OR UPDATE ON enrollment FOR EACH ROW 
BEGIN 
    IF INSERTING THEN :NEW.createdby:=USER; :NEW.createddate:=SYSDATE; END IF; 
    :NEW.modifiedby:=USER; :NEW.modifieddate:=SYSDATE; 
END; 
/ 
show user

-- trigger cho bảng INSTRUCTOR
CREATE OR REPLACE TRIGGER trg_instructor_audit 
BEFORE INSERT OR UPDATE ON instructor FOR EACH ROW 
BEGIN 
    IF INSERTING THEN :NEW.createdby:=USER; :NEW.createddate:=SYSDATE; END IF; 
    :NEW.modifiedby:=USER; :NEW.modifieddate:=SYSDATE; 
END;
/
show user

-- trigger cho bảng GRADE
CREATE OR REPLACE TRIGGER trg_grade_audit 
BEFORE INSERT OR UPDATE ON grade FOR EACH ROW 
BEGIN 
    IF INSERTING THEN :NEW.createdby:=USER; :NEW.createddate:=SYSDATE; END IF; 
    :NEW.modifiedby:=USER; :NEW.modifieddate:=SYSDATE; 
END; 
/ 
show user

-- câu 5.2
CREATE OR REPLACE TRIGGER trg_max_enrollment 
BEFORE INSERT ON enrollment 
FOR EACH ROW 
DECLARE 
    v_so_lop NUMBER; 
BEGIN 
    -- Dem so lop sinh vien nay dang dang ky 
    SELECT COUNT(*) 
    INTO v_so_lop 
    FROM enrollment 
    WHERE studentid = :NEW.studentid; 
    
    -- Neu da co 3 lop tro len thi tu choi 
    IF v_so_lop >= 3 THEN 
        RAISE_APPLICATION_ERROR( 
            -20001, 
            'Sinh vien ' || :NEW.studentid || 
            ' da dang ky du 3 lop! Khong the dang ky them.' 
            ); 
    END IF; 
END trg_max_enrollment; 
/ 
-- Kiem tra trigger: 
-- Gia su sinh vien 12580199 da co 3 lop, thu them lop thu 4: 
INSERT INTO enrollment (studentid, classid, enrolldate, createdby, 
createddate, modifiedby, modifieddate) 
VALUES (12580199, 101, SYSDATE, USER, SYSDATE, USER, SYSDATE); 
 show user
 

SET TIMING ON;

SET SERVEROUTPUT ON;
BEGIN 
    print_student_name(12580199); 
END; 
/
show user
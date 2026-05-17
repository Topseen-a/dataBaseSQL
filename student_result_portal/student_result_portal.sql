CREATE DATABASE student_result_portal;

USE student_result_portal;

CREATE TABLE faculty (
    faculty_id INT AUTO_INCREMENT PRIMARY KEY,
    faculty_name VARCHAR(100) NOT NULL
);

CREATE TABLE department (
    department_id INT AUTO_INCREMENT PRIMARY KEY,
    department_name VARCHAR(100) NOT NULL,
    faculty_id INT,

    FOREIGN KEY (faculty_id)
    REFERENCES faculty(faculty_id)
);

CREATE TABLE semester (
    semester_id INT AUTO_INCREMENT PRIMARY KEY,
    semester_name VARCHAR(50) NOT NULL,
    academic_session VARCHAR(20) NOT NULL
);

CREATE TABLE lecturer (
    lecturer_id INT AUTO_INCREMENT PRIMARY KEY,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    department_id INT,

    FOREIGN KEY (department_id)
    REFERENCES department(department_id)
);

CREATE TABLE student (
    student_id INT AUTO_INCREMENT PRIMARY KEY,
    matric_no VARCHAR(50) UNIQUE NOT NULL,
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email VARCHAR(150) UNIQUE,
    gender ENUM('Male', 'Female'),
    date_of_birth DATE,
    department_id INT,
    level INT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,

    FOREIGN KEY (department_id)
    REFERENCES department(department_id)
);

CREATE TABLE course (
    course_id INT AUTO_INCREMENT PRIMARY KEY,
    course_code VARCHAR(20) UNIQUE NOT NULL,
    course_title VARCHAR(150) NOT NULL,
    unit INT NOT NULL,
    department_id INT,
    lecturer_id INT,
    semester_id INT,

    FOREIGN KEY (department_id)
    REFERENCES department(department_id),

    FOREIGN KEY (lecturer_id)
    REFERENCES lecturer(lecturer_id),

    FOREIGN KEY (semester_id)
    REFERENCES semester(semester_id)
);

CREATE TABLE course_registration (
    registration_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester_id INT,
    registration_date DATE,

    FOREIGN KEY (student_id)
    REFERENCES student(student_id),

    FOREIGN KEY (course_id)
    REFERENCES course(course_id),

    FOREIGN KEY (semester_id)
    REFERENCES semester(semester_id)
);

CREATE TABLE result (
    result_id INT AUTO_INCREMENT PRIMARY KEY,
    student_id INT,
    course_id INT,
    semester_id INT,
    score DECIMAL(5,2),
    grade CHAR(2),
    remark VARCHAR(50),

    FOREIGN KEY (student_id)
    REFERENCES student(student_id),

    FOREIGN KEY (course_id)
    REFERENCES course(course_id),

    FOREIGN KEY (semester_id)
    REFERENCES semester(semester_id)
);
CREATE TABLE Department (
dept_no VARCHAR,
dept_name VARCHAR,
PRIMARY KEY (dept_no)
);

SELECT * FROM Department
--DELETE FROM Department

CREATE TABLE Employee (
emp_no int NOT NULL,
dept_no VARCHAR NOT NULL,
PRIMARY KEY (emp_no, dept_no),  --composite key because there are repeated emp_no and dept_no
FOREIGN KEY (dept_no) REFERENCES Department(dept_no)
);

------------------------------------------------------------------------------------
--TESTING. IMPORTINT DATA FROM CSV NOT WORKING
INSERT INTO Employee(emp_no, dept_no)
VALUES
(12, 'd005'),
(11, 'd002'),
(1, 'd004'),
(19, 'd007');

DELETE FROM Employee
--WHERE not needed, delete all 4 items above

SELECT * FROM Employee

--TESTING HOW TO JOIN TABLES
SELECT Employee.dept_no, Employee.emp_no, Department.dept_name
FROM Department
INNER JOIN Employee on
Employee.dept_no = Department.dept_no;
------------------------------------------------------------------------------------

CREATE TABLE Manager (
dept_no VARCHAR NOT NULL,
man_emp_no int NOT NULL,
FOREIGN KEY (dept_no) REFERENCES Department(dept_no)   --The department
);

SELECT * FROM Manager


CREATE TABLE Title_names (
title_id VARCHAR NOT NULL PRIMARY KEY,
title VARCHAR NOT NULL
);

SELECT * FROM Title_names
	
	
CREATE TABLE Employee_info (
emp_no int NOT NULL PRIMARY KEY,
--FOREIGN KEY (emp_no) REFERENCES Employee(emp_no),
emp_title_id VARCHAR NOT NULL,
FOREIGN KEY (emp_title_id) REFERENCES Title_names(title_id),
birth_date DATE NOT NULL,
first_name VARCHAR NOT NULL,
last_name VARCHAR NOT NULL,
sex VARCHAR NOT NULL,
hire_date DATE NOT NULL
);

SELECT * FROM Emplyoee_info

CREATE TABLE Salaries (
emp_no INT NOT NULL,
FOREIGN KEY (emp_no) REFERENCES Employee_info(emp_no),
salary INT NOT NULL
);

SELECT * FROM Salaries


------------------------------------------------------------------------------------
--Analysis

--1
SELECT Employee_info.emp_no, Employee_info.last_name, Employee_info.first_name, Employee_info.sex, Salaries.salary
FROM Employee_info
JOIN Salaries on
Employee_info.emp_no = Salaries.emp_no;

--2
SELECT Employee_info.last_name, Employee_info.first_name, Employee_info.hire_date
FROM Employee_info
WHERE hire_date BETWEEN '1986/1/1' and '1986/12/31';

--3
SELECT Employee_info.last_name, Employee_info.first_name, Manager.man_emp_no, Manager.dept_no, Department.dept_name
FROM Manager
JOIN Employee_info on
Manager.man_emp_no = Employee_info.emp_no
JOIN Department on
Manager.dept_no = Department.dept_no;

--4
SELECT Employee_info.last_name, Employee_info.first_name, Employee_info.emp_no, Department.dept_name
FROM Employee
JOIN Employee_info on
Employee.emp_no = Employee_info.emp_no
JOIN Department on
Employee.dept_no = Department.dept_no;

--5
SELECT Employee_info.last_name, Employee_info.first_name, Employee_info.sex
FROM Employee_info
WHERE first_name = 'Hercules' and last_name like 'B%'  --last name starts with B. The "%" means it can be anything before/after it

--6
SELECT Employee_info.last_name, Employee_info.first_name, Employee_info.emp_no, Department.dept_name
FROM Employee
JOIN Employee_info on
Employee.emp_no = Employee_info.emp_no
JOIN Department on
Employee.dept_no = Department.dept_no
WHERE dept_name = 'Sales';

--7
SELECT Employee_info.last_name, Employee_info.first_name, Employee_info.emp_no, Department.dept_name
FROM Employee
JOIN Employee_info on
Employee.emp_no = Employee_info.emp_no
JOIN Department on
Employee.dept_no = Department.dept_no
WHERE dept_name = 'Sales' or dept_name = 'Development';

--8
SELECT Employee_info.last_name, COUNT(Employee_info.last_name) as "count"
FROM Employee_info
GROUP BY last_name
ORDER BY "count" DESC;

------------------------------------------------------------------------------------







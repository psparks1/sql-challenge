--Creating tables

CREATE TABLE Titles(
  title_id VARCHAR(30),
  title VARCHAR(30),
  PRIMARY KEY (title_ID)
);

CREATE TABLE Employees(
  emp_no VARCHAR(30),
  title_id VARCHAR(30),
	FOREIGN KEY (title_id) REFERENCES Titles(title_id),
	birth_date VARCHAR(30),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(30),
	hire_date VARCHAR(30),
  PRIMARY KEY (emp_no)
);

CREATE TABLE Salaries(
   emp_no VARCHAR(30),
  salary int,
  PRIMARY KEY (emp_no)
);

CREATE TABLE Departments(
  dept_no VARCHAR(30),
  Department_name VARCHAR(30),
  PRIMARY KEY (dept_no)
);

--This table did not have a unique primary key so I gave it a composite one
CREATE TABLE dept_emp(
  emp_no VARCHAR(30),
	FOREIGN KEY (emp_no) REFERENCES Employees(emp_no),
  dept_no VARCHAR(30),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
  PRIMARY KEY (emp_no,dept_no)
);
--This table also needed a composite key
CREATE TABLE Department_Manager(
  dept_no VARCHAR(30),
	emp_no VARCHAR(30),
	FOREIGN KEY (dept_no) REFERENCES Departments(dept_no),
  PRIMARY KEY (dept_no,emp_no)
);

-- Start of tables
--1 Displays info for q1(number, last name, first name, sex, salary)
SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex, salaries.salary
FROM employees
LEFT JOIN salaries
ON employees.emp_no = salaries.emp_no;

--2 last name first name and hire date for employees hired in 1986

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.hire_date
FROM employees
Where extract(year from  CAST(hire_date AS DATE))= 86

;

--3 mangers with department name and number and basic manager info(first and last name, number)

SELECT department_manager.emp_no, department_manager.dept_no, departments.department_name, employees.emp_no,employees.first_name,employees.last_name
FROM department_manager
LEFT JOIN departments
ON department_manager.dept_no = departments.dept_no
Inner JOIN employees
ON department_manager.emp_no = employees.emp_no;

--4 employees with department

SELECT employees.emp_no, employees.last_name, employees.first_name,departments.department_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
Left Join departments
ON dept_emp.dept_no=departments.dept_no
;
--5 hercules b info

SELECT employees.emp_no, employees.last_name, employees.first_name, employees.sex
FROM employees
Where employees.first_name='Hercules' and last_name like 'B%'
;
--6 employeees in sales department

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.department_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
Left Join departments
ON dept_emp.dept_no=departments.dept_no
WHERE departments.department_name = 'Sales'

;

--7 employees in sales and development

SELECT employees.emp_no, employees.last_name, employees.first_name, departments.department_name
FROM employees
LEFT JOIN dept_emp
ON employees.emp_no = dept_emp.emp_no
Left Join departments
ON dept_emp.dept_no=departments.dept_no
WHERE Department_name in  ('Sales', 'Development')
;

--8  frequency of employee last names
SELECT last_name, COUNT(*)
FROM employees
GROUP BY last_name
ORDER BY count DESC

;



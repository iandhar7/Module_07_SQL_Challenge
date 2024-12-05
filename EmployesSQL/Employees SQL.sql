
CREATE TABLE departments (
  dept_no VARCHAR(10) PRIMARY KEY NOT NULL,
  dept_name VARCHAR(40) NOT NULL);


CREATE TABLE titles (
  title_id VARCHAR(10) PRIMARY KEY NOT NULL,
  title VARCHAR(30));
  

CREATE TABLE employees (
  emp_no VARCHAR PRIMARY KEY NOT NULL,
  emp_title_id VARCHAR(30),
	birth_date VARCHAR(30),
	first_name VARCHAR(30),
	last_name VARCHAR(30),
	sex VARCHAR(5),
	hire_date VARCHAR);


CREATE TABLE dept_emp (
  emp_no VARCHAR (20),
  dept_no VARCHAR(10));


CREATE TABLE dept_manager (
	dept_no VARCHAR(10),
  	emp_no Varchar (20));


CREATE TABLE salaries (
  emp_no VARCHAR references employees(emp_no),
  salary VARCHAR);


  select * from Departments
  select * from Dept_emp
  select * from Dept_manager
  select * from employees
  select * from Salaries
  select * from titles


SELECT e.emp_no, e.last_name, e.first_name, e.sex, s.salary
FROM employees e 
JOIN salaries s
ON e.emp_no = s.emp_no
;

--List the first name, last name, and hire date for the employees who were hired in 1986.
--1st way--

SELECT e.first_name, e.last_name, e.hire_date
FROM employees e
WHERE 
		e.hire_date > '1985-12-31' AND 
		e.hire_date < '1987-01-01'
;

--List the first name, last name, and hire date for the employees who were hired in 1986.
--2nd way--

SELECT first_name, last_name, hire_date 
FROM employees e
WHERE e.hire_date BETWEEN '1986-01-01' AND '1986-12-31'
;

--List the manager of each department along with their department number, 
--department name, employee number, last name, and first name.

SELECT m.dept_no, m.emp_no, d.dept_name, e.last_name, e.first_name
FROM dept_manager m
JOIN employees e
ON m.emp_no = e.emp_no
JOIN departments d
ON d.dept_no = m.dept_no
;


--List the department number for each employee along with that employee’s employee number,
--last name, first name, and department name.

SELECT de.dept_no, de.emp_no, e.last_name, e.first_name, d.dept_name
FROM dept_emp de
JOIN employees e
ON de.emp_no = e.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
;


--List first name, last name, and sex of each employee whose first name is Hercules and 
--whose last name begins with the letter B.

SELECT e.first_name, e.last_name, e.sex
FROM employees e
WHERE 
		e.first_name = 'Hercules' AND 
		e.last_name LIKE 'B%'
;


--List each employee in the Sales department, including their employee number, last name, and first name.

SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales'
;

--List each employee in the Sales and Development departments, including their employee number,
--last name, first name, and department name.

SELECT d.dept_name, de.emp_no, e.last_name, e.first_name
FROM employees e
JOIN dept_emp de
ON e.emp_no = de.emp_no
JOIN departments d
ON d.dept_no = de.dept_no
WHERE d.dept_name = 'Sales' OR d.dept_name = 'Development'
;


--List the frequency counts, in descending order, of all the employee last names 
--(that is, how many employees share each last name)

SELECT e.last_name, COUNT (*)
FROM employees e
GROUP BY e.last_name
ORDER BY COUNT(*) DESC
;
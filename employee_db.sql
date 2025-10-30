CREATE DATABASE employee;
USE employee;

CREATE TABLE employee(
empno INT PRIMARY KEY,
ename VARCHAR(25),
mgr_no INT,
hiredate DATE,
sal DOUBLE,
deptno INT,
FOREIGN KEY (deptno) REFERENCES dept(deptno)
);

CREATE TABLE dept(
deptno INT PRIMARY KEY,
dname VARCHAR(15),
dloc VARCHAR(20)
);

CREATE TABLE project(
pno INT PRIMARY KEY,
ploc VARCHAR(20),
pname VARCHAR(20)
);

CREATE TABLE assigned_to(
empno INT,
pno INT,
PRIMARY KEY (empno, pno),
job_role VARCHAR(20),
FOREIGN KEY (empno) REFERENCES employee(empno),
FOREIGN KEY (pno) REFERENCES project(pno)
);

CREATE TABLE incentives(
empno INT,
date DATE,
PRIMARY KEY (empno, date),
amount DOUBLE,
FOREIGN KEY (empno) REFERENCES employee(empno)
);

INSERT INTO employee VALUES
(01, "AAA", 01, "2025-01-01", 1000, 01),
(02, "BBB", 02, "2025-01-02", 2000, 02),
(03, "CCC", 03, "2025-01-03", 3000, 03),
(04, "DDD", 04, "2025-01-04", 4000, 04),
(05, "EEE", 05, "2025-01-05", 5000, 05);

INSERT INTO dept VALUES
(01, "D1", "Bangalore"),
(02, "D2", "Bangalore"),
(03, "D3", "Mysore"),
(04, "D4", "Mysore"),
(05, "D5", "Hyderabad"),
(06, "D6", "Hyderabad");

INSERT INTO project VALUES
(01, "Bangalore", "sky"),
(02, "Hyderabad", "cruise"),
(03, "Mysore", "beta");

INSERT INTO incentives VALUES
(01, "2025-06-10", 500),
(02, "2025-06-10", 700),
(03, "2025-06-10", 1000);

INSERT INTO assigned_to VALUES
(01, 01, "MANAGER"),
(02, 01, "ANALYST"),
(03, 02, "MANAGER"),
(04, 02, "TESTER"),
(05, 03, "ANALYST");

SELECT empno as "EMPLOYEE NUMBER" FROM employee
WHERE empno IN (SELECT empno FROM project WHERE ploc IN ("Bangalore", "Hyderabad", "Mysore"));

SELECT empno as "EMPLOYEE ID" FROM employee
WHERE empno NOT IN (SELECT empno FROM incentives);

SELECT e.ename, e.empno, d.dname, a.job_role, d.dloc, p.ploc
FROM employee e, dept d, assigned_to a, project p
WHERE e.deptno = d.deptno && d.dloc = p.ploc && p.pno = a.pno && a.empno = e.empno;


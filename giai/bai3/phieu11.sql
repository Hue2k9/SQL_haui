
create table Department(
  DepartmentNo integer primary key,
  DepartmentName char(25),
  Location Char(25)
)
create table Employee(
  EmpNo integer primary key,
  Fname varchar(15),
  Lname varchar(15),
  Job varchar(25),
  HireDate datetime,
  Salary numeric,
  Commision numeric,
  DepartmentNo integer,
  constraint fk foreign key (DepartmentNo)
  references Department(DepartmentNo)
)
insert into Department values
(10,'Accounting','Melbourne'),
(20,'Research','Adealide'),
(30,'Sales','Sydney'),
(40,'Operations','Perth')
insert into Employee values
(1,'John','Smith','Clerk',17-12-1980,800,null,20),
(2,'Peter','Allen','Salesman',20-11-1981,1600,300,30),
(3,'Kate','Ward','Salesman',22-11-1981,1250,500,30),
(4,'Jack','Jones','Manager',02-07-1981,2975,null,20),
(5,'Joe','Martin','Salesman',28-09-1981,1250,1400,30)

--1
select * from department;

--2
select * from employee;

--3
select EmpNo,Fname, Lname
from employee
where Fname='Kate';

--4 
select Lname+''+Fname as 'Full name', salary*0.1+salary 'Salary after'
from employee

--5
select Fname,Lname, HireDate
from employee
where Year(HireDate)=1981
Order by Lname

--6
select avg(salary) 'Luong tb',max(salary) 'luong max',min(salary) 'luong min'
from employee
group by departmentNo

--7
select DepartmentNo, count(DepartmentNo) 'So nguoi'
from employee
group by departmentNo

--8
select Employee.DepartmentNo, DepartmentName, Lname+' '+Fname as'Full Name', job, salary
from employee
inner join Department on Employee.departmentNo=Department.departmentNo;

--9
select employee.departmentNo, departmentName,location,count(Employee.departmentno) as 'So nguoi'
from employee
inner join department on employee.departmentno=department.departmentno
group by employee.departmentNo, departmentName,location

--10
select Department.departmentNo, departmentName,location,count(Employee.departmentno) as 'So nguoi'
from employee
right join department on employee.departmentno=department.departmentno
group by Department.departmentNo,departmentName,location


create database bai2_phieubtvn22;
use bai2_phieubtvn22;
go
create table Department
(
  departmentNo integer primary key,
  departmentName char(25) not null,
  location char(25) not null
)
create table Employee
(
  EmpNo integer primary key,
  Fname varchar(15) not null,
  Lname varchar(15) not null,
  Job varchar(25) not null,
  hireDate datetime not null,
  salary numeric not null,
  commision numeric,
  DepartmentNo integer,
  constraint Fk_employee_dp foreign key (departmentNo)
  references Department(departmentNo)
)
insert into department values
(10,'Accounting','Melbourne'),
(20,'Research','Adealide'),
(30,'Sales','Sydney'),
(40,'Operations','Perth')

insert into employee values
(1,'John','Smith','Clerk','17-Dec-1980',800,null,20),
(2,'Peter','Allen','Salesman','20-Feb-1981',1600,300,30),
(3,'Kate','Ward','Salesman','22-Feb-1981',1250,500,30),
(4,'Jack','Jones','Manager','02-Apr-1981' ,2975,null,20),
(5,'Joe','Martin','Salesman','28-Sep-1981',1250,1400,30)

select * from department;
select * from employee;




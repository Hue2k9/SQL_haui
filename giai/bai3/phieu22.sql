
create table subjects(
   SubjectID nvarchar(10) primary key,
   SubjectName nvarchar(25) not null,
)

create table Students(
  Studentid Nvarchar(12) primary key,
  StudentName Nvarchar(25) not null,
  DateofBirth datetime not null,
  email nvarchar(40),
  phone nvarchar(12),
  class nvarchar(10)
)

create table mark(
   StudentID nvarchar(12) ,
   SubjectID nvarchar(10) ,
   theory tinyint,
    Practical Tinyint,
   Date datetime,
   constraint fk_subject foreign key (subjectid)
   references subjects(subjectid),
    constraint fk_Student foreign key (studentId)
   references Students(studentid)

)

insert into Students values
('AV0807005',N'Mai Trung Hiếu','11/10/1989','trunghieu@yahoo.com',0904115116,'AV1'),
('AV0807006',N'Nguyễn Quý Hùng','2/12/1988','quyhung@yahoo.com',0955667787,'AV2'),
('AV0807007',N'Đỗ Đắc Huỳnh','2/1/1990','dachuynh@yahoo.com',0988574747,'AV2'),
('AV0807009',N'An Đăng Khuê','6/3/1986','dangkhue@yahoo.com',0986757463,'AV1'),
('AV0807010',N'Nguyễn T. Tuyết Lan','12/7/1989','tuyetlan@yahoo.com',0983310342,'AV2'),
('AV0807011',N'Đinh Phụng Long','2/12/1990 ','phunglong@yahoo.com',null,'AV1'),
('AV0807012',N'Nguyễn Tuấn Nam','2/3/1990','tuannam@yahoo.com',null,'AV1')


insert into Subjects values
('s001','SQL'),
('s002','Java Simple'),
('s003','Active Server Page')

insert into mark values
('AV0807005','s001',8,25,'6/5/2008'),
('AV0807006','s002',16,30,'6/5/2008'),
('AV0807007','s001',10,25,'6/5/2008'),
('AV0807009','s003',7,13,'6/5/2008'),
('AV0807010','s003',9,16,'6/5/2008'),
('AV0807011','s002',8,30,'6/5/2008'),
('AV0807012','s001',7,31,'6/5/2008'),
('AV0807005','s002',12,11,'6/6/2008'),
('AV0807009','s003',11,20,'6/6/2008'),
('AV0807010','s001',7,6,'6/6/2008')
select * from students
select * from mark

--1 
select * from subjects
--2
select * from Students where class='av1'
--3
update students set class='AV2' where studentid='AV0807012'
--4
select class,count(studentid) 
from students
group by class
--5
select * from students
where class='av2'
order by StudentName
--6
select * from students
inner join mark on students.studentid=mark.studentid
where mark.subjectid='s001' and theory<10 and date='2008-06-05 00:00:00.000'
--7
select count(studentid) as 'Tong so sv khong dat'
from mark
where subjectid='s001' and theory<10
group by subjectid
--8
select * from students
where class='av1' and dateOfBirth>'1/1/1980'
--9
alter table mark drop constraint fk_Student
delete from Students where studentid='AV0807011'
--10
select mark.studentid,studentname,subjectname,theory,Practical,mark.date
from students
inner join mark on students.studentid=mark.studentid
inner join subjects on subjects.subjectid=mark.subjectid
where mark.subjectid='s001' and date='2008-06-05 00:00:00.000'











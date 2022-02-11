create database bai2_phieubtvn1;
use bai2_phieubtvn1;
go
create table students
(
  studentID nvarchar(12) primary key,
  studentName nvarchar(25) not null,
  dateOfBirth datetime not null,
  email nvarchar(40),
  phone nvarchar(12),
  class nvarchar(10)
)
create table subjects (
   SubjectID nvarchar(10) primary key,
   SubjectName nvarchar(25) not null
)

create table mark(
   studentID nvarchar(12),
   subjectID nvarchar(10),
   date datetime,
   theory tinyint,
   practical tinyint,
   constraint PK_mark primary key (studentID,subjectID),
   constraint Fk_mark_st foreign key (studentId)
   references students(studentID),
   constraint FK_mark_sj foreign key (subjectID)
   references subjects(subjectID)
)

insert into Students values
('AV0807005',N'Mail Trung Hiếu','11/10/1989','trunghieu@yahoo.com','0904115116','AV1'),
('AV0807006',N'Nguyễn Quý Hùng','2/12/1988','quyhung@yahoo.com','0955667787','AV2'),
('AV0807007',N'Đỗ Đắc Huỳnh','2/1/1990','dachuynh@yahoo.com','0988574747','AV2'),
('AV0807009',N'An Đăng Khuê','6/3/1986','dangkhue@yahoo.com','0986757463','AV1'),
('AV0807010',N'Nguyễn T. Tuyết Lan','12/7/1989','tuyetlan@gmail.com','0983310342','AV2'),
('AV0807011',N'Đinh Phụng Long','2/12/1990','phunglong@yahoo.com','','AV1'),
('AV0807012',N'Nguyễn Tuấn Nam','2/3/1990','tuannam@yahoo.com','','AV1')

insert into subjects values
('s001','sql'),
('s002','Java simplefield'),
('s003','Active Server Page')

insert into mark values
('AV0807005','s001',8,25,6/5/2008),
('AV0807006','s002',16,30,6/5/2008),
('AV0807007','s001',10,25,6/5/2008),
('AV0807009','s003',7,13,6/5/2008),
('AV0807010','s003',9,16,6/5/2008),
('AV0807011','s002',8,30,6/5/2008),
('AV0807012','s001',7,31,6/5/2008),
('AV0807005','s002',12,11,6/6/2008),
('AV0807010','s001',7,6,6/6/2008)

select * from students;
select * from subjects;
select * from mark;















create database QLSV
go 
use QLSV
go
create table lop
(
   malop char(5) primary key,
   tenlop nvarchar(20),
   phong int
)

create table SV
(
   masv char(5) primary key,
   tensv nvarchar(50),
   malop char(5),
   constraint FK_SV_malop foreign key (malop)
   references Lop(malop)
)
insert lop values
('1','CD',1),
('2','DH',2),
('3','LT',2),
('4','CH',4)
insert sv values
('1','A','1'),
('2','B','2'),
('3','C','1'),
('4','D','3')

--1. Viết hàm thống kê xem mỗi lớp có bn sv với malop là tham số truyền vào từ bàn phím
create function ThongKe(@malop nvarchar(5))
returns int
as
begin
   declare @sl int
   select @sl=count(sv.masv)
   from sv inner join lop on sv.malop=lop.malop
   where  lop.malop=@malop
   group by lop.tenlop
   return @sl
end

select dbo.ThongKe('1')

--2 
create function fc_cau2(@tenlop nvarchar(5))
returns @thongke table(
    masv char(5),
	tensv nvarchar(50)
)
as
begin
   insert @thongke(masv,tensv)
   select masv,tensv
   from sv inner join lop on sv.malop=lop.malop
   where lop.tenlop=@tenlop
   return
end
select * from dbo.fc_cau2('CD')

--3
/*
Đưa ra hàm thống kê sinhvien: malop,tenlop,soluong sinh viên trong lớp, với 
tên lớp được nhập từ bàn phím. Nếu lớp đó chưa tồn tại thì thống kê tất cả 
các lớp, ngược lại nếu lớp đó đã tồn tại thì chỉ thống kê mỗi lớp đó.
*/
create function fc_cau3(@tenlop nvarchar(10))
returns @thongke table(
   malop nvarchar(5),
   tenlop nvarchar(10),
   soluong int
)
as
begin
   if (not exists(select malop from lop where tenlop=@tenlop))
      insert @thongke
	  select lop.malop,lop.tenlop,count(sv.masv)
	  from lop inner join sv on lop.malop=sv.malop
	  group by lop.malop,lop.tenlop
   else
      insert @thongke
	  select lop.malop, lop.tenlop,count(sv.masv)
	  from lop inner join sv on lop.malop=sv.malop
	  where lop.tenlop=@tenlop
	  group by lop.malop, lop.tenlop
	  return
end
select * from dbo.fc_cau3('tin1')

--4





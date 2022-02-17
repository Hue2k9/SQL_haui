
create table Khoa
( 
   makhoa int primary key,
   tenkhoa nvarchar(20),
   dienthoai char(10)
)

create table Lop
(
   malop int primary key,
   tenlop nvarchar(20),
   khoa nvarchar(20),
   Hedt nvarchar(20),
   NamNhapHoc int,
   Makhoa char(10)
)
--Cau1
create proc sp_nhapkhoa(@makhoa int, @tenkhoa nvarchar(20), @dienthoai char(10))
as
begin
    if (exists (select * from khoa where tenkhoa=@tenkhoa))
	   print'ten khoa '+@tenkhoa+' da ton tai'
	else
	   insert khoa values(@makhoa,@tenkhoa,@dienthoai)
end
--Goi thu tuc
select * from khoa
exec sp_nhapkhoa 6,N'Điện tử','1224556'
--cach 2
create proc sp_nhapkhoa2(@makhoa int, @tenkhoa nvarchar(20), @dienthoai nvarchar(12))
as
begin
    declare @dem int
	select @dem=count(*) from khoa where tenkhoa=@tenkhoa
	if (@dem=0)
	   insert khoa values(@makhoa,@tenkhoa,@dienthoai)
	else
	   print 'Khoa da ton tai'
end


--Cau2
create proc sp_nhaplop(@malop int, @tenlop nvarchar(20), @khoa int, 
@hedt nvarchar(20), @namnhaphoc int, @makhoa int)
as
  begin
    if (exists(select * from lop where tenlop=@tenlop))
	   print'Lop da ton tai'
	else
	   if (not exists(select * from khoa where makhoa=@makhoa))
	      print 'Khoa nay chua ton tai'
       else
	      insert lop values(@malop,@tenlop,@khoa,@hedt,@namnhaphoc,@makhoa)
end
select * from lop
select * from khoa
exec sp_nhaplop 7,'tin22',2,'dh',2011,3





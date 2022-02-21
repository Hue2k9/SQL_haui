
create table tblChucvu(
  macv nvarchar(2) primary key,
  tencv nvarchar(30)
)

create table tblNhanVien(
  manv nvarchar(4) primary key,
  macv nvarchar(2),
  tennv nvarchar(30),
  ngaysinh datetime,
  luongcanban float,
  ngaycong int,
  phucap float,
  constraint FK_macv foreign key (macv)
  references tblChucvu(macv)
)

insert tblChucvu values
('bv',N'bảo vệ'),
('gd',N'giám đốc'),
('hc',N'Hành chính'),
('kt',N'kế toán'),
('tq',N'thủ quỹ'),
('vs',N'vệ sinh')

insert tblNhanVien values
('nv01','gd',N'Nguyễn Văn An','1977-12-12',700000,25,500000),
('nv02','bv',N'Bùi Văn Tí','1978-10-10',400000,24,100000),
('nv03','kt',N'Trần Thanh Nhật','1977-09-09',600000,26,400000),
('nv04','vs',N'Nguyễn Thị Út','1980-10-10',300000,26,300000),
('nv05','hc',N'Lê Thị Hà','1979-10-10',500000,27,200000)


--1
create proc SP_Them_Nhan_Vien(@manv nvarchar(4), @macv nvarchar(2),
@tennv nvarchar(30), @ngaysinh datetime, @luongcanban float, @ngaycong int,
@phucap float)
as
begin
    if (not exists (select macv from tblChucvu where macv=@macv))
	   print 'Ma cv chua ton tai ton tai'
	else
	   insert tblNhanVien values(@manv,@macv,@tennv,@ngaysinh,@luongcanban,@ngaycong,@phucap)
end

-- goi thu tuc
exec SP_Them_Nhan_Vien 'nv07','ii',N'Hoang Minh Hue','2002-07-09',10000,3,500000
exec SP_Them_Nhan_Vien 'nv07','bv',N'Hoang Minh Hue','2002-07-09',10000,3,500000

--2
create proc SP_CapNhat_Nhan_Vien(@manv nvarchar(4), @macv nvarchar(2),
@tennv nvarchar(30), @ngaysinh datetime, @luongcanban float, @ngaycong int,
@phucap float)
as
begin
   if (not exists (select macv from tblChucvu where macv=@macv) )
       print 'Ma cv chua ton tai'
   else
    
       update tblNhanVien set tennv=@tennv, ngaysinh=@ngaysinh, luongcanban=@luongcanban, ngaycong=@ngaycong, phucap=@phucap
	   where manv=@manv
end
exec SP_CapNhat_Nhan_Vien 'nv07','ii',N'Hoang Minh Hue','2002-07-09',10000,3,500000
exec SP_CapNhat_Nhan_Vien 'nv07','bv',N'Hoang Minh Hue','2002-07-09',70000,10,900000

--3
create proc SP_LuongLN 
as
begin
	  (select luongcanban*ngaycong+phucap
	  from tblNhanVien)
	  return
end

exec SP_LuongLN 'luong'



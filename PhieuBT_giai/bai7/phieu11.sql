create table HangSX(
  MaHangSX Nchar(10) primary key,
  TenHang Nvarchar(20),
  DiaChi Nvarchar(30),
  SoDT Nvarchar(20),
  Email Nvarchar(30)
)
Create table MaSP(
   MaSP Nchar(10) primary key,
   MaHangSX Nchar(10),
   TenSP Nvarchar(20),
   SoLuong int,
   MauSac Nvarchar(20),
   GiaBan money,
   DonViTinh Nchar(10),
   MoTa Nvarchar(Max)
   constraint Fk_MaSP_MaHangSX foreign key (MaHangSX)
   references HangSX(MaHangSX)
)
create table SanPham(
   MaSP Nchar(10) primary key,
   MaHangSX Nchar(10),
   TenSP Nvarchar(20),
   SoLuong int,
   MauSac Nvarchar(20),
   GiaBan money,
   DonViTinh Nchar(10),
   Mota Nvarchar(max)
   constraint FK_SanPham_MaHangSX foreign key (MaHangSX)
   references HangSX(MaHangSX)
)

create table NhanVien(
   MaNV Nchar(10) primary key,
   TenNV nvarchar(20),
   GioiTinh Nchar(10),
   DiaChi Nvarchar(30),
   SoDT Nvarchar(20),
   Email Nvarchar(30),
   TenPhong Nvarchar(30)
)
create table PNhap(
   SoHDN nchar(10) primary key,
   NgayNhap date,
   MaNV nchar(10)
   constraint PNhap_MaNV foreign key (manv)
   references NhanVien(MaNV)
)
create table Nhap(
   SoHDN nchar(10) primary key,
   MaSP nchar(10),
   SoLuongN int, 
   DonGiaN money,
   constraint Nhap_sohdn foreign key (sohdn)
   references PNhap(SoHDN),
   constraint Nhap_masp foreign key (MaSP)
   references SanPham(MaSP)
)
create table PXuat(
   SoHDX nchar(10) primary key,
   NgayXuat date,
   MaNV nchar(10)
   constraint PXuat_manv foreign key (manv)
   references NhanVien(manv)
)
create table Xuat(
   SoHDX nchar(10) primary key,
   MaSP nchar(10),
   SoLuongX int,
   constraint Fk_xuat_sohdx foreign key (sohdx)
   references PXuat(SoHDX),
   constraint FK_xuat_masp foreign key (masp)
   references SanPham(masp)
)

insert into HangSX values
('h1','apple','Ha Noi','012345','abc@gmail.com'),
('h2','apple','Ha Noi','012345','abc@gmail.com'),
('h3','apple','Ha Noi','012345','abc@gmail.com'),
('h4','apple','Ha Noi','012345','abc@gmail.com'),
('h5','apple','Ha Noi','012345','abc@gmail.com')
insert into SanPham values
('sp1','h1',N'áo sơ mi',10,N'trắng',5000,'USD','made in China'),
('sp2','h1',N'áo sơ mi',11,N'trắng',5000,'USD','made in China'),
('sp3','h2',N'áo sơ mi',12,N'trắng',5000,'USD','made in China'),
('sp4','h3',N'áo sơ mi',13,N'trắng',5000,'USD','made in China'),
('sp5','h4',N'áo sơ mi',10,N'trắng',5000,'USD','made in China')

insert into NhanVien values
('nv1',N'Huệ Hoàng',N'Nữ','Sóc Sơn','0868299812','htt2hauik15@gmail.com',N'chủ tịch'),
('nv2',N'Ánh Ngọc',N'Nữ','Tuyên Quang','0868299812','htt2hauik15@gmail.com','phong 1'),
('nv3',N'Trần Hoàng',N'Nam','Thái Nguyên','0868299812','htt2hauik15@gmail.com','phong 2'),
('nv4',N'Văn A',N'Nam','Hà Nội','0868299812','htt2hauik15@gmail.com','phong 3')


insert into PNhap values
('hd1','01/01/2022','nv1'),
('hd2','01/01/2022','nv4')

insert into Nhap values
('hd1','sp1',100,900),
('hd2','sp2',200,650)

insert into PXuat values
('hd1','09/01/2022','nv1'),
('hd2','01/01/2021','nv2')
insert into Xuat values
('hd1','sp3',1),
('hd2','sp4',1)

/*
update Xuat set soluongx=99 where sohdx='hd2';
delete from NhanVien where manv='nv3';
*/

create function cauA(@tenHang nvarchar(20), @x date)
returns int
as
begin
   declare @tongXuat int
   set @tongXuat =(select sum(soLuongX)
     from Xuat inner join PXuat 
	 on xuat.SoHDX=pxuat.SoHDX
	 inner join SanPham on sanpham.masp=xuat.masp
	 inner join HangSX on HangSX.MaHangSX=sanpham.MaHangSX
	 where tenhang=@tenhang and NgayXuat=@x
   )
    return @tongXuat
end

create function cauB(@tenPhong nvarchar(30))
returns int
begin
   declare @soLuong int
   set @soLuong =(select count(manv)
     from NhanVien 
	 where tenPhong=@tenPhong 
	 group by tenphong
   )
   return @soLuong
end
select dbo.cauB('kế toán')

create function cauC(@x nvarchar(30), @y date)
returns int
begin
   declare @soLuongXuat int
   set @soLuongXuat=(
      select soluongX from Xuat
	  inner join PXuat on Xuat.SoHDX=pxuat.SoHDX
	  where SoLuongX=@x and NgayXuat=@y
   )
   return @soLuongXuat
end

create function cauD(@x char(10))
returns nvarchar(20)
begin
     declare @soDienThoai nvarchar(20)
	 set @soDienThoai=(
	     select SoDT from NhanVien
		 inner join PXuat on pxuat.MaNV=NhanVien.MaNV
		 where SoHDX=@x
	 )
	 return @soDienThoai
end

create function cauE(@x nvarchar(30), @y int)
returns int
as
begin
declare @tongNhap int
	declare @tongXuat int
	declare @thayDoi int
	select @tongNhap= sum(soLuongN) from nhap
	     inner join SanPham on nhap.MaSP=SanPham.MaSP
		 inner join PNhap on nhap.SoHDN=PNhap.SoHDN
		 where tensp=@x and year(ngaynhap)=@y
	select @tongXuat= sum(soluongX) from Xuat
	     inner join SanPham on xuat.MaSP=SanPham.MaSP
		 inner join PXuat on pxuat.SoHDX=xuat.SoHDX
		 where TenSP=@x and year(ngayxuat)=@y
	set @thayDoi=@tongNhap-@tongXuat
	return @thayDoi
end

create function cauF(@x nvarchar(20))
returns int
as
begin
      declare @soLuong int
	  set @soLuong =(
	     select sum(soLuong)
		 from SanPham inner join HangSX
		 on sanpham.MaHangSX=hangsx.MaHangSX
		 where TenHang=@x
		 group by HangSX.MaHangSX
	  )
	  return @soLuong
end
































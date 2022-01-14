create database bai2_phieu22;
use bai2_phieu22;
go 
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
('H01','Samsung','Korea','011-08271717','ss@gmail.com.kr'),
('H02','OPPO','China','081-08626262','oppo@gmail.com'),
('H03','Vinfone',N'Việt Nam','084-0982626','vf@gmail.com.vn')

insert into NhanVien values
('nv01',N'Nguyễn Thị Thu',N'nữ',N'Hà Nội','098262521', 'thu@gmail.com',N'kế toán'),
('nv02',N'Lê Văn Nam','nam',N'Bắc Ninh','09725252','nam@gmail.com',N'vật tư'),
('nv03',N'Trần Hòa Bình', N'nữ', N'Hà Nội','0328388388','hb@gmail.com',N'kế toán')

insert into SanPham values
('sp01','h02','F1 plus',100, N'xám',7000000,N'chiếc', N'Hàng cận cao cấp'),
('sp02','h01','Galaxy Note11',50, N'đỏ', 19000000,N'chiếc',N'Hàng cao cấp'),
('sp03','h02','F3 lite',200,N'nâu',3000000,N'chiếc',N'hàng phổ thông'),
('sp04','h03','Vjoy3',200,N'xám',1500000,N'chiếc',N'hàng phổ thông'),
('sp05','h01','Galaxy V21',500,N'nâu',8000000,N'chiếc',N'hàng cao cấp')

insert into PNhap values
('n01','02-05-2019','nv01'),
('n02','04-07-2020','nv02'),
('n03','05-17-2020','nv02'),
('n04','03-22-2020','nv03'),
('n05','07-07-2020','nv01')

insert into Nhap values
('n01','sp02',10,'17000000'),
('n02','sp01',30,'6000000'),
('n03','sp04',20,'1200000'),
('n04','sp01',10,'6200000'),
('n05','sp05',20,'7000000')


insert into PXuat values
('x01','06-14-2020','nv02'),
('x02','03-05-2019','nv03'),
('x03','12-12-2020','nv01'),
('x04','06-02-2020','nv02'),
('x05','05-18-2020','nv01')

insert into Xuat values
('x01','sp03',5),
('x02','sp01',3),
('x03','sp02',1),
('x04','sp03',2),
('x05','sp05',1)

select * from HangSX;
select * from SanPham;
select * from NhanVien;
select * from Nhap;
select * from PNhap;
select * from Xuat;
select * from PXuat;











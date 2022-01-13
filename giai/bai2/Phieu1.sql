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
select * from SanPham;
select * from HangSX;
select * from NhanVien;
select * from Nhap;
select * from PNhap;
select * from Xuat;
select * from PXuat;
















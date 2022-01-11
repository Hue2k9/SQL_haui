
use master 
go
create database QLBH
on primary(
  name='QLBH_dat',
  filename='D:\QLBH.mdf',
  size=10MB,
  maxsize=100MB,
  filegrowth=10MB
)
log on(
  name='QLBH_log',
  filename='D:\QLBH.ldf',
  size=1MB,
  maxsize=5MB,
  filegrowth=20%
)
go
use QLBH;
go 
create table CongTy(
   MaCT nchar(10) not null primary key, 
   TenCT nvarchar(20) not null,
   TrangThai nchar(10),
   ThanhPho nvarchar(20)
)
create table SanPham(
  MaSP nchar(10) not null primary key,
  TenSP nvarchar(20),
  MauSac nchar(10) default N'do',
  Gia money,
  SoLuongCo int,
  constraint unique_SP unique(TenSP)
)
create table CungUng(
  MaCT nchar(10) not null,
  MaSP nchar(10) not null,
  SoLuongBan int,
  constraint PK_CungUng Primary key (MaCT,MaSP),
  constraint chk_SLB check(SoLuongBan>0),
  constraint FK_CU_SP foreign key (MaSP)
     references SanPham(MaSP),
  constraint FK_CU_CT foreign key(MaCT)
     references CongTy(MaCT)
)
insert into CongTy values
('ct01','HoangMinhHue company','hd','HaNoi'),
('ct02','HoangMinhHue company','hd','HaNam'),
('ct03','HoangMinhHue company','hd','TpHoChiMinh')

insert into SanPham values
('sp01','kem','Trang',3000,100),
('sp02','ao','xanh',100000,7),
('sp03','sach','do',5000,20)

insert into CungUng values
('ct01','sp01',1),
('ct02','sp01',2),
('ct03','sp01',3),
('ct01','sp02',4),
('ct02','sp03',5),
('ct03','sp02',6)

select * from CongTy;
select * from SanPham;
select * from CungUng;






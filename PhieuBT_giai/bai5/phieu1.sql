create database TruongHoc
go
use TruongHoc
go
-- bang hoc sinh
create table HocSinh
(
  maHS char(5),
  ten nvarchar(30),
  nam bit,   --gioi tinh nam:1- dung, 0-sai
  NgaySinh datetime,
  DiaChi varchar(20),
  diemTB float,
)
-- bang giao vien
create table GiaoVien
(
  maGV char(5),
  ten nvarchar(30),
  nam bit,-- gioi tinh
  NgaySinh datetime,
  DiaChi varchar(20),
  Luong money
)
-- bang lop hoc
create table LopHoc
(
  MaLop char(5),
  TenLop nvarchar(30),
  soLuong int
)











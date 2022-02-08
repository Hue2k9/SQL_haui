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

-- INSERT
--Từ khóa into có hoặc không
insert dbo.HocSinh values
('CS002',N'Kim Long',1,'19940226','Dong Nai',9.0)
insert HocSinh values
('CS003',N'Kim Long',1,'19940226','Dong Nai',9.0)
insert GiaoVien values
('gv01','Hue Hoang',0,'20020709','Ha Noi',5000),
('gv02','Ngoc Anh',0,'20020709','Tuyen Quang',2500),
('gv03','Tran Hoang',1,'20020709','Thai Nguyen',3000)

-- DELETE
-- xóa tất cả dữ liệu trong table HocSinh
delete HocSinh
-- Xóa giáo viên có lương hơn 5000
delete GiaoVien where luong>5000
-- Xóa học sinh có điểm tb là: 1;8;9
delete HocSinh where diemTB in(1,8,9)
-- Xóa hs có mã thuộc ds fd001,fd002,fd003
delete HocSinh where maHS in ('fd001','fd002','fd003')
-- Xóa hs có điểm trong khoảng 1-8
delete HocSinh where diemTB between 1 and 8
-- Xóa hs khong co dia chi o Da Lat
delete HocSinh where DiaChi not like 'DA Lat'

-- UPDATE
-- cập nhật lương của tất cả giáo viên thành 10000
update GiaoVien set Luong=10000
-- Cập nhật lương của tất cả giáo viên thành 10000 và địa chỉ ở Đà Lạt
update GiaoVien set DiaChi='DaLat', Luong=10000
-- Cập nhật lương của giáo viên nam thành 1
update GiaoVien set Luong=1 where nam=1

select * from HocSinh
select * from GiaoVien







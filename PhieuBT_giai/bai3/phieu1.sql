
create table Khoa(
   makhoa char(10) primary key,
   tenkhoa char(30),
   dienthoai char(10),
)

create table GiangVien(
  magv int primary key,
  hotengv char(30),
  luong decimal(5,2),
  makhoa char(10),
  constraint FK_khoa foreign key (makhoa)
  references Khoa(makhoa)
)
create table SinhVien(
  masv int primary key,
  hotensv char(30),
  makhoa char(10),
  namsinh int,
  quequan char(30),
  constraint FK_SinhVien_khoa foreign key (makhoa)
  references Khoa(makhoa)
)
create table DeTai(
  madt char(10) primary key,
  tendt char(30),
  kinhphi int,
  NoiThucTap char(30),
)
create table HuongDan(
  masv int primary key,
  madt char(10),
  magv int,
  ketqua decimal(5,2),
  constraint FK_HuongDan_masv foreign key (masv)
  references SinhVien(masv),
  constraint FK_HuongDan_madt foreign key (madt)
  references DeTai(madt)
)

insert into Khoa values
('k01','Cong nghe thong tin','0123456'),
('k02','Co khi','0123457'),
('k03','O to','0123458'),
('k04','Dieu khien tu dong hoa','0123459')
insert into Khoa values
('k05','Dia ly','12356'),
('k06','QLTN','123567'),
('k07','Cong nghe sinh hoc','123567'),
insert into Khoa values
('k08','Toan','1353')
insert into GiangVien values
(1,'Thu Hien',150,'k01'),
(2,'Tran Van Hoang',145,'k02'),
(3,'Truong Ngoc Anh',100,'k03'),
(4,'Tran Nga',165,'k04'),
(5,'Hoang Minh Hue',225,'k01'),
insert into GiangVien values
(6,'Nguyen Van A',116,'k05'),
(7,'Nguyen Van B',167,'k06'),
(8,'Nguyen Van A',116,'k07'),
(9,'Nguyen Van B',167,'k06')
insert into SinhVien values
(101,'Hoang Minh Hue','k01',2002,'Ha Noi'),
(102,'Truong Ngoc Anh','k01',2002,'Tuyen Quang'),
(103,'Tran Van Hoang','k01',2002,'Thai Nguyen'),
(104,'Nguyen Chi Hai','k03',2001,'Ha Noi'),
(105,'Nguyen Thien Khai','k02',2002,'Ha Nam'),
(106,'Hoang Minh Hue','k04',2002,'Ha Noi')
insert into SinhVien values
(107,'Nguyen Van B','k07',2002,'Ha Noi'),
(108,'Nguyen Van C','k07',2003,'Ha Noi')
insert into SinhVien values
(109,'Nguyen Van B','k08',2002,'Ha Noi'),
(110,'Nguyen Van C','k08',2003,'Ha Noi')

insert into DeTai values
('dt01','Quan ly du an cntt',1500,'Ha Noi'),
('dt02','Quan ly du an o to',1400,'Nam Dinh'),
('dt03','Quan ly du an co khi',1200,'Ha Giang'),
('dt04','Quan ly du an robot',1300,'Ha Noi')
insert into HuongDan values
(101,'dt01',1,99),
(102,'dt02',2,85),
(103,'dt01',3,72),
(104,'dt03',1,80),
(105,'dt04',2,75),
(106,'dt01',3,95)

/*1.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của tất cả các giảng viên*/
select magv,hotengv,tenkhoa
from GiangVien, Khoa
where Khoa.maKhoa=GiangVien.makhoa;

/*2.Đưa ra thông tin gồm mã số, họ tênvà tên khoa của các giảng viên của khoa 
‘DIA LY va QLTN’*/
select magv,hotengv,tenkhoa
from GiangVien
inner join khoa
on GiangVien.makhoa=khoa.makhoa
where tenkhoa='Dia ly' or tenkhoa='QLTN';

/*3 . Cho biết số sinh viên của khoa ‘CONG NGHE SINH HOC’*/
select count(masv) 'So luong'
from SinhVien
inner join Khoa On SinhVien.makhoa=Khoa.makhoa
where Khoa.tenkhoa='Cong nghe sinh hoc'

/*4.Đưa ra danh sách gồm mã số, họ tênvà tuổi của các sinh viên khoa ‘TOAN’ */
select masv,hotensv,Year(getdate())-namsinh 'Tuoi'
from SinhVien,Khoa
where khoa.makhoa=sinhvien.makhoa and tenkhoa='Toan';



/*5. Cho biết số giảng viên của khoa ‘CONG NGHE SINH HOC’*/
select count(magv) 'So giang vien'
from GiangVien,Khoa
where GiangVien.makhoa=Khoa.makhoa and tenkhoa='Cong nghe sinh hoc';

/* 6.Cho biết thông tin về sinh viên không tham gia thực tập*/
select * from SinhVien
where SinhVien.masv not in (select masv from HuongDan);

/* 7. Đưa ra mã khoa, tên khoa và số giảng viên của mỗi khoa */
select khoa.makhoa,tenkhoa,count(magv) as 'so giang vien'
from khoa
inner join GiangVien on khoa.makhoa=giangvien.makhoa
group by khoa.makhoa, tenkhoa;


/* 8. Cho biết số điện thoại của khoa mà sinh viên có tên ‘Le van son’ đang theo học */
select dienthoai
from khoa, sinhvien
where khoa.makhoa=sinhvien.makhoa and hotensv='Le Van Son'












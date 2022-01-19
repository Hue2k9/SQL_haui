
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
  references DeTai(madt),
  constraint FK_HuongDan_magv foreign key (magv)
  references GiangVien(magv)
)

insert into Khoa values
('k01','Cong nghe thong tin','0123456'),
('k02','Co khi','0123457'),
('k03','O to','0123458'),
('k04','Dieu khien tu dong hoa','0123459'),
('k05','Dia ly','12356'),
('k06','QLTN','123567'),
('k07','Cong nghe sinh hoc','123567'),
('k08','Toan','1353')
insert into GiangVien values
(1,'Thu Hien',150,'k01'),
(2,'Tran Van Hoang',145,'k02'),
(3,'Truong Ngoc Anh',100,'k03'),
(4,'Tran Nga',165,'k04'),
(5,'Hoang Minh Hue',225,'k01'),
(6,'Nguyen Van A',116,'k05'),
(7,'Nguyen Van B',167,'k06'),
(8,'Nguyen Van A',116,'k07'),
(9,'Nguyen Van B',167,'k06'),
(10,'Tran Son',150,'k08')
insert into SinhVien values
(101,'Hoang Minh Hue','k01',2002,'Ha Noi'),
(102,'Truong Ngoc Anh','k01',2002,'Tuyen Quang'),
(103,'Tran Van Hoang','k01',2002,'Thai Nguyen'),
(104,'Nguyen Chi Hai','k03',2001,'Ha Noi'),
(105,'Nguyen Thien Khai','k02',2002,'Ha Nam'),
(106,'Hoang Minh Hue','k04',2002,'Ha Noi'),
(107,'Nguyen Van B','k07',2002,'Ha Noi'),
(108,'Nguyen Van C','k07',2003,'Ha Noi'),
(109,'Nguyen Van B','k08',2002,'Ha Noi'),
(110,'Nguyen Van C','k08',2003,'Ha Noi'),
(111,'Nguyen Van D','k08',2003,'Ha Noi'),
(112,'Nguyen Van D','k05',2003,'Ha Noi'),
(113,'Nguyen Van D','k06',2003,'Ha Noi')

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
(106,'dt01',3,95),
(112,'dt04',2,75),
(113,'dt01',3,95),
(106,'dt01',10,5),
(107,'dt01',3,0),
(108,'dt01',3,null)

--1 
select HuongDan.madt, tendt from HuongDan
inner join GiangVien on HuongDan.magv=GiangVien.magv
inner join DeTai on HuongDan.madt=DeTai.madt
where GiangVien.hotengv='Tran Son';

--2 
select detai.tendt from detai
inner join HuongDan on detai.madt=huongdan.madt
inner join SinhVien on SinhVien.masv=HuongDan.masv
where SinhVien.masv not in (select masv from HuongDan)

--3 
select Giangvien.magv,hotengv,Khoa.tenkhoa
from GiangVien
inner join Khoa on GiangVien.makhoa=Khoa.makhoa
inner join HuongDan on HuongDan.magv=GiangVien.magv
group by Giangvien.magv,hotengv,Khoa.tenkhoa 
Having Count(HuongDan.magv)>=3

--4 
select madt,tendt from DeTai
where kinhphi=(select max(kinhphi) from detai )

--5
select Detai.madt,tendt from HuongDan
inner join DeTai on HuongDan.madt=DeTai.madt
group by Detai.madt, tendt
having count(HuongDan.madt)>2

--6
select SinhVien.masv,SinhVien.hotensv,ketqua N'Điểm'
from SinhVien inner join HuongDan on Sinhvien.masv=HuongDan.masv
inner join khoa on khoa.makhoa=sinhvien.makhoa
where khoa.tenkhoa='Dia Ly' or khoa.tenkhoa='QLTN'

--7
select tenkhoa, count(Sinhvien.makhoa) as 'Số lượng sv'
from khoa inner join sinhvien
on khoa.makhoa=sinhvien.makhoa
group by tenkhoa

--8
select * from sinhvien
inner join huongdan on sinhvien.masv=huongdan.masv
inner join detai on detai.madt=huongdan.madt
where sinhvien.quequan=detai.noithuctap;

--9
select * from sinhvien
inner join huongdan on sinhvien.masv=huongdan.masv
where ketqua is null

--10
select SinhVien.masv, hotensv from sinhvien
inner join huongdan on sinhvien.masv=huongdan.masv
where ketqua=0;






























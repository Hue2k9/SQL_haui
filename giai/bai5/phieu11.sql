
create table Ton
(
  MaVT char(10) primary key,
  tenvt nvarchar(max),
  SoluongT int
)

create table Nhap
(
  SoHDN char(10),
  MaVT char(10),
  SoLuongN int,
  DonGiaX int,
  NgayX datetime,
  primary key(SoHDN,MaVT),
  constraint PK_Nhap_MaVT foreign key(MaVT)
  references Ton(MaVT)
)

create table Xuat
(
  SoHDX char(10),
  MaVT char(10),
  SoLuongX int,
  DonGiaX int, 
  NgayX datetime,
  constraint PK_Xuat_MaVT foreign key(MaVT)
  references Ton(MaVT)
)

--2 thống kê tiền bán theo mã vật tư gồm MaVT, TenVT, TienBan=SoLuongX*DonGiaX
create view cau2
as 
select ton.MaVT, tenvt, sum(soLuongX*dongiaX) as 'Tien ban'
from xuat inner join Ton on Ton.mavt=Xuat.mavt
group by ton.mavt,tenvt
select * from cau2

--3 Thống kê số lượng xuất theo tên vật tư
create view cau3
as
select ton.mavt, tenvt, sum(soLuongx) as 'So luong xuat'
from xuat inner join Ton on ton.MaVT=xuat.mavt
group by ton.mavt,tenvt
select * from cau3

--4 Thống kê soluongnhap theo tên vật tư
create view cau4
as
select ton.mavt, tenvt, sum(soLuongN) as 'So luong nhap'
from nhap inner join Ton on ton.mavt=nhap.mavt
group by ton.mavt,tenvt
select * from cau4

--5 Đưa ra tổng soluong còn trong kho biết còn=nhap-xuat+ton theo từng nhóm vật tư
create view cau5
as
select ton.mavt,tenvt, sum(soluongN)-sum(soLuongX)+sum(soLuongT) as TongTon
from nhap inner join ton on ton.mavt=nhap.mavt
          inner join xuat on xuat.mavt=ton.mavt
group by ton.mavt,tenvt
select * from cau5


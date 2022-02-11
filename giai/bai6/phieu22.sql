
--cau2
create view view_cau2
as
select tenvt
from ton
where SoluongT=(select max(soluongT) from ton)
select * from view_cau2
drop view view_cau2

--cau 3
create view view_cau3
as
select ton.mavt,ton.tenvt from ton
inner join xuat on xuat.mavt=ton.mavt
group by ton.tenvt,ton.mavt
having sum(soluongx)>100
select * from view_cau3
drop view view_cau3

--cau 4
create view view_cau4
as
select month(ngayx) 'thangxuat',year(ngayx) 'NamXuat',sum(soluongx) 'Soluongxuat'
from xuat
group by month(ngayx), year(ngayx)
select * from view_cau4
drop view view_cau4

--cau 5
create view view_cau5
as
select ton.mavt,tenvt,soluongN,xuat.SoLuongX,nhap.DonGiaX,nhap.NgayX 'ngayN',xuat.NgayX
from ton inner join nhap on ton.MaVT=nhap.MaVT
         inner join xuat on ton.MaVT=xuat.MaVT
select * from view_cau5
drop view view_cau5

--cau 6
create view view_cau6
as
select ton.MaVT, ton.tenvt, sum(nhap.SoLuongN-xuat.SoLuongX+soluongT) 'Tong so luong con'
from ton right join nhap on nhap.MaVT=ton.MaVT
         right join xuat on xuat.mavt=ton.mavt
group by ton.mavt, ton.tenvt
select * from view_cau6
drop view view_cau6









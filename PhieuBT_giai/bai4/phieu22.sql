
--a
select manv, sum(soluongN*dongiaN) 'Tong tien nhap'
from nhap inner join pnhap
on nhap.sohdn=pnhap.sohdn
where month(ngaynhap)=8 and year(ngaynhap)=2020
group by manv
having sum(soluongN*dongiaN)>100000
--b
select Sanpham.masp, tensp
from sanpham inner join nhap on nhap.masp=sanpham.masp
where nhap.masp not in (select masp from xuat)
--c
select sanpham.masp, tensp from sanpham
inner join nhap on nhap.masp=sanpham.masp
inner join pnhap on nhap.sohdn=pnhap.sohdn
inner join xuat on xuat.masp=nhap.masp
inner join pxuat on xuat.sohdx=pxuat.sohdx
where year(ngaynhap)=2020 and year(ngayxuat)=2020
--d
select distinct Nhanvien.manv,tennv
from nhanvien
inner join pnhap on pnhap.manv=nhanvien.manv
where pnhap.manv in (select manv from pxuat)
--e 
select nhanvien.manv,tennv
from nhanvien
where manv not in (
select pnhap.manv from pnhap
inner join pxuat on pnhap.manv=pxuat.manv
where pnhap.manv in (select manv from pxuat)
) 











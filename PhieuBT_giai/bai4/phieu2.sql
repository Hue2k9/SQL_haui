

--1
select nhap.Sohdn,Sanpham.masp,tensp,soluongn,dongian,ngaynhap,tennv,tenphong
from sanpham
inner join Nhap on nhap.masp=sanpham.masp
inner join PNhap on Pnhap.sohdn=nhap.sohdn
inner join NhanVien on Nhanvien.manv=PNhap.manv
inner join Hangsx on SanPham.mahangsx=Hangsx.mahangsx
where tenhang='Samsung' and Year(ngaynhap)=2020
--2 
select top 10 Xuat.Sohdx, ngayxuat, soluongx 
from xuat inner join PXuat on Pxuat.sohdx=xuat.sohdx
where year(ngayxuat)=2020
order by soluongx desc
--c
select top 10 * 
from sanpham
order by giaban desc
--d
select * from Sanpham
inner join HangSx on Hangsx.mahangsx=Sanpham.mahangsx
where tenhang='SamSung' and giaban between 100.000 and 500.000
--e
select sum(soluongn*dongian) as 'Tong tien nhap'
from nhap inner join pnhap on nhap.sohdn=pnhap.sohdn
inner join sanpham on sanpham.masp=nhap.masp
inner join hangsx on hangsx.mahangsx=sanpham.mahangsx
where tenhang='samsung' and year(ngaynhap)=2020
--f
select sum(giaban*soluongx) as 'Tong tien xuat'
from xuat 
inner join sanpham on sanpham.masp=xuat.masp
inner join pxuat on pxuat.sohdx=xuat.sohdx
where ngayxuat='06/14/2020'
--g
select pnhap.sohdn,ngaynhap
from nhap inner join pnhap on pnhap.sohdn=nhap.sohdn
where year(ngaynhap)=2020 and soluongn*dongian=(select max(soluongn*dongiaN) from pnhap
inner join nhap on nhap.sohdn=pnhap.sohdn where year(ngaynhap)=2020)

--==============Bai 2=================
--a
select tenhang,count(masp) as 'so luong'
from hangsx inner join sanpham
on hangsx.mahangsx=sanpham.mahangsx
group by tenhang
--b
select nhap.masp,tensp,sum(soluongN*DongiaN) as 'Tong tien nhap'
from nhap inner join PNhap on nhap.sohdn=pnhap.sohdn
inner join SanPham on sanpham.masp=nhap.masp
where year(ngaynhap)=2020
group by nhap.masp,tensp
--c
select SanPham.masp,Sanpham.tensp,sum(soluongx) 'Tong so luong xuat'
from xuat inner join SanPham on sanpham.masp=xuat.masp
inner join pxuat on pxuat.sohdx=xuat.sohdx
inner join hangsx on hangsx.mahangsx=SanPham.mahangsx
where year(ngayxuat)=2020 and tenhang='SamSung' 
group by SanPham.masp,Sanpham.tensp
having sum(soluongx)>=10000
--d
select tenphong, count(manv) 'so luong'
from nhanvien
where gioitinh='nam'
group by tenphong
--e
select Hangsx.maHangsx,Hangsx.tenhang,sum(soluongn) 'So luong'
from nhap inner join Sanpham on sanpham.masp=nhap.masp
inner join Hangsx on hangsx.mahangsx=sanpham.mahangsx
inner join pnhap on pnhap.sohdn=nhap.sohdn
where year(pnhap.ngaynhap)=2018
group by Hangsx.maHangsx,Hangsx.tenhang

--f
select nhanvien.manv, sum(SanPham.giaban*soluongx) 'Tong tien xuat'
from xuat inner join SanPham on sanpham.masp=xuat.masp
inner join pxuat on pxuat.sohdx=xuat.sohdx
inner join nhanvien on pxuat.manv=nhanvien.manv
where year(ngayxuat)=2018
group by nhanvien.manv




















































































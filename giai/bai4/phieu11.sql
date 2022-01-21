
--a
select top 10 SanPham.masp, tensp, max(SoluongN) 'So luong nhap'
from Nhap inner join sanpham on sanpham.masp=nhap.masp
inner join pnhap on pnhap.sohdn=nhap.sohdn
where year(ngaynhap)=2019
group by  SanPham.masp, tensp
--b
select sanpham.masp, tensp 
from SanPham inner join Hangsx on sanpham.mahangsx=hangsx.mahangsx
inner join nhap on nhap.masp=sanpham.masp
inner join pnhap on pnhap.sohdn=nhap.sohdn
where manv='nv01' and tenhang='SamSung'
--c
select nhap.sohdN,nhap.masp,soluongN,ngaynhap
from nhap inner join pnhap on nhap.sohdn=pnhap.sohdn
inner join xuat on xuat.masp=nhap.masp
inner join pxuat on pxuat.sohdx=xuat.sohdx
where xuat.masp='sp02' and pxuat.manv='nv02'
--d
select nhanvien.manv,tennv 
from nhanvien
inner join pxuat on pxuat.manv=nhanvien.manv
inner join xuat on xuat.sohdx=pxuat.sohdx
where masp='sp02' and ngayxuat='02-03-2020'
















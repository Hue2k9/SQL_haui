
--a
create view view_a
as
select nhap.sohdn,sanpham.masp,tensp,soluongN,dongiaN,ngaynhap,tennv,tenphong
from nhap 
inner join pnhap on nhap.sohdn=pnhap.sohdn
inner join nhanvien on pnhap.manv=nhanvien.manv
inner join sanpham on nhap.masp=sanpham.masp
inner join hangsx on hangsx.mahangsx=sanpham.mahangsx
where tenhang='Samsung' and year(ngaynhap)=2020
select * from view_a

--b
create view view_b
as
select masp,sanpham.mahangsx,tensp,soluong,mausac,giaban,donvitinh,mota
from SanPham
inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
where tenhang='Samsung'and giaban between 100000 and 500000
select * from view_b

--c
create view view_c
as
select sum(nhap.dongian*nhap.soluongN) as 'Tong tien nhap'
from nhap
inner join sanpham on sanpham.masp=nhap.masp
inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
inner join pnhap on nhap.sohdn=pnhap.sohdn
where tenhang='samsung' and year(ngaynhap)=2020
select * from view_c

--d
create view view_d
as
select sum(soluongx*giaban) 'Tong tien xuat'
from xuat 
inner join sanpham on xuat.masp=sanpham.masp
inner join pxuat on pxuat.sohdx=xuat.sohdx
where ngayxuat='06/14/2020'
select * from view_d

--e
create view view_e
as
select pnhap.sohdn,ngaynhap
from pnhap
inner join nhap on pnhap.sohdn=nhap.sohdn
where year(ngaynhap)=2020 and soluongN*dongiaN=(
select max(soluongN*dongiaN)
from nhap inner join pnhap on nhap.SoHDN=PNhap.SoHDN
where year(ngaynhap)=2020
)
select * from view_e

--f
create view view_f
as
select tenhang, count(masp) 'So luong'
from sanpham inner join hangsx on sanpham.mahangsx=hangsx.MaHangSX
group by hangsx.tenhang, hangsx.MaHangSX
select * from view_f

--g
create view view_g
as
select tensp, sum(soluongN*dongiaN) 'Tong tien nhap'
from nhap
inner join sanpham on sanpham.masp=nhap.MaSP
inner join pnhap on pnhap.sohdn=nhap.SoHDN
where year(ngaynhap)=2020
group by sanpham.masp,tensp
select * from view_g

--h
create view view_h
as
select tensp,sum(soluongX) 'So luong xuat'
from xuat inner join pxuat on xuat.SoHDX=pxuat.SoHDX
          inner join SanPham on xuat.MaSP=sanpham.masp
		  inner join hangsx on hangsx.MaHangSX=SanPham.MaHangSX
where year(ngayxuat)=2020 and tenhang='Samsung'
group by tensp,sanpham.masp
having sum(soluongx)>2020
select * from view_h

--i
create view view_i
as
select tenphong, count(nhanvien.manv) 'So luong'
from nhanvien
group by tenphong
select * from view_i

--j
create view view_j
as
select tenhang, sum(soluongn) 'Tong so luong nhap'
from nhap inner join sanpham on sanpham.masp=nhap.MaSP
          inner join hangsx on sanpham.MaHangSX=hangsx.MaHangSX
		  inner join pnhap on pnhap.SoHDN=nhap.SoHDN
where year(ngaynhap)=2018
group by SanPham.MaHangSX,TenHang
select * from view_j

--k
create view view_k
as
select tennv,sum(soluongx*giaban) 'Tong tien xuat'
from xuat inner join pxuat on pxuat.SoHDX=xuat.SoHDX
inner join NhanVien on NhanVien.MaNV=PXuat.MaNV
inner join sanpham on xuat.MaSP=sanpham.masp
group by tennv,pXuat.MaNV
select * from view_k































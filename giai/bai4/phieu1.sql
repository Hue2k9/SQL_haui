
--1
select * from SanPham
select * from HangSX
select * from NhanVien
select * from Nhap
select * from Pnhap 
select * from Xuat
select * from Pxuat
--b
select masp,tensp,tenhang,soluong,mausac,giaban,donvitinh,mota
from sanpham
inner join HangSX on sanpham.mahangsx=Hangsx.mahangsx
order by giaban desc
--c
select * from sanpham
inner join hangsx on sanpham.mahangsx=hangsx.mahangsx
where tenhang='Samsung'
--d
select * from NhanVien
where tenphong=N'kế toán' and gioitinh=N'nữ'
--e
select  PNhap.SoHDN, SanPham.MaSP, TenSP, TenHang, SoLuongN, DonGiaN, SoLuongN*DonGiaN 'Tien nhap', MauSac, DonViTinh, NgayNhap, TenNV,
TenPhong
From Nhap Inner join SanPham on Nhap.MaSP = SanPham.MaSP
 Inner join PNhap on Nhap.SoHDN=PNhap.SoHDN
 Inner join NhanVien on PNhap.MaNV = NhanVien.MaNV
 Inner join HangSX on HangSX.MaHangSX=SanPham.MaHangSX
order by sohdn asc

--f
Select Xuat.SoHDX, SanPham.MaSP, TenSP, TenHang, SoLuongX, GiaBan,
SoLuongX*GiaBan As N'Tiền xuất', MauSac, DonViTinh, NgayXuat, TenNV, TenPhong
From Xuat Inner join SanPham on Xuat.MaSP = SanPham.MaSP
 Inner join PXuat on Xuat.SoHDX=PXuat.SoHDX 
 Inner join NhanVien on PXuat.MaNV = NhanVien.MaNV
 Inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
Where Month(NgayXuat)=06 And Year(NgayXuat)=2020
Order by SoHDX ASC



--1.a
create function Phieu2_b1_a(@maSP char(10))
returns nvarchar(20)
as
begin
     declare @hangSX nvarchar(20)
	 set @hangSX=(select tenHang from HangSX
	    inner join SanPham on SanPham.MaHangSX=HangSX.MaHangSX
		where masp=@maSP
	 )
	 return @hangsx
end
select dbo.Phieu2_b1_a('sp01')

--1.b
create function Phieu2_b1_b(@x int , @y int)
returns int
as
begin
     declare @tongNhap int
	 set @tongNhap=(select sum(soluongN) 
	    from Nhap inner join PNhap 
		on nhap.SoHDN=PNhap.SoHDN
		where year(ngaynhap) between @x and @y
	 )
	 return @tongNhap
end
select dbo.Phieu2_b1_b(2019,2020)

--1.c
create function Phieu2_b1_c(@x nvarchar(20), @y int)
returns int
as
begin
    declare @tongNhap int
	declare @tongXuat int
	declare @thayDoi int
	select @tongNhap= sum(soLuongN) from nhap
	     inner join SanPham on nhap.MaSP=SanPham.MaSP
		 inner join PNhap on nhap.SoHDN=PNhap.SoHDN
		 where tensp=@x and year(ngaynhap)=@y
	select @tongXuat= sum(soluongX) from Xuat
	     inner join SanPham on xuat.MaSP=SanPham.MaSP
		 inner join PXuat on pxuat.SoHDX=xuat.SoHDX
		 where TenSP=@x and year(ngayxuat)=@y
	set @thayDoi=@tongNhap-@tongXuat
	return @thayDoi
end
select dbo.Phieu2_b1_c('Galaxy Note 11',2020)

--1.d
create function Phieu2_b1_d(@x date , @y date)
returns int
as
begin
     declare @tongNhap int
	 set @tongNhap=(select sum(soluongN) 
	    from Nhap inner join PNhap 
		on nhap.SoHDN=PNhap.SoHDN
		where ngaynhap between @x and @y
	 )
	 return @tongNhap
end
select dbo.Phieu2_b1_d('2019-02-05','2020-04-07')


--2.a
create function Phieu2_b2_a(@tenHang nvarchar(20))
returns @bang table(
    maSP nchar(10),
	maHangSX char(10),
	tenSP nvarchar(20),
	soLuong int, 
	mauSac nvarchar(20),
	giaBan money
)
as
begin
     insert @bang
	      select MaSP,SanPham.MaHangSX,tensp,soluong,mausac,giaban
		  from SanPham 
		  inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
		  where TenHang=@tenHang
     return
end
select * from Phieu2_b2_a('samsung')

--2.b
create function Phieu2_b2_b(@x date, @y date)
returns @bang table(
    maSP char(10),
    tenSP nvarchar(20),
	tenHang nvarchar(20),
	ngayNhap date
)
as
begin
    insert @bang
	select sanpham.masp, TenSP, tenhang,NgayNhap
	from SanPham 
	inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
	inner join nhap on nhap.MaSP=SanPham.MaSP
	inner join PNhap on PNhap.SoHDN=nhap.SoHDN
	where NgayNhap between @x and @y
    return 
end
select * from Phieu2_b2_b('2019-02-05','2020-03-22')

--2.c
create function Phieu2_b2_c(@tenHang nvarchar(20), @choose int)
returns @bang table(
    maSP char(10),
    tenSP nvarchar(20),
	soLuong int,
	tenHang nvarchar(20)
)
as
begin
   if(@choose=0)
      insert @bang
	     select MaSP, TenSP,SoLuong,TenHang
		 from SanPham inner join HangSX
		 on SanPham.MaHangSX=HangSX.MaHangSX
		 where SoLuong=0 and TenHang=@tenHang
	if (@choose=1)
	  insert @bang
	     select MaSP, TenSP,SoLuong,TenHang
		 from SanPham inner join HangSX
		 on SanPham.MaHangSX=HangSX.MaHangSX
		 where SoLuong>0 and TenHang=@tenHang
   return
end
select * from Phieu2_b2_c('SamSung',0)
select * from Phieu2_b2_c('SamSung',1)

--2.d
create function Phieu2_b2_d(@tenPhong nvarchar(30))
returns @bang table(
    maNV nchar(10),
	tenNV nvarchar(20),
	tenPhong nvarchar(30)
)
as
begin
    insert @bang
	select MaNV,TenNV,TenPhong
	from NhanVien
	where TenPhong=@tenPhong
    return
end
select * from Phieu2_b2_d(N'kế toán')











--1.a
create function Bai1_a(@maSP char(10))
returns nvarchar(20)
as
begin 
     declare @tenHang nvarchar(20)
	 set @tenHang=(select tenHang from HangSX
	              inner join SanPham on Hangsx.MaHangSX=SanPham.MaHangSX
				  where masp=@maSP
	   )
	   return @tenHang
end
select dbo.Bai1_a('sp01')

--1.b
create function Bai1_b(@x int, @y int, @z nvarchar(20))
returns int
as
begin
    declare @count int
	set @count=(
	   select count(SanPham.masp) from SanPham
	   inner join HangSX on Sanpham.MaHangSX=Hangsx.MaHangSX
	   where tenhang=@z and giaban between @x and @y
	   group by HangSx.MaHangSX
	)
	return @count
end
select dbo.bai1_b(0,25000000,'samsung')

--bai2
create function bai2(@x int, @y nvarchar(20))
returns @bang table(
     maSP nchar(10),
	 maHangSX nchar(10),
	 tenSP nvarchar(20),
	 soLuong int, 
	 mauSac nvarchar(20),
	 giaBan money,
	 DonViTinh nchar(10),
	 moTa nvarchar(max)
)
as
begin
     insert @bang
	       select MaSP,SanPham.MaHangSX,TenSP,SoLuong,MauSac,GiaBan,DonViTinh,Mota
		   from SanPham 
		   inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
		   where GiaBan>=@x and TenHang=@y
	 return 
end
select * from dbo.bai2(8000000,'SamSung')
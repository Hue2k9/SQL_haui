--a
create function cauA(@diaChi nvarchar(max))
returns @bang table(
   MaHangSX char(10),
   tenHangSX nvarchar(20)
)
as
begin
     insert @bang
	 select mahangsx, TenHang
	 from HangSX
	 where DiaChi=@diaChi
return
end
select * from cauA('Ha Noi')

--b
create function cauB(@x int, @y int)
returns @bang table(
     Masp char(10),
	 tensp nvarchar(20),
	 Hangsx nvarchar(20)
)
as
begin
   insert @bang
   select  Sanpham.MaSP,TenSP,TenHang from SanPham
   inner join HangSX on hangsx.MaHangSX=SanPham.MaHangSX
   inner join xuat on xuat.MaSP=SanPham.MaSP
   inner join PXuat on PXuat.SoHDX=xuat.SoHDX
   where year(ngayxuat) between @x and @y
return
end
select * from cauB(2016,2022)

--c
create function cauC(@choose int)
returns @bang table(
     masp char(10),
	 tensp nvarchar(20)
)
as
begin
	if (@choose=0)
	  insert @bang
	  select nhap.MaSP, tensp from nhap
	  inner join SanPham on SanPham.MaSP=nhap.MaSP
	if (@choose=1)
	  insert @bang
	  select xuat.MaSP,tensp from xuat
	  inner join SanPham on SanPham.MaSP=xuat.MaSP
return
end
select * from cauC(0)
select * from cauC(1)

--d
create function cauD(@date date)
returns @bang table(
   manv char(10),
   tenNV nvarchar(50)
)
as
begin
    insert @bang
	select NhanVien.MaNV, tennv from NhanVien
	inner join PNhap on PNhap.MaNV=NhanVien.MaNV
	where NgayNhap=@date
return
end
select * from cauD('2019-02-05')

--e
create function cauE(@x money, @y money, @z nvarchar(30))
returns @bang table(
   masp char(10),
   tensp nvarchar(50)
)
as
begin
   insert @bang
   select masp,tensp from SanPham
   inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
   where TenHang=@z and GiaBan between @x and @y
return
end
select * from cauE(0,5000000,'oppo')

--f
create function cauF()
returns @bang table(
    masp char(10),
	tensp nvarchar(50),
	tenhangsx nvarchar(30)
)
as
begin
    insert @bang
	select masp, TenSP, TenHang from SanPham 
	inner join HangSX on SanPham.MaHangSX=HangSX.MaHangSX
return 
end
select * from cauF()
































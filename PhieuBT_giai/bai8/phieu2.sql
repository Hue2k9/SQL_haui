
--Cau1
create proc sp_nhapkhoa3(@makhoa int,@tenkhoa nvarchar(20),@dienthoai nvarchar(12),
@kq int output)
as
  begin
     if (exists(select * from khoa where tenkhoa=@tenkhoa))
	   set @kq=0
	 else
	   insert khoa values(@makhoa,@tenkhoa,@dienthoai)
	 return @kq
  end
-- goi thu tuc
declare @loi int
exec sp_nhapkhoa3 '8','cnttasas','12356',@loi output
select @loi

--cau2
create proc sp_nhapkhoa4(@malop int, @tenlop nvarchar(20), 
@namnhaphoc int, @makhoa int, @kq int output)
as
begin
   if(not exists (select * from lop where tenlop=@tenlop))
     set @kq=0
   else
      if(not exists (select * from khoa where makhoa=@makhoa))
	    set @kq=1
	  else
	    set @kq=2
   return @kq
end



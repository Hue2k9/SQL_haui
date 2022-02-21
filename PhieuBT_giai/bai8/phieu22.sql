--cau 1
create proc cau1(@manv nvarchar(4), @macv nvarchar(2), @tennv nvarchar(30),
@ngaysinh datetime, @luongcanban float, @ngaycong int, @phucap float, @kq int output)
as
begin
    if(not exists (select macv from tblchucvu where macv=@macv))
	  set @kq=0
	else
	  insert tblNhanVien values(@manv,@macv,@tennv,@ngaysinh,@luongcanban,@ngaycong,@phucap)
     return @kq
end
--goi thu tuc
declare @error int
exec cau1 'nv08','vs','Tran Van Hoang','2022-02-21',789,5,15,@error output
select @error

declare @error int
exec cau1 'nv09','oo','Tran Van Hoang','2022-02-21',789,5,15,@error output
select @error

select * from tblNhanVien

--cau 2
alter proc cau1(@manv nvarchar(4), @macv nvarchar(2), @tennv nvarchar(30),
@ngaysinh datetime, @luongcanban float, @ngaycong int, @phucap float, @kq int output)
as
begin
   set @kq=1
    if(not exists (select macv from tblchucvu where macv=@macv))
	  set @kq=0
	else
	  begin
	     if (not exists (select manv from tblNhanVien where manv=@manv))
	         insert tblNhanVien values(@manv,@macv,@tennv,@ngaysinh,@luongcanban,@ngaycong,@phucap)
		 else
		     set @kq=0
	  end

     return @kq
end
--goi thu tuc
declare @kq int
exec cau1 'nv08','bv','Tran Van Hoang','2022-02-21',789,5,15,@kq output
select @kq

declare @kq int
exec cau1 'nv10','bv','Tran Van Hoang','2022-02-21',789,5,15,@kq output
select @kq

--cau3
create proc SP(@manv char(10), @ngaySinh datetime, @kq int output)
as
begin
    set @kq=1
    if (exists (select manv from tblNhanVien where manv=@manv))
	   update tblNhanVien set ngaysinh=@ngaySinh where manv=@manv
	else
	   set @kq=0;
	return @kq
end
--goi thu tuc
declare @kq int
exec sp 'nv10','2022-01-01', @kq output
select @kq

declare @kq int
exec sp 'nv19','2022-01-01', @kq output
select @kq

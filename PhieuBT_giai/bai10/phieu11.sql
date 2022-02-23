create database QLBH
go
use QLBH
go
create table MatHang(
   mahang int primary key,
   tenHang nvarchar(50),
   soluong int
)
create table NhatKyBanHang(
   stt int primary key,
   ngay datetime,
   nguoimua nvarchar(50),
   mahang int,
   soluong int,
   giaban money,
   constraint Fk_mahang foreign key(mahang)
   references MatHang(mahang)
)
insert MatHang values
(1,'keo',100),
(2,'banh',200),
(3,'thuoc',100)
insert NhatKyBanHang values
(1,'1999-02-09','ab',2,230,50000)

--a
create trigger trg_nhatkybanhang_insert on NhatKyBanHang
for insert
as
begin
    update MatHang set soluong=mathang.soluong-inserted.soluong
	from MatHang inner join inserted
	on MatHang.mahang=inserted.mahang
end

select * from MatHang
select * from NhatKyBanHang
insert NhatKyBanHang values
(2,'2022-02-23','Hue',2,30,50)
select * from MatHang
select * from NhatKyBanHang
drop trigger trg_nhatkybanhang_insert

--b
create trigger trg_nhatkybanhang_update_soluong on NhatKyBanHang
for update
as
begin
   if update(soluong)
     update MatHang
	 set mathang.soluong=mathang.soluong-(inserted.soluong-deleted.soluong) 
	 --mathang.soluong=mathang.soluong - inserted.soluong + deleted.soluong
	 from (deleted inner join inserted on
	 deleted.stt=inserted.stt) inner join MatHang
	 on MatHang.mahang=deleted.mahang
end
select * from MatHang
select * from NhatKyBanHang
update NhatKyBanHang set soluong=soluong-20 where stt=1
select * from MatHang
select * from NhatKyBanHang
drop trigger trg_nhatkybanhang_update_soluong 

--c
alter trigger trg_checksoluong on nhatkybanhang
for insert
as
begin
   declare @soluongbanra int
   declare @soluongco int
   declare @mahang int
   set @mahang=(select mahang from inserted)
   set @soluongbanra=(select soluong from inserted)
   set @soluongco=(select mathang.soluong from MatHang 
	                     where mathang.mahang=@mahang)
   
   if (@soluongbanra >@soluongco)
     begin
	 print 'so luong khong du'
     rollback transaction
	 end
   else
     begin
     update MatHang set soluong=@soluongco-@soluongbanra
	 from MatHang
	 where mahang=@mahang
	 print 'insert thanh cong'
	 end
end

select * from MatHang
select * from NhatKyBanHang
insert NhatKyBanHang values
(6,'2022-02-23','Hoang Minh Hue',3,91,999)
select * from MatHang
select * from NhatKyBanHang
drop trigger  trg_checksoluong

--d
create trigger update_nhatkybanhang on NhatKyBanHang
for update
as
begin
   declare @mahang int
   declare @sl_inserted int --inserted.soluong
   declare @sl_deleted int   --deleted.soluong
   if (select count(*) from inserted) > 1
      begin
	     raiserror('Khong duoc update qua 1 dong lenh',16,1)
		 rollback transaction
		 return
	  end
	else
	if update(soluong)
	  begin
	     select @sl_deleted=soluong from deleted
		 select @sl_inserted=soluong from inserted
		 select @mahang=mahang from inserted

		 update MatHang set soluong=soluong-@sl_inserted+@sl_deleted
		 where mahang=@mahang
	  end
end
select * from MatHang
select * from NhatKyBanHang
update NhatKyBanHang set soluong=50
select * from MatHang
select * from NhatKyBanHang

update NhatKyBanHang set soluong=99 where stt=6
select * from MatHang
select * from NhatKyBanHang
drop trigger update_nhatkybanhang

--e
create trigger Delete_nkbh on NhatKyBanHang
for delete
as
begin
   declare @soluong int
   declare @mahang int
   if(select count(*) from deleted)>1
     begin
	   raiserror('loi xoa ban ghi',16,1)
	   rollback transaction
	 end
	else
	  begin
	    select @mahang=mahang from deleted
	    select @soluong=soluong from deleted
		update MatHang set soluong=soluong+@soluong
		where mahang=@mahang
	  end
end
--th1
select * from MatHang
select * from NhatKyBanHang
delete from NhatKyBanHang
--th2
select * from MatHang
select * from NhatKyBanHang
delete from NhatKyBanHang where stt=6
select * from MatHang
select * from NhatKyBanHang
drop trigger Delete_nkbh

--f 
create trigger update_nkbh on NhatKybanHang
for update
as
begin
   declare @soluongco int
   declare @soluongupdate int
   declare @mahang int
   if(select count(*) from updated)>1
     begin
	   raiserror('khong duoc cap nhat qua 1 ban ghi',16,1)
	   rollback transaction
	 end
   else
     begin
    if(@soluongupdate<@soluongco)
	  begin
	  raiserror('Khong cap nhat duoc')
	  rollback transaction
	  end
	if (@soluongupdate=@soluongco)
	   begin
	     raiserror('Khong can cap nhat')
		 rollback transaction
	   end
	 if (@soluongupdate>@soluongco)
     begin
	   select @mahang=mahang from updated
	   select @soluongco=soluong from MatHang where mahang=@mahang
	   select @soluongupdate=soluong from updated
	 end
	end
end
select * from MatHang
select * from NhatKyBanHang


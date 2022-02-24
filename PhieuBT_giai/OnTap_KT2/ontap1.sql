create database QuanLyKho
go
use QuanLyKho
go

create table Pxuat(
  soPX char(10) primary key,
  ngayNhap datetime,
  ghiChu nvarchar(50)
)

create table VatTu(
  mavt char(10) primary key,
  tenvt nvarchar(50),
  soluongT int
)

create table CTPXuat(
  soPX char(10),
  mavt char(10),
  soluongx int,
  dongiaX money,
  constraint Pk_ctpxuat primary key(sopx,mavt),
  constraint Fk_ctpxuat_soPX foreign key(sopx)
  references pxuat(sopx),
  constraint Fk_ctpxuat_mavt foreign key(mavt)
  references vattu(mavt)
)

insert Vattu values
('vt01','vat tu 1',100),
('vt02','vat tu 2',150),
('vt03','vat tu 3',200),
('vt04','vat tu 4',100),
('vt05','vat tu 5',100)

insert pxuat values
('x01','2022-02-23',''),
('x02','2022-02-23',''),
('x03','2022-02-23','abc')

insert ctpxuat values
('x01','vt01',5,19),
('x02','vt02',7,780),
('x03','vt03',10,683)

-- cau 2
create proc proc_ThemMoi(@mavt char(10), @tenvt nvarchar(50),
@soluong int)
as
begin
   if (not exists (select mavt from VatTu where mavt=@mavt))
      begin
	     if (@soluong>=0)
            insert VatTu values(@mavt,@tenvt,@soluong)
		 else
		    print 'So luong phai lon hon 0'
	  end
	else
	  print 'Ma vat tu da ton tai'
end

exec proc_ThemMoi 'vt08', 'vat tu 8', 100
exec proc_ThemMoi 'vt06', 'vat tu 6', 999
exec proc_ThemMoi 'vt09', 'vat tu 5', -1
select * from vattu

--cau 3
create trigger trg_insert_ctpxuat on ctpxuat
for insert
as
begin
    declare @mavt char(10)
	declare @sopx char(10)
	declare @soluongxuat int
	declare @soluongton int

	select @mavt=mavt from inserted
	select @sopx=sopx from inserted
	select @soluongxuat=soluongx from inserted
	select @soluongton=soluongt 
	   from VatTu inner join inserted
	   on VatTu.mavt=inserted.mavt
	   where vattu.mavt=@mavt

	if (exists (select vattu.mavt,pxuat.sopx from VatTu 
	  inner join CTPXuat on CTPXuat.mavt=vattu.mavt
	  inner join Pxuat on Pxuat.soPX=CTPXuat.soPX
	))
	  begin
	     if (@soluongxuat>@soluongton)
		   begin
		      update VatTu set soluongT=@soluongxuat where mavt=@mavt
		      raiserror('So luong ton khong du',16,1)
			  rollback transaction
		   end
		 else
		   print 'Them moi thanh cong'
	  end
	  else
	     begin
		     raiserror('Them moi khong thanh cong',16,1)
			 rollback transaction
		 end
end

select * from VatTu
select * from Pxuat
select * from CTPXuat
alter table ctpxuat check constraint all
insert CTPXuat values ('x03','vt01',900,10)
insert CTPXuat values ('x04','vt10',900,10)
insert CTPXuat values ('x03','vt04',7832,19)
insert CTPXuat values ('x03','vt04',9,19)
select * from VatTu
select * from Pxuat
select * from CTPXuat




























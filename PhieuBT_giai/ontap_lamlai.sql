create database QLKho1
go
use QLkho1
go
create table Ton 
(
  mavtu char(10) primary key,
  tenvtu nvarchar(100),
  soluongt int
)
create table nhap(
  sohdn char(10) primary key,
  mavtu char(10),
  soluongn int,
  dongian money,
  ngayN datetime,
  constraint fk_nhap foreign key(mavtu)
  references ton(mavtu)
)
create table xuat(
  sohdx char(10) primary key,
  mavtu char(10),
  soluongx int,
  dongiax money,
  ngayx datetime,
  constraint fk_xuat foreign key(mavtu)
  references ton(mavtu)
)

insert ton values
('vt001',N'khăn giấy',100),
('vt002',N'Xà phòng giặt máy Ôm túi 2kg',200),
('vt003',N'dầu ăn tường an 3l',30),
('vt004',N'nước rửa bát sunlight',150)
insert ton values
('vt005',N'kẹo',999)

insert nhap values
('pn001','vt001',12,18000,'2021-04-12'),
('pn002','vt001',50,18000,'2021-12-17'),
('pn003','vt002',50,230000,'2020-04-12')

insert xuat values
('px001','vt001',2,20000,'2021-04-25'),
('px002','vt003',12,250000,'2020-04-22'),
('px003','vt004',2,15000,'2020-05-01')

select * from Ton
select * from Nhap
select * from Xuat

-- Cau 3a
create proc pr_Xoa(@mavt char(10))
as
begin
   if(exists (select * from nhap where mavtu=@mavt))
      print N'Mã vật tư này đã có trong bảng nhập nên không xóa đc'
   else
     begin
      if(exists(select * from xuat where mavtu=@mavt))
	     print N'Mã vật tư này đã có trong bảng xuất nên không xóa đc'
	  else
	    begin
	     delete from ton where mavtu=@mavt
		 print N'Xóa thành công'
		 end
	 end
end
exec dbo.pr_xoa 'vt002'
exec dbo.pr_xoa 'vt004'
exec dbo.pr_xoa 'vt005'

-- cau 3b
create proc insert_vattu(@mavt char(10),@tenvattu nvarchar(100), @soluongt int )
as
begin
    if (exists (select * from ton where mavtu=@mavt))
	   print N'Mã vật tư đã tồn tại'
	else
	   begin
	     insert ton values(@mavt,@tenvattu,@soluongt)
		 print N'Thêm vật tư thành công'
	   end
end

select * from ton
exec dbo.insert_vattu 'vt004',N'sách giáo khoa 6',10
exec dbo.insert_vattu 'vt006',N'sách tiếng anh',100

-- Câu 3c
create proc HienThi (@tenvt nvarchar(100))
as
begin
    if (exists (select * from ton where tenvtu=@tenvt))
	   select * from ton where tenvtu=@tenvt
	else
	   print N'Tên vật tư không tồn tại'
end
select * from ton
exec dbo.HienThi N'khăn giấy'
exec dbo.HienThi N'sách sql'

-- câu 4a
create trigger trg_insert on nhap
for insert
as
begin
   declare @mavt char(10)
   if (not exists (select * from ton where mavtu=(
     select mavtu from inserted
   )))
      begin
	    raiserror(N'Mã vật tư chưa tồn tại trong bảng tồn',16,1)
		rollback transaction
	  end
	else
	  update ton
	  set soluongt=soluongt+(select soluongN from inserted)
	  where mavtu=(select mavtu from inserted)
end
select * from ton
select * from nhap
alter table nhap nocheck constraint all
insert nhap values ('pn004','vt007',58,180375,'2022-02-25')-- mã vật tư chưa có
select * from ton
select * from nhap
insert nhap values ('pn005','vt006',58,180375,'2022-02-25')
select * from ton
select * from nhap

-- Câu 4b
create trigger trg_update on xuat
for update
as
begin
    declare @slmoi int
	declare @slcu int
	select @slmoi=soluongx from inserted 
	select @slcu=soluongx from deleted 
    if(@slmoi-@slcu<=(select soluongt from ton where mavtu=(select mavtu from inserted)))
	   update ton
	   set soluongt=soluongt-@slmoi+@slcu
	   where ton.mavtu=(select mavtu from inserted) 
	else
	   begin
	      raiserror(N'Hàng không đủ',16,1)
		  rollback transaction
	   end
end
select * from ton
select * from xuat
update xuat set soluongx=150 where mavtu='vt001' and sohdx='px001'
update xuat set soluongx=90 where mavtu='vt001' and sohdx='px001'


























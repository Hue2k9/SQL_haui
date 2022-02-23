
create table Hang(
   maHang char(10) primary key,
   tenHang char(50),
   soLuong int,
   giaBan money
)

create table HoaDon(
   maHD char(10) primary key,
   maHang char(10),
   soLuongBan int, 
   ngayBan datetime,
   constraint Fk_HoaDon_maHang foreign key(maHang)
   references Hang(maHang)
)
insert Hang values
('h01','ao',100,70000)

create trigger Insert_Hoadon on HoaDon
for insert
as
begin
   if(not exists(select * from hang 
     inner join inserted 
	 on hang.maHang=inserted.maHang
   ))
     begin
	   raiserror('Loi khong co hang',16,1)
	   rollback transaction
	 end
	else
	  begin
	    declare @soluong int
		declare @soLuongBan int
		select @soluong=soluong from Hang
		inner join inserted on hang.maHang=inserted.maHang
		select @soluongBan=inserted.soluongban
		from inserted
		if (@soluong<@soLuongBan)
		  begin
		     raiserror('Ban khong du hang',16,1)
			 rollback transaction
		  end
		else
		   update Hang set soluong=@soLuong-@soLuongBan
		   from hang inner join inserted
		   on hang.maHang=inserted.maHang
	  end
	  
end

-- goi trigger
select * from hang
select * from Hoadon

alter table hoadon nocheck constraint all
insert hoadon values
('hd02','h01',25,'1999-09-02'),
alter table hoadon nocheck constraint all
insert hoadon values
('hd03','h01',50,'1999-09-02')

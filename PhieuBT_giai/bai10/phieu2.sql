--cau1
create trigger check_delete on hoadon
for delete
as
begin
    update hang set soluong=soluong+deleted.soluongban
	from hang 
	inner join deleted on hang.mahang=deleted.mahang
	where hang.mahang=deleted.mahang
end

select * from hang
select * from Hoadon
delete hoadon where mahd='1'
select * from hang
select * from hoadon

--cau2
create trigger check_update on hoadon
for update
as
begin
    declare @truoc int
	declare @sau int
	select @truoc=deleted.soluongban from deleted
	select @sau=inserted.soluongban from inserted
	update hang set soluong=soluong-(@sau-@truoc)
	from hang 
	inner join inserted on hang.mahang=inserted.mahang
end
select * from hang
select * from hoadon
update Hoadon set soluongban=soluongban-10
where mahang='hd02'
select * from hang
select * from hoadon
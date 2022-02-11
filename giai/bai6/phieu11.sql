
select * from nhap
select * from xuat
select * from ton

insert ton values
('vt05','vattu5',500),
('vt01','vattu1',10),
('vt02','vattu2',90),
('vt03','vattu3',75),
('vt04','vattu4',99)
insert nhap values
('n3','vt02',1,100,'2021-02-11'),
('n1','vt01',1,100,'2022-02-11'),
('n2','vt01',1,200,'2022-01-07')
insert xuat values
('x2','vt01',1,90,'2022-01-10'),
('x1','vt02',1,80,'2022-01-09')

--d
delete from ton
from nhap
inner join ton on nhap.MaVT=ton.MaVT
inner join xuat on xuat.MaVT=ton.MaVT
where xuat.DonGiaX<nhap.DonGiaX
alter table ton nocheck constraint all 
alter table nhap nocheck constraint all 
alter table xuat nocheck constraint all 


--e
update xuat 
from nhap
set ngayx=ngayn


select * from xuat



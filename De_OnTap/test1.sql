create database test1

create table sinhvien(
	masv int primary key,
	hoten nvarchar(40),
	namsinh int,
	quequan nvarchar(30)) go

create table detai(
	madt char(10) primary key,
	tendt nvarchar(30),
	kinhphi int,
	noithuctap nvarchar(30),
	masv int,
	ketqua decimal(5,2)
	foreign key (masv) references sinhvien(masv)
	) go 

insert into sinhvien 
values (1,N'Lê Văn Nam',1990,N'Nghệ An'),
	   (2,N'Nguyễn Thị Mỹ',1990,N'Thanh Hóa'),
	   (3,N'Bùi Xuân Đức',1992,N'Hà Nội'),
	   (4,N'Nguyễn Văn Tùng',null,N'Hà Tĩnh'),
	   (5,N'Lê Khánh Linh',1989,N'Hà Nam') go 

insert into detai 
values
('Dt01', 'GIS', 100, N'Nghệ An', 1, 6.80),
('Dt02', 'ARC GIS', 500, N'Nam Định', 2, 7.65),
('Dt03', 'Spatial DB', 100, N'Hà Tĩnh', 2, 8.25),
('Dt04', 'Blockchain', 300, N'Nam Định', null, null),
('Dt05', 'Cloud Computing', 700, N'Nam Định', null, null) go

-- bai 2 
-- 1
create or alter proc sp_bai1
	@ketqua decimal(5,2)
as 
begin 
	select detai.masv, hoten, kinhphi, noithuctap, ketqua
	from detai 
		join sinhvien on sinhvien.masv = detai.masv
	where ketqua < @ketqua 
end go

exec sp_bai1 7 go 

-- 2 
create or alter function fn_bai2 (@masv int)
returns int 
as 
begin 
	declare @trungbinh int
	select @trungbinh = avg(kinhphi) from detai where masv = @masv 
	return @trungbinh
end go 

select masv, hoten, dbo.fn_bai2(masv) tbKinhPhi
from sinhvien go

-- 3
create or alter trigger tg_bai3 on sinhvien
instead of delete 
as 
begin 
	delete from detai where masv in (select masv from deleted)
	delete from sinhvien where masv in (select masv from deleted)
end go 

delete from sinhvien
where masv = 1 go

-- 4
create or alter view vw_bai4 
as
select masv, tendt, kinhphi, noithuctap, ketqua 
from detai 
where masv is null go

select*from vw_bai4

insert into sinhvien (masv, hoten)
values (7,'sinhvien7')

update vw_bai4
set masv = 7, ketqua = 7.5
where masv is null 

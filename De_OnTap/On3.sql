create database On3

CREATE TABLE KHACH_HANG (
    MaKH VARCHAR(3) PRIMARY KEY,
    Hotenkh NVARCHAR(50),
    Diachi NVARCHAR(50)
)

CREATE TABLE DON_DAT_HANG (
    SoDH VARCHAR(4) PRIMARY KEY,
    Ngaydat DATETIME,
    MaKH VARCHAR(3),
    FOREIGN KEY (MaKH) REFERENCES KHACH_HANG(MaKH)
)

CREATE TABLE CT_DAT_HANG (
    SoDH VARCHAR(4),
    MaSP VARCHAR(5),
    Soluong INT,
    Dongia MONEY,
    PRIMARY KEY (SoDH, MaSP),
    FOREIGN KEY (SoDH) REFERENCES DON_DAT_HANG(SoDH)
)

insert into khach_hang 
values
('a01', N'Trần thị Phương Trang', N'111 Nguyễn Trãi'),
('a02', N'Lê Thu Thủy', N'222 Lê Lợi'),
('a03', N'Trần Quốc Thái', N'20 Trần Quốc Thảo'),
('a04', N'Đỗ Thị Mộng Thu', N'18 Lê Hồng Phong'),
('a05', N'Lê Ngô Minh Tâm', N'255 Trần Hưng Đạo')

insert into DON_DAT_HANG
values
('d001','2-15-2007','a01'),
('d002','2-20-2007','a02'),
('d003','3-2-2007','a01')

insert into CT_DAT_HANG
values 
('d001','jac01',1, 1200000),
('d001','smn01',2, 180000),
('d001','ves01',1, 700000),
('d002','qty02',1, 150000),
('d002','smn02',2, 180000) go


-- Bai 2
-- 1
create or alter view vw_bai1 
as
select*from KHACH_HANG go

insert into vw_bai1 
values
('a06', N'la ngoc hung', N'111 Nguyễn Trãi') go

-- 2
create or alter view vw_bai2
as 
select kh.makh, Hotenkh, diachi 
from KHACH_HANG kh
	join DON_DAT_HANG dh on dh.MaKH = kh.MaKH
where year(ngaydat) = 2007 and MONTH(ngaydat) = 2 go 

select*from vw_bai2 go

-- 3
create or alter function fn_bai3 (@makh varchar(3))
returns int
as 
begin 
	return
	(select count(makh) from DON_DAT_HANG where makh = @makh)
end go

print dbo.fn_bai3('a01') go

-- 4
create or alter proc sp_bai4 
	@makh varchar(3)
as
begin
	select ddh.sodh, ngaydat,hotenkh, dbo.fn_bai3(@makh) solan, sum(soluong*dongia) thanhtien
	from KHACH_HANG kh
		join DON_DAT_HANG ddh on ddh.MaKH = kh.MaKH
		join CT_DAT_HANG cdh on cdh.SoDH = ddh.SoDH
	group by ddh.sodh, ngaydat, hotenkh, kh.makh
	having kh.MaKH = @makh 
end go

exec sp_bai4 'a01' go 

-- 5
create or alter proc sp_bai5 
	@masp varchar(5)
as 
begin
	update CT_DAT_HANG
	set Dongia = Dongia*0.9
	where masp like @masp
end 

exec sp_bai5 'jac01'




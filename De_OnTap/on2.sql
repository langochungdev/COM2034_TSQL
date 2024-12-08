create database on2

create table hoadon(
	mahoadon varchar(10) primary key,
	ngaydathoadon date,
	tenkhachhang nvarchar(50),
	dienthoai varchar(11)
)

create table hoadonchitiet(
	sothutu int primary key identity,
	mahoadon varchar(10),
	tenmathang nvarchar(100),
	dongia money,
	soluong int,
	foreign key (mahoadon) references hoadon(mahoadon)
)

set dateformat dmy
insert into hoadon
values ('CM1204','12/04/2018', N'Trần Anh', '0123951241'),
		('AB2654','20/03/2018', N'Lê Hoàng Nhân', '0909123532'),
		('FE5323','27/01/2018', N'Vũ Bình Minh', '0919353623'),
		('TB3423','01/04/2018', N'Nguyễn Hà', '0242155269'),
		('SM4353','30/03/2018', N'Nguyễn Thụ', '0912455682')

INSERT INTO hoadonchitiet
VALUES
    ('FE5323', N'Tủ lạnh', 3500000, 20),
    ('FE5323', N'Tivi', 7000000, 30),
    ('AB2654', N'Máy giặt', 4500000, 120),
    ('AB2654', N'Máy Lạnh', 11000000, 35),
    ('SM4353', N'Tủ lạnh', 3500000, 55),
    ('CM1204', N'Máy giặt', 4500000, 40),
    ('TB3423', N'Máy Lạnh', 11000000, 250) go

-- Bai 2 
-- 1 
create or alter view vw_thanhtien
as 
select tenkhachhang, hd.mahoadon, ngaydathoadon, dongia, dongia*soluong thanhtien
from hoadon hd
	join hoadonchitiet ct on ct.mahoadon=hd.mahoadon go

select*from vw_thanhtien go

-- 2 
create or alter proc sp_capnhatDonGia
	@tenMatHang nvarchar(100),
	@donGiaMoi money
as
begin 
	update hoadonchitiet
	set dongia = @donGiaMoi
	where tenmathang like @tenMatHang
end go 

exec sp_capnhatDonGia 'tivi', 1 go 

-- 3
create or alter function fn_tongGiaTriDonTheoTenKH (@tenKH nvarchar(50))
returns float
as
begin
    return (select sum(thanhtien) from vw_thanhtien where tenkhachhang like @tenKH)
end go

print dbo.fn_tongGiaTriDonTheoTenKH(N'Vũ Bình Minh') go

--4
create or alter function fn_top1mathang()
returns table 
as
return(select top 1 with ties tenmathang, sum(soluong) soluongmua
		from hoadonchitiet
		group by tenmathang
		order by sum(soluong) desc) go

select*from dbo.fn_top1mathang() go


-- 5
create or alter view vw_bai5
as
select top 100 percent tenkhachhang, ngaydathoadon, ct.mahoadon, sum(soluong) soluongmua
		from hoadonchitiet ct
			join hoadon on hoadon.mahoadon = ct.mahoadon
		group by tenkhachhang, ngaydathoadon, ct.mahoadon
		having year(ngaydathoadon) = 2018 and month(ngaydathoadon)= 3
		order by 'soluongmua' desc go

select*from vw_bai5








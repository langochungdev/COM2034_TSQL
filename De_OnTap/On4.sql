create database On4
use On4


create table tacgia (
    matg varchar(5) primary key,
    tentg nvarchar(50) not null,
    ngaysinh datetime,
    noisinh nvarchar(50)
)

create table sach (
    masach varchar(5) primary key,
    tensach nvarchar(50) not null,
    matg varchar(5) foreign key references tacgia(matg),
    nhaxb nvarchar(50) not null,
    sotrang int not null
)

create table phieumuon (
    mapm int identity primary key,
    masach varchar(5) foreign key references sach(masach),
    ngaymuon datetime not null,
    ngaytra datetime
)

insert into tacgia (matg, tentg, ngaysinh, noisinh) values
('TG001', N'Trần Đan Thư', '1966-10-23', N'Tp.HCM'),
('TG002', N'Nguyễn Nhật Ánh', '1955-05-07', N'Quảng Nam'),
('TG003', N'Minh Long Book', null, null);

insert into sach (masach, tensach, matg, nhaxb, sotrang) values
('IT001', N'Nhập Môn Lập Trình', 'TG001', N'NXB Khoa học - Kỹ thuật', 320),
('TN002', N'Ngồi khóc trên cây', 'TG002', N'NXB Trẻ', 378),
('KT003', N'60 Giây Vàng Trong Bán Hàng', 'TG003', N'NXB Dân Trí', 416),
('IT004', N'Nhập Môn SQL Server', 'TG001', N'NXB Giáo Dục', 400),
('KN005', N'Hài Hước Một Chút Thế Giới Sẽ Khác Đi', 'TG003', N'NXB Thanh Niên', 400);

insert into phieumuon (masach, ngaymuon, ngaytra) values
('IT001', '2019-10-28', null),
('KT003', '2019-11-12', '2019-11-11'),
('IT004', '2019-12-22', '2020-02-15'),
('IT001', '2020-03-20', null),
('KT003', '2020-05-01', null)go

-- 2
create or alter view ViewSachMuon 
as
select sach.masach, tensach, tentg, ngaysinh, noisinh, ngaymuon
from sach 
	join tacgia on tacgia.matg = sach.matg
	join phieumuon on phieumuon.masach = sach.masach
where ngaytra is null go

select count(*) from ViewSachMuon go

-- 3
create or alter proc sp_bai3 @masach varchar(5)
as
begin 
	select tensach, tentg, ngaymuon, ngaytra
	from sach 
		join tacgia on tacgia.matg = sach.matg
		join phieumuon on phieumuon.masach = sach.masach
	where sach.masach like @masach
end go

exec sp_bai3 KT003 go

-- 4
create or alter function fn_bai4 (@matg varchar(5))
returns int 
begin 
	declare @tong int 
	select @tong = count(*) from sach
	where matg like @matg
	return @tong
end go

print dbo.fn_bai4('TG001') go

-- 5
create or alter proc sp_bai5 @mapm int 
as
begin 
	declare @ngaytra datetime
	select @ngaytra = ngaytra from phieumuon where mapm = @mapm
	if @ngaytra is null
		begin 
			update phieumuon 
			set ngaytra = getdate()
			where mapm = @mapm
			print 'update ngay tra'
		end
	else 
		begin
			select phieumuon.masach, tensach, ngaymuon, ngaytra
			from phieumuon
				join sach on sach.masach = phieumuon.masach
			where mapm =@mapm
		end
end go

exec sp_bai5 1





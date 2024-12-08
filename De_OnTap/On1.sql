create database On1 
go

create table phieunhap(
	mapn varchar(10) primary key,
	ngaylap date not null,
	nhacc nvarchar(50) not null,
	ghichu nvarchar(50) not null)

create table sanpham(
	masp varchar(10) primary key,
	tensp nvarchar(50) not null,
	slton int,
	quicach nvarchar(50))

create table ct_pnhap(
	mapn varchar(10),
	masp varchar(10),
	slmua int not null,
	dongia money not null
	foreign key (mapn) references phieunhap(mapn),
	foreign key (masp) references sanpham(masp)
	)
go

insert into phieunhap
values ('1','2024-01-01','nhacc1','ghichu1'),
		('2','2024-01-01','nhacc2','ghichu2'),
		('3','2024-01-01','nhacc3','ghichu3')

insert into sanpham
values ('1','ten1', 1,'quicach1'),
		('2','ten2', 2,'quicach2'),
		('3','ten3', 3,'quicach3')

insert into ct_pnhap
values ('1','1', 1,1),
		('2','2', 2,2),
		('3','3', 3,3)
go

-- bai 2
create or alter proc sp_insertsanpham 
	@masp varchar(10),
	@tensp nvarchar(50),
	@slton int,
	@quicach nvarchar(50)
as 
begin 
	insert into sanpham 
	values (@masp, @tensp, @slton, @quicach)
end go

exec sp_insertsanpham '4','ten4',4,'quicach4' 
go

-- 2
create or alter proc sp_timtheomapn 
	@mapn varchar(10)
as
begin
	select ct_pnhap.mapn, phieunhap.ngaylap, masp, slmua, slmua*dongia as thanhtien 
	from ct_pnhap 
		join phieunhap on phieunhap.mapn = ct_pnhap.mapn
	where ct_pnhap.mapn = @mapn
end 
go 
exec sp_timtheomapn '2'go

-- 3
create or alter proc sp_timPhieuNhapTheoNgay
	@ngayfrom date,
	@ngayto date
as
begin 
	select*from phieunhap 
	where ngaylap between @ngayfrom and @ngayto
end 
go
exec sp_timPhieuNhapTheoNgay '2024-01-01', '2024-01-02' go

-- 4 0--------
create or alter function fn_TongSLMuaTheoMaSP (@masp varchar(10))
returns int 
as
begin 
	declare @tong int
	select @tong = sum(slmua) from ct_pnhap where masp = @masp
	return @tong
end go

print dbo.fn_TongSLMuaTheoMaSP('1') go


-- 5
create or alter function fn_SLHienCoTheoMaSP (@masp varchar(10))
returns varchar(20)
begin 
	declare @tong int
	select @tong = slton+slmua
	from sanpham
		join ct_pnhap on ct_pnhap.masp = sanpham.masp
	where sanpham.masp = @masp
	return 'so luong hien co: '+cast(@tong as varchar)
end go

print dbo.fn_SLHienCoTheoMaSP('1') go

-- 6
create or alter view vw_3slmuaCaoNhat 
as
	select top(3) ct.masp, sp.tensp, sum(slmua) TongSLMua, sum(slmua)*dongia ThanhTien
	from ct_pnhap ct
		join sanpham sp on sp.masp = ct.masp
	group by ct.masp, sp.tensp, dongia
	order by 'TongSLMua' desc
	go

select*from vw_3slmuaCaoNhat go

-- 7
create or alter view vw_3spMuaNhieuNhat
as
select phieunhap.mapn, ngaylap, nhacc
from phieunhap
	join ct_pnhap ct on ct.mapn = phieunhap.mapn
	join vw_3slmuaCaoNhat vw on vw.masp = ct.masp
where ct.masp = vw.masp
group by phieunhap.mapn, ngaylap, nhacc
go
select*from vw_3spMuaNhieuNhat
go

-- 8
create or alter proc sp_capnhat 
	@ngay date
as
begin try
	update sanpham
	set slton += ctp.sumslmua
	from sanpham
		 join(select masp, sum(slmua) as sumslmua
			from ct_pnhap
			group by masp) ctp on ctp.masp = sanpham.masp
			
	
	update ct_pnhap
	set slmua = 0
	from ct_pnhap 
		join phieunhap on phieunhap.mapn = ct_pnhap.mapn
	where ngaylap < @ngay
end try
begin catch
	rollback tran
	THROW
end catch go

-- 9
create or alter proc sp_phieuNhapNotInCTN
as
begin 
	delete from phieunhap
	where mapn not in(select mapn from ct_pnhap)
end 

exec sp_phieuNhapNotInCTN go

-- 10
create or alter function fn_dsSLtonNhoNhat ()
returns table
as
return (select top 1 with ties * from sanpham order by slton asc) go

select*from dbo.fn_dsSLtonNhoNhat()
go
-- 11 
create or alter trigger tg_SLMuaDonGiaLonHonKhong on ct_pnhap
for insert
as
begin 
	declare @slmua int, @dongia money 
	select @slmua = slmua, @dongia = dongia from inserted

	if(@slmua <= 0) or (@dongia <= 0)
		begin
			rollback tran
			print 'slmua,dongia > 0'
		end
end
go

insert into ct_pnhap
values ('4','4',10,10)

-- BAI 1
-- 1
create function TinhTuoi_Ma (@ma nvarchar(9))
returns int 
as 
begin 
	return (select year(getdate())-year(ngSinh)
			from NHANVIEN
			where MANV = @ma)
end go

select dbo.TinhTuoi_Ma ('009') 
print 'Tuoi la: '+cast(dbo.TinhTuoi_Ma('009')as varchar)
go

-- 2
create function DemDA (@ma nvarchar(9))
returns int 
as 
begin 
	return(select count(mada) 
		   from PHANCONG
		   where ma_nvien = @ma )
end 
go 

print 'so luong de an 009 la: '+ cast(dbo.DemDA('009')as varchar)
go

-- 3
create or alter  function SL_Phai (@phai nvarchar(3))
returns int 
as 
begin 
	return (select count(*) from NHANVIEN where phai = @phai)
end
go

print 'phai: '+cast(dbo.SL_Phai('Nam')as varchar)
go

-- 4
create function LuongTTB_MaPhg (@tenphg nvarchar(15))
returns table 
as 
return(select (honv+' '+tenlot+' '+tennv)ten from NHANVIEN 
		where luong > (select avg(luong) from nhanvien 
				where phg = (select maphg from PHONGBAN where tenphg = @tenphg)))
go

select*from LuongTTB_MaPhg(N'Nghiên Cứu')
go 

-- 5
create function fc_timphong (@maphg int)
returns table
as
return(
	select tenphg, honv, tennv, count(c.mada)soDA
	from PHONGBAN a
		join NHANVIEN b on a.MAPHG = b.PHG
		join DEAN c on c.phong = a.MAPHG
	where maphg = @maphg
	group by tenphg, honv, tennv
) go

select*from dbo.fc_timphong (4) go

-- BAI 2
-- 1
create view ThongTinNV_lab7b2a
as 
select honv, tennv, PHONGBAN.TENPHG, DIADIEM_PHG.DIADIEM
from NHANVIEN
	join PHONGBAN on NHANVIEN.PHG = PHONGBAN.MAPHG
	join DIADIEM_PHG on DIADIEM_PHG.MAPHG = PHONGBAN.MAPHG
go

select*from ThongTinNV_lab7b2a go
sp_helptext ThongTinNV_lab7b2a go

-- 2
create view TTNV_lab7b2b
as
select tennv, luong, year(getdate())-year(ngsinh) tuoi
from NHANVIEN go

select*from TTNV_lab7b2b go

-- 3
create view PhgNV_DongNhat_lab7b2c
as
select top(1) with ties
	b.TENPHG, tp.tennv, count(a.manv)SoNhanVien
from NHANVIEN a
	join PHONGBAN b on b.MAPHG = a.phg
	join NHANVIEN tp on tp.manv = b.TRPHG
group by b.TENPHG, tp.tennv
order by count(a.manv) desc go

select*from PhgNV_DongNhat_lab7b2c go




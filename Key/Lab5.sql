-- BAI 1
-- 1
create or alter procedure sp_Lab5_b1a
	@ten nvarchar(50)
as
print N'Xin Chào ' + @ten

exec sp_Lab5_b1a N'Hùng' go

-- 2
create or alter proc sp_Lab5_b1b
	@s1 int, @s2 int
as
begin 
	declare @tong int
	set @tong = @s1+@s2
	print N'Tổng 2 số là: '+ cast(@tong as varchar)
end

exec sp_Lab5_b1b 1, 2 go

-- 3 
create or alter proc sp_Lab5_b1c
	@n int
as 
begin 
	declare @tong int = 0, @i int = 2
	while(@i <= @n)
	begin
	    set @tong = @tong + @i
		set @i += 2
	end 
	print 'tong cac so chan: '+ cast(@tong as varchar)
end
exec sp_Lab5_b1c 8 go

-- 4
create or alter proc sp_Lab5_b1d
	@a int,
	@b int
as
begin
	while(@a != @b)
	begin
		if(@a > @b)
			set @a -= @b
		else
			set @b -= @a
	end
	print 'uoc chung lon nhat: '+ cast(@a as varchar)
end
exec sp_Lab5_b1d 10, 20 go

-- BAI 2
-- 1
create or alter proc sp_Lab5_b2a
	@maNV nvarchar(9)
as
begin
	select*from NHANVIEN 
	where MANV = @maNV
end
exec sp_lab5_b2a '001' go

-- 2
create or alter proc sp_Lab5_b2b
	@maDA int
as
begin
	select mada, count(ma_nvien)soNhanVien
	from PHANCONG
	group by mada
	having mada = @maDA
end
exec sp_Lab5_b2b 10 go

-- 3
create or alter proc sp_Lab5_b2c
	@maDA int,
	@dDiem nvarchar(15)
as
begin
	select a.mada, ddiem_da, count(ma_nvien)soNhanVien
	from PHANCONG a
		join CONGVIEC b on a.MADA = b.MADA
		join dean c on b.MADA = c.MADA
	where a.mada = @maDA and ddiem_da = @dDiem 
	group by a.mada, ddiem_da
end
exec sp_Lab5_b2c 3, 'TP HCM' go

-- 4
create or alter proc sp_Lab5_b2d
	@maTP nvarchar(9)
as 
begin
	select TRPHG, *
	from NHANVIEN a
		join PHONGBAN b on a.MANV = b.TRPHG
	where TRPHG = @maTP 
		and MANV not in (select ma_nvien from THANNHAN)
end
exec sp_Lab5_b2d '006' go

-- 5
create or alter proc Lab5_b2e
	@maNV nvarchar(9),
	@maPB int
as 
begin
	if exists (select*from NHANVIEN where manv = @maNV and phg = @maPB)
		print 'nhan vien: '+@maNV +' thuoc phong ban: '+cast(@maPB as varchar)
	else
		print 'nhan vien: '+@maNV +' khong thuoc phong ban: '+cast(@maPB as varchar)
end
exec Lab5_b2e '001', 4 go

-- BAI 3
-- 1
create or alter proc Lab5_b3a
	@tenP nvarchar(15),
	@maP int,
	@maTP nvarchar(9),
	@ngayNhanChuc date
as
begin 
	if exists (select maphg from PHONGBAN where maphg = @maP)
		print cast(@maP as varchar) + ' da ton tai'
	else
		begin
			insert into PHONGBAN
			values (@tenP, @maP, @maTP, @ngayNhanChuc)
			print 'thanh cong'
		end 
end
exec Lab5_b3a 'cntt', 9, '001','2023-01-01' go

-- 2
create or alter proc Lab5_b3b
	@tenP nvarchar(15),
	@tenCN nvarchar(15)
as
begin 
	update PHONGBAN
	set TENPHG = @tenCN
	where TENPHG = @tenP
end
exec Lab5_b3b 'cntt', 'it' go

-- 3
create or alter proc Lab5_b3c
	@ho nvarchar(15),
	@tenlot nvarchar(15),
	@ten nvarchar(15),
	@ma nvarchar(9),
	@ngSinh datetime,
	@diaChi nvarchar(30),
	@phai nvarchar(3),
	@luong float
as 
begin
	declare @phg int = (select top(1) MAPHG from PHONGBAN where tenphg = 'it'),
			@maQL nvarchar(9)
	if(@luong < 25000)
		set @maQL = '009'
	else
		set @maQL = '005'

	declare @tuoi int
	set @tuoi = year(getdate())-year(@ngSinh)
	if(@phai = 'Nam')
		begin
			if(@tuoi<18 or @tuoi>65)
			print '18<tuoi<65'
			return
		end
	else
		begin
			if(@tuoi<18 or @tuoi>60)
			print '18<tuoi<60'
			return 
		end
	insert into NHANVIEN
	values (@ho, @tenlot, @ten, @ma, @ngSinh, @diaChi, @phai, @luong, @maQL, @phg)
end
exec Lab5_b3c 'la', 'ngoc', 'hung', '018', '2003-09-29', 'hcm', 'Nam', 20000 go


create or alter proc sp_TangLuong
as
begin
    declare @MaNV int, @Luong float, @i int = 1, @lenNV int

    select @lenNV = COUNT(*) from NhanVien;

    while @i <= @lenNV
    begin
        select top 1 
            @MaNV = MaNV, 
            @Luong = Luong
        from NhanVien
        where MaNV NOT IN (select top (@i - 1) MaNV from NhanVien order by MaNV)
        order by MaNV

        if @Luong >= 40000
			begin
				update NhanVien
				set Luong *= 1.05
				where MaNV = @MaNV;
			end
        else
			begin
				update NhanVien
				set Luong *= 1.10
				where MaNV = @MaNV;
			end
		set @i += 1
    end
end go

exec sp_TangLuong




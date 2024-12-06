-- YEU CAU 1
CREATE TABLE LOAINHA (
    MaLoaiNha INT PRIMARY KEY NOT NULL,
    TenLoaiNha NVARCHAR(50) NOT NULL
)

CREATE TABLE NGUOIDUNG (
    MaNguoiDung INT PRIMARY KEY NOT NULL,
    TenNguoiDung NVARCHAR(50) NOT NULL,
    GioiTinh BIT NOT NULL,
    DienThoai VARCHAR(20) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    Quan NVARCHAR(20) NOT NULL,
    Email VARCHAR(50)
)

CREATE TABLE NHATRO (
    MaNhaTro INT PRIMARY KEY NOT NULL,
    MaLoaiNha INT NOT NULL,
    DienTich FLOAT CHECK (DienTich >= 0) NOT NULL,
    GiaPhong MONEY CHECK (GiaPhong >= 0) NOT NULL,
    DiaChi NVARCHAR(50) NOT NULL,
    Quan NVARCHAR(20) NOT NULL,
    MoTa NVARCHAR(50),
    NgayDang DATE NOT NULL,
    NguoiLienHe INT NOT NULL,
    FOREIGN KEY (MaLoaiNha) REFERENCES LOAINHA(MaLoaiNha),
    FOREIGN KEY (NguoiLienHe) REFERENCES NGUOIDUNG(MaND)
)

CREATE TABLE DANHGIA (
    MaNT INT NOT NULL,
    MaND INT NOT NULL,
    DanhGia BIT NOT NULL,
    NoiDungDanhGia NVARCHAR(50),
    PRIMARY KEY (MaNT, MaND),
    FOREIGN KEY (MaNT) REFERENCES NHATRO(MaNT),
    FOREIGN KEY (MaND) REFERENCES NGUOIDUNG(MaNguoiDung)
)


-- YEU CAU 2
INSERT INTO LoaiNha 
VALUES (1, N'Nhà trọ'), (2, N'Căn hộ'), (3, N'Biệt thự');


INSERT INTO NguoiDung 
VALUES 
(1, N'Nguyen Van A', 1, '0123456789', N'123', N'Nguyen Trai', N'Phuong 1', N'Quan 1', N'vana@gmail.com'),
(2, N'Tran Thi B', 0, '0123456781', N'456', N'Le Loi', N'Phuong 2', N'Quan 3', N'thib@gmail.com'),
(3, N'Pham Van C', 1, '0123456782', N'789', N'Tran Hung Dao', N'Phuong 3', N'Quan 5', N'vanc@gmail.com'),
(4, N'Le Thi D', 0, '0123456783', N'101', N'Dien Bien Phu', N'Phuong 5', N'Quan 7', N'thid@gmail.com'),
(5, N'Nguyen Van E', 1, '0123456784', N'202', N'Ly Thuong Kiet', N'Phuong 10', N'Quan 10', N'vane@gmail.com'),
(6, N'Tran Thi F', 0, '0123456785', N'303', N'Hoa Binh', N'Phuong 7', N'Quan 12', N'thif@gmail.com'),
(7, N'Pham Van G', 1, '0123456786', N'404', N'Nguyen Van Linh', N'Phuong 9', N'Quan 4', N'vang@gmail.com'),
(8, N'Le Thi H', 0, '0123456787', N'505', N'Hai Ba Trung', N'Phuong 8', N'Quan 6', N'thih@gmail.com'),
(9, N'Nguyen Van I', 1, '0123456788', N'606', N'Thich Quang Duc', N'Phuong 11', N'Quan 9', N'vani@gmail.com'),
(10, N'Tran Thi J', 0, '0123456780', N'707', N'Bach Dang', N'Phuong 15', N'Quan Binh Thanh', N'thij@gmail.com');

INSERT INTO NhaTro 
VALUES 
(1, 1, 1, 25.5, 1500000, N'123', N'Nguyen Trai', N'Phuong 1', N'Quan 1', N'Nhà trọ 1', '2024-11-01'),
(2, 1, 2, 30.0, 2000000, N'456', N'Le Loi', N'Phuong 2', N'Quan 3', N'Nhà trọ 2', '2024-11-01'),
(3, 1, 3, 20.0, 1200000, N'789', N'Tran Hung Dao', N'Phuong 3', N'Quan 5', N'Nhà trọ 3', '2024-11-02'),
(4, 2, 4, 50.0, 5000000, N'101', N'Dien Bien Phu', N'Phuong 5', N'Quan 7', N'Căn hộ 1', '2024-11-03'),
(5, 2, 5, 45.0, 4500000, N'202', N'Ly Thuong Kiet', N'Phuong 10', N'Quan 10', N'Căn hộ 2', '2024-11-03'),
(6, 3, 6, 100.0, 10000000, N'303', N'Hoa Binh', N'Phuong 7', N'Quan 12', N'Biệt thự 1', '2024-11-04'),
(7, 3, 7, 120.0, 15000000, N'404', N'Nguyen Van Linh', N'Phuong 9', N'Quan 4', N'Biệt thự 2', '2024-11-05'),
(8, 1, 8, 28.0, 1600000, N'505', N'Hai Ba Trung', N'Phuong 8', N'Quan 6', N'Nhà trọ 4', '2024-11-05'),
(9, 1, 9, 25.0, 1400000, N'606', N'Thich Quang Duc', N'Phuong 11', N'Quan 9', N'Nhà trọ 5', '2024-11-06'),
(10, 2, 10, 40.0, 4000000, N'707', N'Bach Dang', N'Phuong 15', N'Quan Binh Thanh', N'Căn hộ 3', '2024-11-07');


INSERT INTO DanhGia 
VALUES 
(1, 1, 1, N'Tốt'),
(2, 1, 0, N'Không hài lòng'),
(3, 2, 1, N'Tiện nghi'),
(4, 3, 1, N'Giá cả hợp lý'),
(5, 4, 0, N'Không hài lòng về vị trí'),
(6, 5, 1, N'Yên tĩnh, thích hợp cho gia đình'),
(7, 6, 1, N'Dịch vụ tốt'),
(8, 7, 0, N'Khá đắt đỏ'),
(9, 8, 1, N'Phù hợp với nhu cầu'),
(10, 9, 1, N'Giá rẻ, tiện ích đầy đủ') go


-- YEU CAU 3
-- Bai 1
-- a
create or alter proc sp_insertNguoiDung
	@ma int,
	@ten nvarchar(50),
	@gioiTinh bit,
	@dienThoai varchar(12),
	@soNha nvarchar(50),
	@duong nvarchar(50),
	@phuong nvarchar(50),
	@quan nvarchar(50),
	@email nvarchar(50)
as 
if ((@ma is null) or (@ten is null) or (@gioiTinh is null) or (@soNha is null) or (@duong is null) or (@phuong is null) or (@quan is null) or (@email is null))
	print 'thieu thong tin'
else
	insert into NguoiDung
	values (@ma, @ten, @gioiTinh, @dienThoai, @soNha, @duong,@phuong, @quan, @email) go

exec sp_insertNguoiDung  null, 'Nguyen Van A', 1, '0123456789', N'123', 'Nguyen Trai','phuong 1', 'Quan 1', 'vana@gmail.com'  go

-- b
create or alter PROCEDURE sp_insertNhaTro
    @MaTro INT,
    @Loai INT,
    @NguoiDung INT,
    @DienTich FLOAT,
    @GiaTien BIGINT,
    @SoNha NVARCHAR(50),
    @Duong NVARCHAR(50),
    @Phuong NVARCHAR(50),
    @Quan NVARCHAR(50),
    @MoTa NVARCHAR(200),
    @NgayCapNhat DATE
as
if ((@MaTro is null) or (@Loai is null) or (@NguoiDung is null) or (@DienTich is null) or (@GiaTien is null) or (@SoNha is null) or (@Duong is null) or (@Quan is null)) or (@MoTa is null) or (@NgayCapNhat is null)
	print 'thieu thong tin'
else
	insert into NhaTro
	values (@MaTro, @Loai, @NguoiDung, @DienTich, @GiaTien, @SoNha, @Duong, @Phuong, @Quan, @MoTa, @NgayCapNhat) go

exec sp_insertNhaTro null, 1, 2, 35.0, 1800000, '10', 'Ton Duc Thang', 'Phuong 1', 'Quan 2', 'Nhà trọ 6', '2024-11-10' go

-- c
create or alter proc sp_InsertDanhGia
    @MaDanhGia int,
    @MaTro int,
    @KetQua bit,
    @NoiDung nvarchar(200)
as
if (@MaDanhGia is null) or (@MaTro is null) or (@KetQua is null) or (@NoiDung is null)
	print 'thieu thong tin'
else
	insert into DanhGia
	values (@MaDanhGia, @MaTro, @KetQua, @NoiDung) go

exec sp_InsertDanhGia null, 10, 1, 'good' go 
-- Bai 2
-- a procedure
create or alter proc sp_TimTro
	@quan nvarchar(50) = N'%',
	@loaiNhaTro nvarchar(50) = N'%',
	@dienTichMin real = null,
	@dienTichMax real = null,
	@giaMin money = null,
	@giaMax money = null,
	@ngayDangMin date = null,
	@ngayDangMax date = null
as
begin
	if(@dienTichMin is null) select @dienTichMin = min(dientich) from NhaTro
	if(@dienTichMax is null) select @dienTichMax = max(dientich) from NhaTro
	if(@giaMin is null) select @giaMin = min(GiaPhong) from NhaTro
	if(@giaMax is null) select @giaMax = max(GiaPhong) from NhaTro
	if(@ngayDangMin is null) select @ngayDangMin = min(NgayDang) from NhaTro
	if(@ngayDangMax is null) select @ngayDangMax = max(NgayDang) from NhaTro

	select 'cho thue tai:'+nt.SoNha+' '+nt.duong+' '+nt.Phuong+' '+nt.quan DCNhaTro,
		replace(cast(dientich as nvarchar),'.',',')+'m2' DienTich,
		replace(left(convert(varchar, giaphong,1), len(convert(varchar, giaphong,1))-3) ,',','.') GiaPhong,
		Mota,
		convert(varchar,ngaydang, 105) ngayDang,
		case gioitinh
			when 1 then 'Anh. '+tennd
			when 0 then 'Chi. '+tennd 
		end NguoiLienHe,
		nd.dienthoai,
		nd.SoNha+' '+nd.duong+' '+nd.Phuong+' '+nd.quan DCNguoiDung
	from NhaTro nt
		join NguoiDung nd on nd.MaND = nt.MaND
		join LoaiNha ln on ln.MaLoaiNha = nt.MaLoaiNha
	where (nt.Quan like @quan) and (ln.TenLoaiNha like @loaiNhaTro)
		and (DienTich between @dienTichMin and @dienTichMax)
		and (GiaPhong between @giaMin and @giaMax)
		and (NgayDang between @ngayDangMin and @ngayDangMax)
end go

exec sp_TimTro N'Quan 1', N'Nhà trọ' go 

-- b function 
create or alter function fn_MaNguoiDung(
								@ten nvarchar(50) = N'%',
								@sdt nvarchar(12) = N'%', 
								@quan nvarchar(50) = N'%')
returns table
return  select MaND from NguoiDung 
		where (TenND like @ten) and (DienThoai like @sdt) and (quan like @quan) go		

select*from nguoidung
where MaND in (select MaND from dbo.fn_MaNguoiDung(default, default, 'Quan 1')) go

-- c
create or alter function fn_tongLike (@MaNT int)
returns int
as
begin
	return (select count(*) from danhgia where mant = @mant and Like_DisLike = 1)
end go

create or alter function fn_tongDisLike (@MaNT int)
returns int
as
begin
	return (select count(*) from danhgia where mant = @mant and Like_DisLike = 0)
end go

select *, dbo.fn_tongLike(mant) 'like', dbo.fn_tongDisLike(mant) dislike from NhaTro go

-- d
create or alter view vw_Top10NhaTro
as
select top 10
		dbo.fn_tongLike(MaNT) 'like',
		'cho thue tai:'+nt.SoNha+' '+nt.duong+' '+nt.Phuong+' '+nt.quan DCNhaTro,
		replace(cast(dientich as nvarchar),'.',',')+' m2' DienTich,
		replace(left(convert(varchar, giaphong,1), len(convert(varchar, giaphong,1))-3),',','.') GiaPhong,
		Mota,
		convert(varchar,ngaydang, 105) ngayDang,
		case gioitinh
		when 1 then 'Anh. '+tennd
		when 0 then 'Chi. '+tennd 
		end nguoiDangTin,
		nd.SoNha+' '+nd.duong+' '+nd.Phuong+' '+nd.quan DCNguoiDung,
		nd.dienthoai, nd.Email
from NhaTro nt
	join NguoiDung nd on nd.MaND = nt.MaND
	join LoaiNha ln on ln.MaLoaiNha = nt.MaLoaiNha
	order by 'like' desc go

select*from vw_Top10NhaTro go

-- e
create or alter proc sp_DanhGia @mant int 
as
if not exists (select*from nhatro where MaNT = @mant)
	print 'MaNT khong ton tai'
else 
	begin 
		if not exists (select*from DanhGia where MaNT = @mant)
			print 'MaNT chua duoc danh gia' 
		else 
			begin
				select dg.mant, nd.MaND, tennd,
					case dg.like_dislike
						when 1 then 'like'
						when 0 then 'dislike'
					end DanhGia, NoiDung
				from DanhGia dg
					join NguoiDung nd on nd.mand = dg.mand
				where dg.MaNT = @mant
			end
	end 

exec sp_DanhGia 1 go


-- Bai 3
-- 1
create or alter proc sp_DeleteNhaTroDisLike @dislike int
as
begin
	declare @tbNhaTro table(MaNT int)
	declare @demXoaNT int =0
	insert into @tbNhaTro
	select MaNT from NhaTro where dbo.fn_TongDisLike(MaNT) >= @dislike
	begin tran
		delete from DanhGia where MaNT in(select MaNT from @tbNhaTro)
		delete from NhaTro where MaNT in(select MaNT from @tbNhaTro)
		set @demXoaNT = @@ROWCOUNT
	commit tran
	if(@demXoaNT = 0)
		print 'khong tim thay ban ghi'
	else
		print 'xoa thanh cong'
end

exec sp_DeleteNhaTroDisLike 2 go

-- 2
create or alter proc sp_deleteNhaTro_byNgayDang @tuNgay date,@denNgay date
as
begin try
	declare @tbNhaTro table(MaNT int)
	insert into @tbNhaTro
	select MaNT from NhaTro where NgayDang between @tuNgay and @denNgay

	begin tran
		delete from DanhGia where MaNT in(select MaNT from @tbNhaTro)
		delete from NhaTro where MaNT in(select MaNT from @tbNhaTro)
		print 'xoa thanh cong'
	commit tran
end try
begin catch
	rollback tran
	print 'xoa that bai'
end catch

exec sp_deleteNhaTro_byNgayDang '2024-11-01','2024-11-02' go





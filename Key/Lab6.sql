-- BAI 1
-- 1
create or alter trigger KiemTraLuong on nhanvien
for insert 
as 
begin 
	if (select luong from inserted) < 1500
	begin 
		print 'luong > 1500'
		rollback tran
	end
end 

insert into nhanvien
values ('La', 'Ngoc', 'Hung', '1000', '2003-09-29', 'diaChi', 'Nam', 100, '001', 4)go

-- 2
create trigger KT_tuoi on nhanvien 
for insert 
as 
begin
	if exists (select*from inserted where year(getdate())-year(ngsinh) not between 18 and 65)
	begin 
		print 'tuoi 18-65'
		rollback transaction 
	end
end 

insert into nhanvien
values ('La', 'Ngoc', 'Hung', '999', '2020-09-29', 'diaChi', 'Nam', 2000, '001', 4)go

-- 3
create or alter trigger NoUpdate_hcm on nhanvien
for update 
as 
begin 
	if(select dchi from inserted) like '%HCM%'
	begin 
		print 'no update dchi hcm'
		rollback transaction
	end
end

update NHANVIEN
set luong+=1
where manv = 001 go 

-- BAI 2
-- 1
create or alter trigger TongNamNu on nhanvien
for insert 
as 
begin
	select phai, count(phai) soLuong 
	from NHANVIEN 
	group by PHAI 
	having phai like 'Nam' or phai like N'Nữ'
end

insert into nhanvien
values ('La', 'Ngoc', 'Hung', '999', '2000-09-29', 'diaChi', 'Nam', 2000, '001', 4)go

-- 2
create or alter trigger SuaPhai on nhanvien
for update 
as 
begin
	if update(phai)
	select phai, count(phai) soLuong 
	from NHANVIEN 
	group by PHAI 
	having phai like N'Nam' or phai like N'%Nữ%'
end

update NHANVIEN
set phai = N'Nữ' 
where manv = '999'go

-- 3
create trigger xoa_DeAn on dean
for delete
as 
select ma_nvien, count(mada) from PHANCONG group by MA_NVIEN

delete from dean
where mada = 100 go 

-- BAI 3
-- 1
create trigger xoa_nhanvien_thanhnhan on nhanvien
instead of delete
as 
begin 
	delete from THANNHAN where MA_NVIEN in (select manv from deleted) 
	delete from nhanvien where manv in (select manv from deleted) 
end

delete from nhanvien where manv = 017 go

-- 2
create or alter trigger them_DeAn1 on nhanvien
for insert 
as  
insert into phancong values ((select manv from inserted), 1, 1, 1) 

insert into nhanvien
values ('La', 'Ngoc', 'Hung', '111', '2000-09-29', 'diaChi', 'Nam', 2000, '001', 4) go
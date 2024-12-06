select*from nhanvien
where PHG = 4
-- 2
select*from NHANVIEN
where LUONG > 3000
-- 3
select*from NHANVIEN
where LUONG > 25000 and PHG = 4
or LUONG > 30000 and PHG = 5
-- 4
select CONCAT(HONV,' ',TENLOT,' ',TENNV) as ten, DCHI AS DiaChi
from NHANVIEN
where DCHI like '%hcm' or DCHI like '%Minh'
-- 5
select*from nhanvien
where HONV like 'ng%'
-- 6
select HONV, TENLOT, TENNV, DCHI, NGSINH
from NHANVIEN
where HONV like N'Đinh%' and TENLOT like N'Bá%' and TENNV like N'Tiên%' 
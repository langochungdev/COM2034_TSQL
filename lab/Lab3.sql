SELECT  MA_NVIEN,
		CAST(THOIGIAN as decimal(10,2)) ThoiGian_2ThapPhan,
	   'thoi gian= ' + CONVERT(VARCHAR, THOIGIAN) ThoiGian_varchar
from PHANCONG


-- TEST LAB3
-- 1: ma ten tong thoi gian lam viec tai cac du an lam tron 2 so 
select manv,concat( honv,' ', tenlot,' ', tennv) , round(sum(thoigian),2) thoigian
from NHANVIEN
	join PHANCONG on nhanvien.MANV = PHANCONG.MA_NVIEN
group by manv, honv, tenlot, tennv

-- 2: hien thi nhan vien, luong cao hon luongtb cua ca cong ty 
declare @luongtb int = (select avg(luong) from nhanvien)
select manv, tennv, luong
from NHANVIEN
where luong > @luongtb


-- BAI 1
-- 1
SELECT TENDEAN, 
	   CAST(SUM(c.THOIGIAN) as decimal(10,2)) ThoiGian_2ThapPhan,
	   CONVERT(VARCHAR, SUM(c.THOIGIAN)) ThoiGian_varchar
from DEAN a
	JOIN CONGVIEC b ON a.MADA = b.MADA
	JOIN PHANCONG c ON b.MADA = c.MADA
GROUP BY a.TENDEAN

-- 2    
SELECT TENPHG,
	   REPLACE(CAST(AVG(LUONG)AS decimal(10,2)), '.', ',') LuongTB_Replace
FROM PHONGBAN a
	JOIN NHANVIEN b ON a.MAPHG = b.PHG
GROUP BY TENPHG

--
SELECT TENPHG, 
	   REPLACE(CAST(AVG(LUONG)AS VARCHAR),
	     RIGHT(CAST(AVG(LUONG)AS VARCHAR),3), 
   ',' + RIGHT(CAST(AVG(LUONG)AS VARCHAR),3)) LuongTB
FROM PHONGBAN a
	JOIN NHANVIEN b ON a.MAPHG = b.PHG
GROUP BY TENPHG

-- format 
SELECT TENPHG, 
		FORMAT(AVG(LUONG), '#,###.#0')
FROM PHONGBAN a
	JOIN NHANVIEN b ON a.MAPHG = b.PHG
GROUP BY TENPHG


-- BAI 2
-- 1 
SELECT TENDEAN, 
	   SUM(THOIGIAN),
	   CEILING(SUM(THOIGIAN)) H_ceiling,
	   FLOOR(SUM(THOIGIAN)) H_floor,
	   ROUND(SUM(THOIGIAN),2) H_round
FROM DEAN a
	JOIN CONGVIEC b ON a.MADA = b.MADA
	JOIN PHANCONG c ON b.MADA = c.MADA
GROUP BY TENDEAN

-- 2
SELECT HONV, TENLOT, TENNV, ROUND(LUONG,2) Luong_Round2
FROM NHANVIEN
WHERE LUONG > (SELECT AVG(LUONG) FROM NHANVIEN a
					JOIN PHONGBAN b ON a.PHG = b.MAPHG
			   WHERE TENPHG = N'Nghiên Cứu')

-- BAI 3
-- 1
SELECT UPPER(HONV), 
	   LOWER(TENLOT), 
	   LEFT(LOWER(TENNV),1) + SUBSTRING(UPPER(TENNV),2,1) + RIGHT(LOWER(TENNV), LEN(TENNV)-2),
--	   STUFF(LOWER(TENNV), 2, 1, SUBSTRING(UPPER(TENNV),2,1) ),
	   SUBSTRING(DCHI, CHARINDEX(' ',DCHI)+1, CHARINDEX(',',DCHI)-CHARINDEX(' ',DCHI)),
	   COUNT(MA_NVIEN) ThanNhan
FROM NHANVIEN a
	 JOIN THANNHAN b ON a.MANV = b.MA_NVIEN
GROUP BY HONV, TENLOT, TENNV, DCHI
HAVING COUNT(MA_NVIEN) > 2

-- 2
SELECT  TOP(1) WITH TIES
		a.PHG,
		TENPHG,
		TRPHG,
		c.TENNV TruongPhong,
		REPLACE(c.TENNV, c.TENNV, 'Fpoly') TruongPhong,
		COUNT(a.MANV) SoNhanVien 
FROM NHANVIEN a
	 JOIN PHONGBAN b ON a.PHG = b.MAPHG
	 JOIN NHANVIEN c ON b.TRPHG = c.MANV -- trả về tên 1 trưởng phòng trong mỗi phòng 
GROUP BY a.PHG, TENPHG, TRPHG, c.TENNV
ORDER BY COUNT(a.MANV) DESC

-- BAI 4
-- 1
SELECT*FROM NHANVIEN
WHERE YEAR(NGSINH) BETWEEN 1960 AND 1965

-- 2
SELECT *, YEAR(GETDATE()) - YEAR(NGSINH) TUOI
FROM NHANVIEN

-- 3
SELECT *, DATENAME(WEEKDAY, NGSINH) THU
FROM NHANVIEN

-- 4 
SELECT COUNT(a.MANV) SoNhanVien,
	   c.TENNV TruongPhong,
	   NG_NHANCHUC NgayNhanChuc,
	   CONVERT(VARCHAR, NG_NHANCHUC, 105) NgayThangNam
FROM NHANVIEN a
	 JOIN PHONGBAN b ON a.PHG = b.MAPHG
	 JOIN NHANVIEN c ON b.TRPHG = c.MANV
GROUP BY c.TENNV, NG_NHANCHUC

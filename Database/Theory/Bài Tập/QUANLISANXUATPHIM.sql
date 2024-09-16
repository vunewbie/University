--MSSV:22120439
--Ho Ten:Nguyễn Hoàng Vũ
--Thuc Hanh: Ca 2
--Tuan 3

CREATE DATABASE QuanLySanXuatPhim
GO
USE QuanLySanXuatPhim
GO

CREATE TABLE Phim (
    MaPhim CHAR(3) PRIMARY KEY,
    TenPhim NVARCHAR(30),
    DoDai INTEGER,
    NamSanXuat INTEGER,
    MaTheLoai CHAR(1),
    MaDaoDien CHAR(3)
)

CREATE TABLE DaoDien (
    MaDaoDien CHAR(3) PRIMARY KEY,
    HoTen NVARCHAR(30),
    NamSinh INTEGER,
    DiaChi NVARCHAR(30),
    Phai NVARCHAR(10)
)

CREATE TABLE TheLoai (
    MaTheLoai CHAR(1) PRIMARY KEY,
    TenTheLoai NVARCHAR(30)
)

CREATE TABLE DongPhim (
    MaPhim CHAR(3),
    MaDienVien Char(4),
    NhanVat NVARCHAR(30),
    VaiTro NVARCHAR(30),
    SoGio INTEGER,
    DonGia INTEGER
    CONSTRAINT PK_DongPhim PRIMARY KEY(MaPhim, MaDienVien)
)

CREATE TABLE DienVien (
    MaDienVien Char(4) PRIMARY KEY,
    HoTen NVARCHAR(30),
    NamSinh INTEGER,
    DiaChi NVARCHAR(30),
    Phai NVARCHAR(10),
    TheLoaiSoTruong CHAR(1)
)

ALTER TABLE Phim
ADD CONSTRAINT FK_Phim_TheLoai FOREIGN KEY(MaTheLoai)
REFERENCES TheLoai(MaTheLoai)

ALTER TABLE Phim
ADD CONSTRAINT FK_Phim_DaoDien FOREIGN KEY(MaDaoDien)
REFERENCES DaoDien(MaDaoDien)

ALTER TABLE DongPhim
ADD CONSTRAINT FK_DongPhim_Phim FOREIGN KEY(MaPhim)
REFERENCES Phim(MaPhim)

ALTER TABLE DongPhim
ADD CONSTRAINT FK_DongPhim_DienVien FOREIGN KEY(MaDienVien)
REFERENCES DienVien(MaDienVien)

ALTER TABLE DienVien
ADD CONSTRAINT FK_DienVien_TheLoai FOREIGN KEY(TheLoaiSoTruong)
REFERENCES TheLoai(MaTheLoai)

INSERT INTO DaoDien
VALUES 
    ('D01', N'Nguyễn Thanh Tùng', 1974, N'Hồ Chí Minh', 'Nam'),
    ('D02', N'Lê Nhật Nam', 1962, N'Hồ Chí Minh', N'Nữ'),
    ('D03', N'Nguyễn Thị Thanh', 1977, N'Cà Mau', N'Nữ'),
    ('D04', N'Lê Thị Lan', 1984, N'Bình Dương', N'Nữ'),
    ('D05', N'Trần Minh Quang', 1984, N'Đồng Nai', 'Nam'),
    ('D06', N'Lê Văn Hải', 1970, N'Hồ Chí Minh', 'Nam'),
    ('D07', N'Dương Văn Hai', 1988, N'Đồng Nai', 'Nam')

INSERT INTO TheLoai
VALUES
    ('X', N'Phim truyền hình'),
    ('Y', N'Phim hoạt hình'),
    ('Z', N'Phim hành động'),
    ('T', N'Phim tình cảm'),
    ('U', N'Phim trinh thám')

INSERT INTO DienVien
VALUES
    ('DV01', N'Nguyễn Thị Lan Hương', 1988, N'Hà Nội', N'Nữ', 'X'),
    ('DV02', N'Trần Nguyễn Thu Hà', 1992, N'Hồ Chí Minh', N'Nữ', 'T'),
    ('DV03', N'Lý Nhược Đồng', 1978, N'Hồ Chí Minh', N'Nữ', 'T'),
    ('DV04', N'Lý Mạnh Hùng', 1984, N'Bình Dương', 'Nam', 'Y'),
    ('DV05', N'Trần Văn Hoàng', 1977, N'Đà Nẵng', 'Nam', 'Z'),
    ('DV06', N'Phạm Thu Hiền', 1989, N'Đồng Tháp', N'Nữ', 'T'),
    ('DV07', N'Trần Băng Băng', 1991, N'Cà Mau', N'Nữ', 'T')

INSERT INTO Phim
VALUES
    ('P01', N'Bình minh trên biển', 180, 2008, 'X', 'D03'),
    ('P02', N'Anh hùng xa lộ', 120, 2009, 'Z', 'D03'),
    ('P03', N'Cuộc phiêu lưu trong rừng', 150, 2007, 'U', 'D05'),
    ('P04', N'Ở cuối chân trời', 160, 2010, 'X', 'D05'),
    ('P05', N'Chú thỏ ham ăn', 60, 2009, 'Y', 'D06')

INSERT INTO DongPhim
VALUES
    ('P01', 'DV01', N'Tuyết', N'Nữ chính', 50, 120),
    ('P01', 'DV04', N'Nam', N'Nam chính', 50, 100),
    ('P01', 'DV06', N'Lan', N'Phụ', 20, 60),
    ('P02', 'DV04', N'Mạnh', N'Nam chính', 40, 150),
    ('P02', 'DV05', N'Hồ', N'Nam chính', 60, 110),
    ('P03', 'DV05', N'Dũng', N'Nam chính', 60, 120),
    ('P04', 'DV06', N'Nga', N'Nữ chính', 50, 110),
    ('P04', 'DV05', N'Hoàng', N'Nam chính', 45, 140)

-- Câu 1
-- Cho biết tên những bộ phim được sản xuất trong khoảng thời gian từ năm 2009 đến 2010
SELECT PH.MaPhim,PH.TenPhim
FROM Phim PH
WHERE PH.NamSanXuat BETWEEN 2009 AND 2010

-- Câu 2
-- Cho biết tên những bộ phim mà có thời lượng > 120 phút
SELECT PH.MaPhim,PH.TenPhim
FROM Phim PH
WHERE PH.DoDai > 120
-- Câu 3
-- Cho biết tên bộ phim và tên đạo diễn của những bộ phim được sản xuất trong năm 2008.
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
FROM Phim PH JOIN DaoDien DD ON PH.MaDaoDien=DD.MaDaoDien
WHERE PH.NamSanXuat = 2008
-- Câu 4
-- Cho biết tên phim, tên đạo diễn và tên thể loại của phim “Bình minh trên biển”
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen,TL.MaTheLoai,TL.TenTheLoai
FROM Phim PH JOIN DaoDien DD ON PH.MaDaoDien=DD.MaDaoDien JOIN TheLoai TL ON TL.MaTheLoai=PH.MaTheLoai
WHERE PH.TenPhim LIKE N'Bình minh trên biển'
-- Câu 5
-- Cho biết mã những thể loại phim mà chưa được sản xuất lần nào.
SELECT TL.MaTheLoai
FROM TheLoai TL
WHERE TL.MaTheLoai NOT IN (SELECT PH.MaTheLoai
						   FROM Phim PH)
-- Câu 6
-- Cho biết mã và tên những thể loại phim chưa được sản xuất lần nào
SELECT TL.MaTheLoai,TL.TenTheLoai
FROM TheLoai TL
WHERE TL.MaTheLoai NOT IN (SELECT PH.MaTheLoai
						   FROM Phim PH)
-- Câu 7
-- Cho biết tên những diễn viên có địa chỉ tại thành phố “Hồ Chí Minh”
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
WHERE DV.DiaChi LIKE N'Hồ Chí Minh'
-- Câu 8
-- Cho biết tên diễn viên và tên thể loại sở trường của những diễn viên nữ
SELECT DV.MaDienVien,DV.HoTen,DV.TheLoaiSoTruong,TL.TenTheLoai
FROM DienVien DV LEFT JOIN TheLoai TL ON DV.TheLoaiSoTruong=TL.MaTheLoai
WHERE Phai = N'Nữ'
-- Câu 9
-- Cho biết tên và địa chỉ của những diễn viên và đạo diễn có năm sinh trong khoảng 1970 đến 1980.
SELECT DV.MaDienVien AS MA,DV.HoTen
FROM DienVien DV
WHERE (DV.NamSinh BETWEEN 1970 AND 1980)
UNION
SELECT DD.MaDaoDien,DD.HoTen
FROM DaoDien DD
WHERE (DD.NamSinh BETWEEN 1970 AND 1980)
-- Câu 10
-- Cho biết mã diễn viên và thu nhập từ việc đóng phim của mỗi diễn viên
SELECT DV.MaDienVien,SUM(DP.DonGia*DP.SoGio) AS LUONG
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien
-- Câu 11
-- Cho biết tên diễn viên và thu nhập từ việc đóng phim của mỗi diễn viên
SELECT DV.MaDienVien,DV.HoTen,SUM(DP.DonGia*DP.SoGio) AS LUONG
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien,DV.HoTen

-- Câu 12
-- Với mỗi diễn viên cho biết mã diễn viên và số bộ phim mà diễn viên đó đóng.
SELECT DV.MaDienVien,COUNT(DP.MaPhim) AS SOBOPHIM
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien
-- Câu 13
-- Với mỗi diễn viên, cho biết tên diễn viên mà số bộ phim mà diễn viên đó đóng
SELECT DV.MaDienVien,DV.HoTen,COUNT(DP.MaPhim) AS SOBOPHIM
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien,DV.HoTen
-- Câu 14
-- Cho biết những mã diễn viên có số lần đóng là từ 2 bộ phim trở lên
SELECT DV.MaDienVien
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien
HAVING COUNT(DP.MaPhim) >=2
-- Câu 15
-- Cho biết tên những diễn viên đã đóng từ 2 bộ phim trở lên
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien,DV.HoTen
HAVING COUNT(DP.MaPhim) >= 2
-- Câu 16 
-- Cho biết tên diễn viên và tên thể loại phim sở trường của diễn viên của những diễn viên đã đóng từ 2 bộ phim trở lên
SELECT DV.MaDienVien,DV.HoTen,DV.TheLoaiSoTruong,TL.TenTheLoai
FROM DienVien DV LEFT JOIN TheLoai TL ON DV.TheLoaiSoTruong=TL.MaTheLoai LEFT JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien
GROUP BY DV.MaDienVien,DV.HoTen,DV.TheLoaiSoTruong,TL.TenTheLoai
HAVING COUNT(DP.MaPhim) >= 2
-- Câu 17 
-- Với mỗi vai trò trong phim, cho biết đã có bao nhiêu diễn viên tham gia
SELECT DP.MaPhim,DP.VaiTro,COUNT(DP.VaiTro) AS SOLUONG
FROM DongPhim DP
GROUP BY DP.MaPhim,DP.VaiTro
-- Câu 18 
-- Với mỗi phim cho biết mã phim và số lượng diễn viên tham gia
SELECT PH.MaPhim,COUNT(DP.MaDienVien) AS SOLUONG
FROM Phim PH LEFT JOIN DongPhim DP ON PH.MaPhim=DP.MaPhim
GROUP BY PH.MaPhim
-- Câu 19 
-- Với mỗi phim cho biết tên phim, tên đạo diễn và số lượng diễn viên tham gia
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen,COUNT(DP.MaDienVien) AS SOLUONG
FROM Phim PH LEFT JOIN DongPhim DP ON PH.MaPhim=DP.MaPhim LEFT JOIN DaoDien DD ON PH.MaDaoDien=DD.MaDaoDien
GROUP BY PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
-- Câu 20
-- Cho biết mã phim có nhiều diễn viên tham gia nhất
--C1:
SELECT DP.MaPhim
FROM DongPhim DP
GROUP BY DP.MaPhim
HAVING COUNT(DP.MaDienVien) >= ALL (SELECT COUNT(DP1.MaDienVien)
									FROM DongPhim DP1
									GROUP BY DP1.MaPhim)
--C2:
SELECT DP.MaPhim
FROM DongPhim DP
EXCEPT
SELECT DP1.MaPhim
FROM DongPhim DP1
GROUP BY DP1.MaPhim
HAVING COUNT(DP1.MaDienVien) < ANY (SELECT COUNT(DP2.MaDienVien)
									FROM DongPhim DP2
									GROUP BY DP2.MaPhim)
--Câu 21
--Cho biết tên phim và tên đạo diễn mà có nhiều diễn viên tham gia nhất
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim JOIN DaoDien DD ON PH.MaDaoDien=DD.MaDaoDien
GROUP BY PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
HAVING COUNT(DP.MaDienVien) >= ALL (SELECT COUNT(DP1.MaDienVien)
									FROM DongPhim DP1
									GROUP BY DP1.MaPhim)
--Câu 22
--Cho biết tên những diễn viên không tham gia vào bộ phim "Bình minh trên biển"
--C1:EXCECPT
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
EXCEPT
SELECT DV1.MaDienVien,DV1.HoTen
FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim JOIN DienVien DV1 ON DV1.MaDienVien=DP.MaDienVien
WHERE PH.TenPhim LIKE N'Bình minh trên biển'
--C2:NOT EXISTS
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
WHERE NOT EXISTS (SELECT*
				  FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim JOIN DienVien DV1 ON DV1.MaDienVien=DP.MaDienVien
				  WHERE PH.TenPhim LIKE N'Bình minh trên biển' AND DV.MaDienVien=DV1.MaDienVien)
--Câu 23
--Cho biết những diễn viên đã từng đóng những phim có thể loại là “Phim truyền hình”
SELECT DISTINCT DV.MaDienVien,DV.HoTen
FROM DienVien DV JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien JOIN PHIM PH ON PH.MaPhim=DP.MaPhim JOIN TheLoai TL ON TL.MaTheLoai=PH.MaTheLoai
WHERE TL.TenTheLoai LIKE N'Phim truyền hình'
--Câu 24
--Cho biết tên những diễn viên chưa từng đóng phim có thể loại là “Phim truyền hình”
SELECT DISTINCT DV.MaDienVien,DV.HoTen
FROM DIENVIEN DV 
EXCEPT
SELECT DV1.MaDienVien,DV1.HoTen
FROM DienVien DV1 JOIN DongPhim DP ON DV1.MaDienVien=DP.MaDienVien JOIN PHIM PH ON PH.MaPhim=DP.MaPhim JOIN TheLoai TL ON TL.MaTheLoai=PH.MaTheLoai
WHERE TL.TenTheLoai LIKE N'Phim truyền hình'
--Câu 25
--Cho biết tên những phim mà có đạo diễn phim là một người ở “Hồ Chí Minh” và có diễn viên tham gia đóng phim cũng ở “Hồ Chí Minh”
SELECT PH.TenPhim
FROM PHIM PH JOIN DAODIEN DD ON PH.MaDaoDien=DD.MaDaoDien JOIN DONGPHIM DP ON DP.MaPhim=PH.MaPhim JOIN DIENVIEN DV ON DP.MaDienVien=DV.MaDienVien
WHERE DD.DiaChi LIKE N'Hồ Chí Minh' OR DV.DiaChi LIKE N'Hồ Chí Minh'
--Câu 26
--Cho biết những diễn viên nhỏ tuổi hơn diễn viên “Lý Mạnh Hùng”
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
WHERE DV.NamSinh > (SELECT DV2.NamSinh
					FROM DienVien DV2
					WHERE DV2.HoTen LIKE N'Lý Mạnh Hùng')
--Câu 27
--Cho biết tên diễn viên nhỏ tuổi nhất
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
WHERE DV.NamSinh >= ALL (SELECT DV1.NamSinh
						 FROM DienVien DV1)
--Câu 28
--Cho biết số lượng phim mà có độ dài từ 120 phút trở lên
SELECT COUNT(PH.MaPhim) AS SOLUONGPHIM
FROM PHIM PH
WHERE PH.DoDai>120
--Câu 29 
--Cho biết số lượng phim có thể loại phim “Phim hành động”
SELECT COUNT(PH.MaPhim) AS SOLUONGPHIM
FROM Phim PH JOIN TheLoai TL ON PH.MaTheLoai=TL.MaTheLoai
WHERE TL.TenTheLoai LIKE N'Phim hành động'
--Câu 30 
--Cho biết tên những đạo diễn và diễn viên ở “Hồ Chí Minh”
SELECT DD.MaDaoDien AS MA,DD.HoTen
FROM DaoDien DD 
WHERE DD.DiaChi LIKE N'Hồ Chí Minh'
UNION
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
WHERE DV.DiaChi LIKE N'Hồ Chí Minh'
--Câu 31 
--Cho biết tên những diễn viên mà chưa từng đóng phim.
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV
EXCEPT
SELECT DV.MaDienVien,DV.HoTen 
FROM DongPhim DP JOIN DIENVIEN DV ON DP.MaDienVien=DV.MaDienVien
--Câu 32 
--Cho biết mã phim có chi phí thuê diễn viên cao nhất.
--(câu này làm màu chứ viết >= ALL nhanh hơn :))))
SELECT DP.MaPhim
FROM DongPhim DP
GROUP BY DP.MaPhim
HAVING SUM(DP.DonGia*DP.SoGio) = (SELECT MAX(CP.CHIPHI)
								  FROM(SELECT SUM(DP.DonGia*DP.SoGio) AS CHIPHI
									   FROM DongPhim DP
									   GROUP BY DP.MaPhim) AS CP)
--Câu 33 
--Cho biết tên phim và tên đạo diễn có chi phí thuê diễn viên cao nhất.
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim JOIN DaoDien DD ON DD.MaDaoDien=PH.MaDaoDien
GROUP BY PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
HAVING SUM(DP.DonGia*DP.SoGio) >= ALL (SELECT SUM(DP1.DonGia*DP1.SoGio)
									   FROM DongPhim DP1
									   GROUP BY DP1.MaPhim)
--Câu 34 
--Cho biết tên những diễn viên có tham gia đóng phim “Bình minh trên biển”
SELECT DV.MaDienVien,DV.HoTen
FROM DienVien DV JOIN DongPhim DP ON DV.MaDienVien=DP.MaDienVien JOIN Phim PH ON PH.MaPhim=DP.MaPhim
WHERE PH.TenPhim LIKE N'Bình minh trên biển'
--Câu 35 
--Cho biết tên phim mà có chi phí đóng phi cao nhất.
SELECT PH.MaPhim,PH.TenPhim
FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim
GROUP BY PH.MaPhim,PH.TenPhim
HAVING SUM(DP.DonGia*DP.SoGio) >= ALL (SELECT SUM(DP1.DonGia*DP1.SoGio)
									   FROM DongPhim DP1
									   GROUP BY DP1.MaPhim)
--Câu 36 
--Cho biết tên phim mà có chi phí thuê diễn viên cao hơn chi phí thuê diễn viên của bộ phim “Ở cuối chân trời”
SELECT PH.MaPhim,PH.TenPhim
FROM DongPhim DP JOIN Phim PH ON DP.MaPhim=PH.MaPhim
GROUP BY PH.MaPhim,PH.TenPhim
HAVING SUM(DP.DonGia*DP.SoGio) > (SELECT SUM(DP1.DonGia*DP1.SoGio)
								  FROM DongPhim DP1 JOIN PHIM PH1 ON PH1.MaPhim=DP1.MaPhim
								  WHERE PH1.TenPhim LIKE N'Ở cuối chân trời'
								  GROUP BY DP1.MaPhim)
--Câu 37 
--Với mỗi tỉnh thành cho biết tỉnh thành đó có bao nhiêu diễn viên.
SELECT DV.DiaChi,COUNT(DV.MaDienVien) SODIENVIEN
FROM DienVien DV
GROUP BY DV.DiaChi
--Câu 38 
--Với mỗi tỉnh thành có hơn 2 diễn viên, cho biết số lượng diễn viên của tỉnh thành đó.
SELECT DV.DiaChi,COUNT(DV.MaDienVien)
FROM DienVien DV
GROUP BY DV.DiaChi
HAVING COUNT(DV.MaDienVien) > 2
--Câu 39 
--Tìm tên những phim mà có thời lượng lớn hơn thời lượng của phim “Cuộc phiêu lưu trong rừng”
SELECT PH.MaPhim,PH.TenPhim
FROM PHIM PH
WHERE PH.DoDai > (SELECT PH1.DoDai
				  FROM Phim PH1
				  WHERE PH1.TenPhim LIKE N'Cuộc phiêu lưu trong rừng')
--Câu 40 
--Tìm tên những phim và tên đạo diễn của phim mà có thời lượng lớn hơn thời lượng của phim “Cuộc phiêu lưu trong rừng”
SELECT PH.MaPhim,PH.TenPhim,DD.MaDaoDien,DD.HoTen
FROM Phim PH JOIN DaoDien DD ON PH.MaDaoDien=DD.MaDaoDien
WHERE PH.DoDai > (SELECT PH1.DoDai
				  FROM Phim PH1
				  WHERE PH1.TenPhim LIKE N'Cuộc phiêu lưu trong rừng')
--Câu 41 
--Cho biết tên những những bộ phim được sản xuất sớm nhất.
SELECT PH.MaPhim,PH.TenPhim,PH.NamSanXuat
FROM PHIM PH
ORDER BY PH.NamSanXuat ASC
--Câu 41 
--Cho biết tên phim mà có diễn viên tham gia phim ở tại “Hồ Chí Minh”
SELECT PH.TenPhim
FROM Phim PH JOIN DongPhim DP ON PH.MaPhim=DP.MaPhim JOIN DienVien DV ON DP.MaDienVien=DV.MaDienVien
WHERE DV.DiaChi LIKE N'Hồ Chí Minh'
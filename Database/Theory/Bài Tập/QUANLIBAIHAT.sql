--YÊU CẦU 1: TẠO CSDL
--1.Tạo bảng và tạo ràng buộc khóa chính cho các bảng trên
CREATE DATABASE QUANLYBAIHAT
GO

USE QUANLYBAIHAT
GO

CREATE TABLE BAIHAT(
	IDTheLoai CHAR(10),
	IDBaiHat CHAR(10),
	TenBaiHat NVARCHAR(30),
	IDTacGia INT
	PRIMARY KEY (IDTheLoai,IDBaiHat)
)

CREATE TABLE THELOAI(
	IDTheLoai CHAR(10),
	TenTheLoai NVARCHAR(30),
	IDBaiHatTieuBieu CHAR(10),
	IDTheLoaiCha CHAR(10)
	PRIMARY KEY(IDTheLoai)
)

CREATE TABLE TACGIA(
	IDTacGia INT,
	HoTen NVARCHAR(30),
	IDTheLoaiSoTruongNhat CHAR(10),
	IDBaiHatTieuBieuNhat CHAR(10)
	PRIMARY KEY(IDTacGia)
)
--2.Tạo ràng buộc khóa ngoại cho các bảng trên
--BAIHAT REF THELOAI
ALTER TABLE BAIHAT
ADD CONSTRAINT FK_BH_TL FOREIGN KEY (IDTheLoai) REFERENCES THELOAI (IDTheLoai) 
--BAIHAT REF TACGIA
ALTER TABLE BAIHAT
ADD CONSTRAINT FK_BH_TG FOREIGN KEY (IDTacGia) REFERENCES TACGIA (IDTacGia)
--THELOAI REF BAIHAT
ALTER TABLE THELOAI
ADD CONSTRAINT FK_TL_BH FOREIGN KEY (IDTheLoai,IDBaiHatTieuBieu) REFERENCES BAIHAT (IDTheLoai,IDBaiHat)
--THELOAI REF THELOAI
ALTER TABLE THELOAI
ADD CONSTRAINT FK_TL_TL FOREIGN KEY (IDTheLoaiCha) REFERENCES THELOAI (IDTheLoai)
--TACGIA REF BAIHAT
ALTER TABLE TACGIA
ADD CONSTRAINT FK_TG_BH FOREIGN KEY (IDTheLoaiSoTruongNhat,IDBaiHatTieuBieuNhat) REFERENCES BAIHAT (IDTheLoai,IDBaiHat)
--3.Nhập các dòng dữ liệu sau vào các bảng tương ứng.
INSERT INTO THELOAI VALUES ('TL01',N'Nhạc trữ tình',NULL,NULL),
						   ('TL02',N'Nhạc cách mạng',NULL,NULL),
						   ('TL00',N'Nhạc Việt Nam',NULL,NULL)
INSERT INTO BAIHAT VALUES ('TL01','BH01',N'Ngẫu hứng lý qua cầu',NULL),
						  ('TL01','BH02',N'Chuyến đò quê hương',NULL),
						  ('TL02','BH01',N'Du kích sông Thao',NULL),
						  ('TL02','BH02',N'Sợi nhớ sợi thương',NULL)
INSERT INTO TACGIA VALUES (1,N'Trần Tiến','TL01','BH01'),
						  (2,N'Đỗ Nhuận','TL02','BH01'),
						  (3,N'Phan Huỳnh Điểu','TL02','BH02'),
						  (4,N'Vi Nhật Tảo','TL01','BH02')
UPDATE THELOAI
SET IDBaiHatTieuBieu = 'BH01'
WHERE IDTheLoai = 'TL01'
UPDATE THELOAI
SET IDBaiHatTieuBieu = 'BH02'
WHERE IDTheLoai = 'TL02'
UPDATE THELOAI
SET IDTheLoaiCha = 'TL00'
WHERE IDTheLoai = 'TL01' OR IDTheLoai = 'TL02'
UPDATE BAIHAT
SET IDTacGia = 1
WHERE IDTheLoai = 'TL01' AND IDBaiHat = 'BH01'
UPDATE BAIHAT
SET IDTacGia = 4
WHERE IDTheLoai = 'TL01' AND IDBaiHat = 'BH02'
UPDATE BAIHAT
SET IDTacGia = 2
WHERE IDTheLoai = 'TL02' AND IDBaiHat = 'BH01'
UPDATE BAIHAT
SET IDTacGia = 3
WHERE IDTheLoai = 'TL02' AND IDBaiHat = 'BH02'
--YÊU CẦU 2:TRUY VẤN
--1.Cho danh sách bài hát thuộc thể loại “nhạc trữ tình” của tác giả Đỗ Nhuận
SELECT BH.*
FROM BAIHAT BH JOIN THELOAI TL ON BH.IDTheLoai=TL.IDTheLoai JOIN TACGIA TG ON BH.IDTacGia=TG.IDTacGia
WHERE TL.TenTheLoai LIKE N'%Nhạc trữ tình%' AND TG.HoTen LIKE N'%Đỗ Nhuận'
--2.Cho danh sách các thể loại chưa có bài hát nào trong thể loại đó
SELECT TL.*
FROM THELOAI TL
EXCEPT
SELECT TL1.*
FROM THELOAI TL1 JOIN BAIHAT BH ON TL1.IDTheLoai=BH.IDTheLoai
--3.Cho danh sách tác giả (mã, họ tên, số bài hát) của mỗi tác giả.
SELECT TG.IDTacGia,TG.HoTen,COUNT(BH.IDBaiHat) AS SoBaiHat
FROM TACGIA TG LEFT JOIN BAIHAT BH ON TG.IDTacGia=BH.IDTacGia
GROUP BY TG.IDTacGia,TG.HoTen
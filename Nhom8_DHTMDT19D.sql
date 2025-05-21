create database QLBV
on primary (name = QLBvien_data, filename = 'C:\QLBV\QLBvien_Data.mdf', size = 100, maxsize = 1000, filegrowth =1)
log on (name = QLBvien_log, filename = 'C:\QLBV\QLBvien_Log.ldf', size = 105, maxsize = 1055, filegrowth =1)

use QLBV

-- Bảng KhuChuaTri
CREATE TABLE KhuChuaTri (
SoKhu INT PRIMARY KEY,
TenKhu VARCHAR(100) NOT NULL,
MaYTaTruong INT UNIQUE NULL)

-- Bảng NhanVien
CREATE TABLE NhanVien (
MaNhanVien INT PRIMARY KEY,
TenNhanVien VARCHAR(150) NOT NULL)

-- Thêm ràng buộc khóa ngoại cho MaYTaTruong trong KhuChuaTri sau khi bảng NhanVien tồn tại
ALTER TABLE KhuChuaTri
ADD CONSTRAINT FK_KhuChuaTri_NhanVien
FOREIGN KEY (MaYTaTruong) REFERENCES NhanVien(MaNhanVien)

-- Bảng BacSi
CREATE TABLE BacSi (
MaBacSi INT PRIMARY KEY,
TenBacSi VARCHAR(150) NOT NULL)

-- Bảng BenhNhan
CREATE TABLE BenhNhan (
MaBenhNhan INT PRIMARY KEY,
TenBenhNhan VARCHAR(150) NOT NULL,
NgaySinh DATE,
LoaiBenhNhan VARCHAR(50) CHECK (LoaiBenhNhan IN ('Noi tru', 'Ngoai tru')),
MaBacSi INT NULL,
CONSTRAINT FK_BenhNhan_BacSi FOREIGN KEY (MaBacSi) REFERENCES BacSi(MaBacSi))

-- Bảng GiuongBenh
CREATE TABLE GiuongBenh (
SoGiuong VARCHAR(10), 
SoPhong VARCHAR(10),
SoKhu INT,
MaBenhNhan INT UNIQUE NULL, 
PRIMARY KEY (SoGiuong, SoPhong, SoKhu), 
CONSTRAINT FK_GiuongBenh_KhuChuaTri FOREIGN KEY (SoKhu) REFERENCES KhuChuaTri(SoKhu),
CONSTRAINT FK_GiuongBenh_BenhNhan FOREIGN KEY (MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan))


-- Bảng VatTuYTe
CREATE TABLE VatTuYTe (
MaVatTu VARCHAR(50) PRIMARY KEY,
DacTa TEXT,
DonGia DECIMAL(10, 2) NOT NULL)

-- Bảng SuChuaTri
CREATE TABLE SuChuaTri (
MaSuChuaTri VARCHAR(50) PRIMARY KEY, 
TenSuChuaTri VARCHAR(150) NOT NULL)

-- Bảng ChiTietChuaTri 
CREATE TABLE ChiTietChuaTri (
MaLanChuaTri INT PRIMARY KEY, 
MaBenhNhan INT NOT NULL,
MaBacSi INT NOT NULL,
MaSuChuaTri VARCHAR(50) NOT NULL,
NgayChuaTri DATE NOT NULL,
ThoiGianChuaTri TIME NOT NULL,
KetQuaChuaTri TEXT,
CONSTRAINT FK_ChiTietChuaTri_BenhNhan FOREIGN KEY (MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan),
CONSTRAINT FK_ChiTietChuaTri_BacSi FOREIGN KEY (MaBacSi) REFERENCES BacSi(MaBacSi),
CONSTRAINT FK_ChiTietChuaTri_SuChuaTri FOREIGN KEY (MaSuChuaTri) REFERENCES SuChuaTri(MaSuChuaTri))

-- Bảng PhanCongLamViec 
CREATE TABLE PhanCongLamViec (
MaNhanVien INT,
SoKhu INT ,
SoGioLamViecTuan INT NOT NULL CHECK (SoGioLamViecTuan >= 0),
PRIMARY KEY (MaNhanVien, SoKhu),
CONSTRAINT FK_PhanCongLamViec_NhanVien FOREIGN KEY (MaNhanVien) REFERENCES NhanVien(MaNhanVien),
CONSTRAINT FK_PhanCongLamViec_KhuChuaTri FOREIGN KEY (SoKhu) REFERENCES KhuChuaTri(SoKhu))

-- Bảng SuDungVatTu
CREATE TABLE SuDungVatTu (
MaLanSuDungVatTu INT PRIMARY KEY , 
MaBenhNhan INT NOT NULL,
MaVatTu VARCHAR(50) NOT NULL,
NgaySuDung DATE NOT NULL,
ThoiGianSuDung TIME NOT NULL,
SoLuong INT NOT NULL CHECK (SoLuong > 0), 
CONSTRAINT FK_SuDungVatTu_BenhNhan FOREIGN KEY (MaBenhNhan) REFERENCES BenhNhan(MaBenhNhan),
CONSTRAINT FK_SuDungVatTu_VatTuYTe FOREIGN KEY (MaVatTu) REFERENCES VatTuYTe(MaVatTu))

-- Nhập dữ liệu cho bảng 
INSERT INTO NhanVien (MaNhanVien, TenNhanVien) VALUES
(101, 'Nguyễn Thị Minh An'),
(102, 'Trần Văn Bình'),
(103, 'Lê Thị Thu Cúc'),
(104, 'Phạm Minh Đức'),
(105, 'Hoàng Anh Giang')


INSERT INTO BacSi (MaBacSi, TenBacSi) VALUES
(201, 'Nguyễn Hữu An'),
(202, 'Trần Thị Bích'),
(203, 'Lê Văn Cường'),
(204, 'Phạm Thị Dung'),
(205, 'Hoàng Minh Hải')

INSERT INTO KhuChuaTri (SoKhu, TenKhu, MaYTaTruong) VALUES
(1, 'Khoa Nội Tổng Hợp', 101),
(2, 'Khoa Ngoại Chấn Thương', 102),
(3, 'Khoa Hồi Sức Cấp Cứu', NULL),
(4, 'Khoa Nhi', 103),
(5, 'Khoa Sản', 104)


INSERT INTO BenhNhan (MaBenhNhan, TenBenhNhan, NgaySinh, LoaiBenhNhan, MaBacSi) VALUES
(301, 'Ngô Thị Thanh Hằng', '1990-05-15', 'Noi tru', 201),
(302, 'Đinh Văn Khoa', '1985-11-20', 'Ngoai tru', 202),
(303, 'Bùi Thị Loan', '2000-01-01', 'Noi tru', 201),
(304, 'Trịnh Minh Nam', '1978-07-07', 'Ngoai tru', 203), 
(305, 'Phan Thị Quyên', '1995-03-25', 'Noi tru', 204)

INSERT INTO GiuongBenh (SoGiuong, SoPhong, SoKhu, MaBenhNhan) VALUES
('G101', 'P10', 1, 301), 
('G102', 'P10', 1, 303),
('G201', 'P20', 2, NULL), 
('G401', 'P40', 4, 305),
('G501', 'P50', 5, 304)

INSERT INTO VatTuYTe (MaVatTu, DacTa, DonGia) VALUES
('VT001', 'Gạc y tế vô trùng', 15000.00),
('VT002', 'Bông y tế', 10000.00),
('VT003', 'Thuốc A (Paracetamol)', 50000.00),
('VT004', 'Kim tiêm 3ml', 5000.00),
('VT005', 'Dây truyền dịch', 25000.00)

INSERT INTO SuChuaTri (MaSuChuaTri, TenSuChuaTri) VALUES
('ST001', 'Khám tổng quát'),
('ST002', 'Tiêm thuốc'),
('ST003', 'Thay băng'),
('ST004', 'Xét nghiệm máu'),
('ST005', 'Siêu âm')

INSERT INTO ChiTietChuaTri (MaLanChuaTri, MaBenhNhan, MaBacSi, MaSuChuaTri, NgayChuaTri, ThoiGianChuaTri, KetQuaChuaTri) VALUES
(1, 301, 201, 'ST001', '2023-10-26', '09:00:00', 'Tình trạng ổn định'),
(2, 302, 202, 'ST004', '2023-10-26', '10:30:00', 'Kết quả bình thường'),
(3, 303, 201, 'ST002', '2023-10-26', '11:00:00', 'Đã tiêm đủ liều'),
(4, 301, 201, 'ST003', '2023-10-27', '08:00:00', 'Vết thương khô ráo'),
(5, 305, 204, 'ST005', '2023-10-27', '14:00:00', 'Không phát hiện bất thường')

INSERT INTO PhanCongLamViec (MaNhanVien, SoKhu, SoGioLamViecTuan) VALUES
(101, 1, 40),
(102, 2, 40),
(103, 4, 35),
(104, 5, 38),
(105, 1, 20)

INSERT INTO SuDungVatTu (MaLanSuDungVatTu, MaBenhNhan, MaVatTu, NgaySuDung, ThoiGianSuDung, SoLuong) VALUES
(1, 301, 'VT001', '2023-10-26', '09:15:00', 2),
(2, 303, 'VT004', '2023-10-26', '11:05:00', 1),
(3, 301, 'VT003', '2023-10-26', '15:00:00', 1),
(4, 305, 'VT002', '2023-10-27', '07:30:00', 3),
(5, 303, 'VT005', '2023-10-27', '09:00:00', 1)


---Câu hỏi truy vấn: 2 câu group by + 2 câu update + 2 câu delete + 2 câu sub query + 2 câu kết nối truy vấn nhiều bảng và giải đáp bằng lệnh + 2 câu bất kỳ

--- 2 câu Group by
--Cho biết số lượng bệnh nhân mà mỗi bác sĩ đã chữa trị, bao gồm họ và tên bác sĩ và sắp xếp kết quả theo số bệnh nhân từ cao đến thấp
select bs.MaBacSi, bs.TenBacSi, count(distinct(ct.MaBenhNhan)) as Soluongbenhnhan
from BacSi bs
join chitietchuatri ct on ct.MaBacSi = bs.MaBacSi
group by bs.MaBacSi, bs.TenBacSi
order by Soluongbenhnhan desc

--Cho biết số lượng giường bệnh trong mỗi khu chữa trị, gồm tên khu, và chỉ liệt kê những khu có từ 1 giường trở lên
select kct.TenKhu, count(*) as Soluonggiuong
from KhuChuaTri kct
join GiuongBenh gb on gb.SoKhu = kct.SoKhu
group by kct.TenKhu
having  count(*) >=1

---2 câu sub query
--Tìm tên các nhân viên đồng thời là y tá trưởng của ít nhất một khu nào đó.
select TenNhanVien
from NhanVien 
where MaNhanVien in(
select Maytatruong
from KhuChuaTri
where MaYTaTruong is not null)

--Tìm tên các bệnh nhân đã sử dụng vật tư y tế có mã 'VT002'.
select TenBenhNhan
from BenhNhan
where MaBenhNhan IN (
select MaBenhNhan
from SuDungVatTu
where MaVatTu = 'VT002')


---2 câu bất kỳ
--Liệt kê thông tin các giường bệnh hiện đang có bệnh nhân nằm, bao gồm số giường, số phòng, số khu và tên của bệnh nhân đang nằm trên giường đó
select gb.SoGiuong, gb.SoPhong, gb.SoKhu, bn.TenBenhNhan 
from GiuongBenh gb 
JOIN BenhNhan bn ON gb.MaBenhNhan = bn.MaBenhNhan

--Cho biết mỗi bác sĩ đã thực hiện bao nhiêu lần chữa trị  và sắp xếp số lần chữa trị giảm dần
select bs.MaBacSi, bs.TenBacSi, COUNT(*) AS SoLanChuaTri 
from bacsi bs 
join ChiTietChuaTri ctt on bs.MaBacSi = ctt.MaBacSi 
group by bs.MaBacSi, bs.TenBacSi 
order by SoLanChuaTri desc


---2 câu truy vấn kết nối nhiều bảng
-- Liệt kê tên nhân viên, tên khu chữa trị mà họ làm việc và số giờ làm việc hàng tuần tại khu đó.
select nv.TenNhanVien,kct.TenKhu,pclv.SoGioLamViecTuan
from NhanVien nv
join PhanCongLamViec pclv on nv.MaNhanVien = pclv.MaNhanVien
join KhuChuaTri kct on pclv.SoKhu = kct.SoKhu

-- Liệt kê mã lần chữa trị, ngày giờ thực hiện, tên của bệnh nhân đã được chữa trị và tên của bác sĩ đã thực hiện lần chữa trị đó và 
-- sắp xếp ngày chữa trị giảm dần

select ctt.MaLanChuaTri,bn.TenBenhNhan,bs.TenBacSi,ctt.NgayChuaTri,ctt.ThoiGianChuaTri  
from ChiTietChuaTri ctt 
join BenhNhan bn ON ctt.MaBenhNhan = bn.MaBenhNhan 
join BacSi bs ON ctt.MaBacSi = bs.MaBacSi
ORDER BY ctt.NgayChuaTri DESC

---2 câu UPDATE:
--Cập nhật đơn giá của vật tư y tế có mã 'VT001' thành 120,000.00
update VatTuYTe
set DonGia = 120000.00
where MaVatTu = 'VT001'

--Cập nhật loại bệnh nhân của bệnh nhân có mã 205 thành 'Ngoai tru' (Giả sử bệnh nhân này đang là 'Noi tru' và cần chuyển)
update BenhNhan
set LoaiBenhNhan = 'Ngoai tru'
where MaBenhNhan = 205

---2 câu DELETE:
--Xóa thông tin phân công làm việc của nhân viên có mã 103 tại khu có số 4
Delete from PhanCongLamViec
where MaNhanVien = 103 and SoKhu = 8

--Xóa giường chưa có bệnh nhân nào nằm
DELETE FROM GiuongBenh
WHERE MaBenhNhan IS NULL



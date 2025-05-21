create database QLBV
on primary (name = QLBvien_data, filename = 'C:\QLBV\QLBvien_Data.mdf', size = 100, maxsize = 1000, filegrowth =1)
log on (name = QLBvien_log, filename = 'C:\QLBV\QLBvien_Log.ldf', size = 105, maxsize = 1055, filegrowth =1)

use QLBV

--Tạo bảng 
create table BENHNHAN(
MABN int primary key,
TENBN nvarchar(50),
LOAIBN nvarchar(50),
NGAYSINH Datetime)

create table BACSI(
MABS int primary key,
TENBS nvarchar(50),
NGAYSINH Datetime,
SDT int )

create table KHUCHUATRI(
MAKHU int primary key,
TENKHU nvarchar(50),
MATRUONGKHU int,
TENTRUONGKHU nvarchar(50))

create table GIUONG(
MAGIUONG int primary key,
SOPHONG int,
MAKHU int)

create table THUOC(
MATHUOC int primary key,
TENTHUOC nvarchar(50),
DVT nvarchar(20),
DONGIA int)

create table SUDUNGTHUOC(
MATHUOC int not null,
MABN int not null,
DVT nvarchar(20),
DONGIA int)

create table NHANVIEN(
MANV int primary key,
HOTEN nvarchar(50),
NGAYSINH Datetime,
SDT int)

create table SUCHUATRI(
MASCT int primary key,
TENSCT nvarchar(70))

create table CTCHUATRI(
MASCT int not null,
MABS int not null,
MABN int not null,
NGAY Datetime,
GIO Time)

create table LAMVIEC(
MANV int not null,
MAKHU int not null,
SOGIO int)

create table THEODOI(
MABS int not null,
MABN int not null)

create table DUNGCU(
MADC int primary key,
TENDC nvarchar(50),
DVT nvarchar(20),
DONGIA int)

create table SUDUNG(
MADC int not null,
MABN int not null,
NGAY Datetime,
GIO Time,
SOLUONG nvarchar(20))

create table DIEUTRI(
MABN int not null,
MAGIUONG int not null,
NGAYBATDAU Datetime,
NGAYKT Datetime)

--ràng buộc khóa chính 
alter table SUDUNGTHUOC
add constraint pk_SUDUNGTHUOC primary key (MATHUOC, MABN)

alter table CTCHUATRI
add constraint pk_CTCHUATRI primary key (MASCT, MABS, MABN)

alter table LAMVIEC
add constraint pk_LAMVIEC primary key (MANV, MAKHU)

alter table THEODOI
add constraint pk_THEODOI primary key (MABS, MABN)

alter table SUDUNG
add constraint pk_SUDUNG primary key (MADC, MABN)

alter table DIEUTRI
add constraint pk_DIEUTRI primary key (MABN, MAGIUONG)

--liên kết khóa ngoại
alter table GIUONG add constraint fk_GIUONG_KHUCHUATRI foreign key (MAKHU) references KHUCHUATRI(MAKHU)

alter table SUDUNGTHUOC add constraint fk_SDT_THUOC foreign key (MATHUOC) references THUOC(MATHUOC)

alter table SUDUNGTHUOC add constraint fk_SDT_BENHNHAN foreign key (MABN) references BENHNHAN(MABN)

alter table CTCHUATRI add constraint fk_CTCHUATRI_SCT foreign key (MASCT) references SUCHUATRI(MASCT)

alter table CTCHUATRI add constraint fk_CTCHUATRI_BACSI foreign key (MABS) references BACSI(MABS)

alter table CTCHUATRI add constraint fk_CTCHUATRI_BENHNHAN foreign key (MABN) references BENHNHAN(MABN)

alter table LAMVIEC add constraint fk_LAMVIEC_NHANVIEN foreign key (MANV) references NHANVIEN(MANV)

alter table LAMVIEC add constraint fk_LAMVIEC_KHUCHUATRI foreign key (MAKHU) references KHUCHUATRI(MAKHU)

alter table THEODOI add constraint fk_THEODOI_BACSI foreign key (MABS) references BACSI(MABS)

alter table THEODOI add constraint fk_THEODOI_BENHNHAN foreign key (MABN) references BENHNHAN(MABN)

alter table SUDUNG add constraint fk_SUDUNG_DUNGCU foreign key (MADC) references DUNGCU(MADC)

alter table SUDUNG add constraint fk_SUDUNG_BENHNHAN foreign key (MABN) references BENHNHAN(MABN)

alter table DIEUTRI add constraint fk_DIEUTRI_BENHNHAN foreign key (MABN) references BENHNHAN(MABN)

alter table DIEUTRI add constraint fk_DIEUTRI_GIUONG foreign key (MAGIUONG) references GIUONG(MAGIUONG)

--Nhập dữ liệu

-- Bảng BENHNHAN
insert into BENHNHAN values (1, 'Nguyen Van An', 'Noi tru', '1990-01-01')
insert into BENHNHAN values (2, 'Tran Thi Binh', 'Ngoai tru', '1985-06-15')
insert into BENHNHAN values (3, 'Le Van Cao', 'Noi tru', '1970-12-12')
insert into BENHNHAN values (4, 'Pham Thi Dung', 'Ngoai tru', '2000-03-10')
insert into BENHNHAN values (5, 'Do Van Uyen', 'Noi tru', '1995-08-22')

-- Bảng BACSI
insert into BACSI values (1, 'Do Hai Long', '1975-09-09', 123456789)
insert into BACSI values (2, 'Nguyen Van Bao', '1980-10-10', 234567891)
insert into BACSI values (3, 'Le Trung Kien', '1985-11-11', 345678912)
insert into BACSI values (4, 'Nguyen Thi Hoa', '1990-12-12', 456789123)
insert into BACSI values (5, 'dinh Van Yen', '1995-01-01', 567891234)

-- Bảng NHANVIEN
insert into NHANVIEN values (1, 'Cao Van Hoa', '1980-01-01', 111111111)
insert into NHANVIEN values (2, 'Phung Thanh Do', '1981-02-02', 222222222)
insert into NHANVIEN values (3, 'Nguyen Bao An', '1982-03-03', 333333333)
insert into NHANVIEN values (4, 'Do Hai Dung', '1983-04-04', 444444444)
insert into NHANVIEN values (5, 'Nguyen Ngoc Kieu', '1984-05-05', 555555555)

-- Bảng KHUCHUATRI
insert into KHUCHUATRI values (1, 'Khu A', 1, 'Le Hai Nam')
insert into KHUCHUATRI values (2, 'Khu B', 2, 'Do Ngoc Hai')
insert into KHUCHUATRI values (3, 'Khu C', 3, 'Lang Thanh Truc')
insert into KHUCHUATRI values (4, 'Khu D', 4, 'Nguyen Van An')
insert into KHUCHUATRI values (5, 'Khu E', 5, 'Chu Van Lam')

-- Bảng GIUONG
insert into GIUONG values (1, 101, 1)
insert into GIUONG values (2, 102, 1)
insert into GIUONG values (3, 201, 2)
insert into GIUONG values (4, 202, 2)
insert into GIUONG values (5, 301, 3)

-- Bảng THUOC
insert into THUOC values (1, 'Paracetamol', 'vien', 5000)
insert into THUOC values (2, 'Amoxicillin', 'vien', 10000)
insert into THUOC values (3, 'Vitamin C', 'vien', 3000)
insert into THUOC values (4, 'Ibuprofen', 'vien', 8000)
insert into THUOC values (5, 'Omeprazole', 'vien', 12000)

-- Bảng SUDUNGTHUOC
insert into SUDUNGTHUOC values (1, 1, 'vien', 5000)
insert into SUDUNGTHUOC values (2, 2, 'vien', 10000)
insert into SUDUNGTHUOC values (3, 3, 'vien', 3000)
insert into SUDUNGTHUOC values (4, 4, 'vien', 8000)
insert into SUDUNGTHUOC values (5, 5, 'vien', 12000)

-- Bảng SUCHUATRI
insert into SUCHUATRI values (1, 'Xet nghiem mau')
insert into SUCHUATRI values (2, 'Chup X-quang')
insert into SUCHUATRI values (3, 'Kham tong quat')
insert into SUCHUATRI values (4, 'Do huyet ap')
insert into SUCHUATRI values (5, 'Sieu am')

-- Bảng CTCHUATRI
insert into CTCHUATRI values (1, 1, 1, '2024-05-01', '08:00')
insert into CTCHUATRI values (2, 2, 2, '2024-05-02', '09:00')
insert into CTCHUATRI values (3, 3, 3, '2024-05-03', '10:00')
insert into CTCHUATRI values (4, 4, 4, '2024-05-04', '11:00')
insert into CTCHUATRI values (5, 5, 5, '2024-05-05', '14:00')

-- Bảng LAMVIEC
insert into LAMVIEC values (1, 1, 40)
insert into LAMVIEC values (2, 2, 38)
insert into LAMVIEC values (3, 3, 36)
insert into LAMVIEC values (4, 4, 42)
insert into LAMVIEC values (5, 5, 39)

-- Bảng THEODOI
insert into THEODOI values (1, 1)
insert into THEODOI values (2, 2)
insert into THEODOI values (3, 3)
insert into THEODOI values (4, 4)
insert into THEODOI values (5, 5)

-- Bảng DUNGCU
insert into DUNGCU values (1, 'May do huyet ap', 'cai', 300000)
insert into DUNGCU values (2, 'Cam nang y te', 'quyen', 50000)
insert into DUNGCU values (3, 'Ong nghe', 'cai', 200000)
insert into DUNGCU values (4, 'Bo kim tiem', 'bo', 150000)
insert into DUNGCU values (5, 'Bang cao', 'cai', 10000)

-- Bảng SUDUNG
insert into SUDUNG values (1, 1, '2024-05-01', '08:00', '1')
insert into SUDUNG values (2, 2, '2024-05-02', '09:00', '2')
insert into SUDUNG values (3, 3, '2024-05-03', '10:00', '1')
insert into SUDUNG values (4, 4, '2024-05-04', '11:00', '3')
insert into SUDUNG values (5, 5, '2024-05-05', '14:00', '2')

-- Bảng DIEUTRI
insert into DIEUTRI values (1, 1, '2024-04-20', '2024-04-25')
insert into DIEUTRI values (2, 2, '2024-04-22', '2024-04-26')
insert into DIEUTRI values (3, 3, '2024-04-23', '2024-04-28')
insert into DIEUTRI values (4, 4, '2024-04-24', '2024-04-30')
insert into DIEUTRI values (5, 5, '2024-04-25', '2024-05-01')

----2 câu group by,  2 câu sub query, 2 câu bất kì
----2 câu group by

--Cho biết số lượng bệnh nhân mà mỗi bác sĩ đã chữa trị,bao gồm  họ và tên bác sĩ
--, và sắp xếp kết quả theo số bệnh nhân từ cao đến thấp

select bs.MABS, bs.TENBS, count(distinct ct.MABN) as sobenhnhan
from BACSI bs
join CTCHUATRI ct on bs.MABS = ct.MABS
group by bs.MABS, bs.TENBS
order by sobenhnhan desc

--Cho biết số lượng giường bệnh trong mỗi khu chữa trị, gồm tên khu, 
--và chỉ liệt kê những khu có từ 1 giường trở lên
select kct.MAKHU, kct.TENKHU, count(g.magiuong) as sogiuong
from KHUCHUATRI kct
join GIUONG g on g.MAKHU = kct.MAKHU
group by kct.MAKHU, kct.TENKHU
having count(g.magiuong) >1

----2 câu sub query
--Liệt kê tên bác sĩ đã từng chữa trị cho bệnh nhân có tên là "Nguyen Van A".
select TENBS
from BACSI 
where MABS in(
select MABS
from CTCHUATRI
where MABN in(
select MABN
from BENHNHAN
where TENBN = 'Nguyen Van An'))

--Liệt kê tên những bệnh nhân đã được chữa trị bằng thuốc có đơn giá cao nhất
--trong danh sách thuốc.
select distinct bn.MABN
from BENHNHAN bn
where MABN in(
select MABN
from SUDUNGTHUOC
where MATHUOC in(
select MATHUOC
from THUOC
where DONGIA = (select max(dongia)from THUOC)))


----2 câu bất kỳ

--Liệt kê tên các bác sĩ và tổng số loại thuốc khác nhau mà bác sĩ đó đã kê cho bệnh nhân, sắp xếp giảm dần theo tổng số loại thuốc
select bs.TENBS, count(distinct(t.mathuoc)) as tongsothuoc
from BACSI bs
join CTCHUATRI ct on ct.MABS = bs.MABS
join SUDUNGTHUOC sdt on sdt.MABN = ct.MABN
join THUOC t on t.MATHUOC = sdt.MATHUOC
group by bs.TENBS
order by count(distinct(t.mathuoc)) desc


--Cho biết mỗi bác sĩ đã thực hiện bao nhiêu lần chữa trị và sắp xếp số lần chữa
--trị giảm dần
select bs.MABS, bs.TENBS, count(distinct(ct.mabn)) as solanchuatri
from BACSI bs
join CTCHUATRI ct on ct.MABS = bs.MABS
group by bs.MABS, bs.TENBS
having count(distinct ct.mabn) >= 2
order by solanchuatri desc


--2 câu truy vấn kết nối nhiều bảng:

-- Liệt kê tên bệnh nhân nội trú và số giường bệnh họ đang nằm (nếu có)
SELECT bn.TENBN, g.MAGIUONG, g.SOPHONG, kct.TENKHU
FROM BENHNHAN bn
JOIN DIEUTRI dt ON bn.MABN = dt.MABN
JOIN GIUONG g ON dt.MAGIUONG = g.MAGIUONG
JOIN KHUCHUATRI kct ON g.MAKHU = kct.MAKHU
WHERE bn.LOAIBN = N'nội trú';

-- Hiển thị tên bác sĩ và số lần thực hiện các chữa trị
SELECT bs.TENBS, sct.TENSCT, COUNT(*) AS SOLANTHUCTHI
FROM BACSI bs
JOIN CTCHUATRI ct ON bs.MABS = ct.MABS
JOIN SUCHUATRI sct ON ct.MASCT = sct.MASCT
GROUP BY bs.TENBS, sct.TENSCT
ORDER BY bs.TENBS, sct.TENSCT

--2 câu UPDATE:

-- Cập nhật số phòng giường có MAGIUONG = 10 và MAKHU = 1 thành 11
UPDATE GIUONG
SET SOPHONG = 11
WHERE MAGIUONG = 10 AND SOPHONG = 101 AND MAKHU = 1

-- Giả sử có cột KETQUA trong bảng CTCHUATRI
alter table CTCHUATRI add KETQUA nvarchar(50)
UPDATE CTCHUATRI
SET KETQUA = N'Đã ổn định'
WHERE MABN = 5 AND MABS = 2 AND NGAY = '2025-05-10'

--2 câu DELETE:

-- Xóa giường chưa được sử dụng trong bảng DIEUTRI
DELETE FROM GIUONG
WHERE MAGIUONG NOT IN (SELECT DISTINCT MAGIUONG FROM DIEUTRI)

-- Xóa thông tin sử dụng dụng cụ (SUDUNG) của MABN=3, MADC=1, NGAY='2025-05-09'
DELETE FROM SUDUNG
WHERE MABN = 3 AND MADC = 1 AND NGAY = '2025-05-09'


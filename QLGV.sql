--------------------------------Lab1--------------------------------
--#PHAN I--
--1--
--Tao Database--
CREATE DATABASE QLGV
USE QLGV
DROP DATABASE QLGV

--Table KHOA--
CREATE TABLE KHOA(
	MAKHOA varchar(4),
	TENKHOA varchar(40),
	NGTLAP smalldatetime,
	TRGKHOA char(4),
	CONSTRAINT PK_KHOA PRIMARY KEY (MAKHOA)
)
--Table MONHOC--
CREATE TABLE MONHOC(
	MAMH varchar(10),
	TENMH varchar(40),
	TCLT tinyint,
	TCTH tinyint,
	MAKHOA varchar(4),
	CONSTRAINT PK_MONHOC PRIMARY KEY (MAMH)
)
ALTER TABLE MONHOC
ADD CONSTRAINT FK_MONHOC_KHOA 
FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
--Table DIEUKIEN--
CREATE TABLE DIEUKIEN(
	MAMH varchar(10),
	MAMH_TRUOC varchar(10),
	CONSTRAINT PK_DIEUKIEN PRIMARY KEY (MAMH,MAMH_TRUOC)
)
ALTER TABLE DIEUKIEN
ADD CONSTRAINT FK_DIEUKIEN_MONHOC 
FOREIGN KEY (MAMH) REFERENCES MONHOC(MAMH)
--Table GIAOVIEN--
CREATE TABLE GIAOVIEN(
	MAGV char(4),
	HOTEN varchar(40),
	HOCVI varchar(10),
	HOCHAM varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NGVL smalldatetime,
	HESO numeric(4,2),
	MUCLUONG money,
	MAKHOA varchar(4),
	CONSTRAINT PK_GIAOVIEN PRIMARY KEY (MAGV)
)
ALTER TABLE GIAOVIEN
ADD CONSTRAINT FK_GIAOVIEN_KHOA 
FOREIGN KEY (MAKHOA) REFERENCES KHOA(MAKHOA)
--Table HOCVIEN--
CREATE TABLE HOCVIEN(
	MAHV char(5),
	HO varchar(40),
	TEN varchar(10),
	GIOITINH varchar(3),
	NGSINH smalldatetime,
	NOISINH varchar(40),
	MALOP char(3),
	CONSTRAINT PK_HOCVIEN PRIMARY KEY (MAHV)
)
ALTER TABLE HOCVIEN 
ADD STT tinyint
--Tao Foreign Key cho HOCVIEN-LOP--
ALTER TABLE HOCVIEN 
ADD CONSTRAINT FK_HOCVIEN_LOP 
FOREIGN KEY (MALOP) REFERENCES LOP(MALOP)
--Table LOP--
CREATE TABLE LOP(
	MALOP char(3),
	TENLOP varchar(40),
	TRGLOP char(5),
	SISO tinyint,
	MAGVCN char(4),
	CONSTRAINT PK_LOP PRIMARY KEY (MALOP),
)
ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_HOCVIEN FOREIGN KEY (TRGLOP)	REFERENCES HOCVIEN(MAHV)
ALTER TABLE LOP
ADD CONSTRAINT FK_LOP_GIAOVIEN FOREIGN KEY (MAGVCN)REFERENCES GIAOVIEN(MAGV)
--Table GIANGDAY--
CREATE TABLE GIANGDAY(
	MALOP char(3),
	MAMH varchar(10),
	MAGV char(4),
	HOCKY tinyint,
	NAM smallint,
	TUNGAY smalldatetime,
	DENNGAY smalldatetime,
	CONSTRAINT PK_GIANGDAY PRIMARY KEY (MALOP,MAMH)
)
ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_LOP FOREIGN KEY (MALOP)
	REFERENCES LOP(MALOP)
ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_MONHOC FOREIGN KEY (MAMH)
	REFERENCES MONHOC(MAMH)
ALTER TABLE GIANGDAY
ADD CONSTRAINT FK_GIANGDAY_GIAOVIEN FOREIGN KEY (MAGV)
	REFERENCES GIAOVIEN(MAGV)
--Table KETQUATHI--
CREATE TABLE KETQUATHI(
	MAHV char(5),
	MAMH varchar(10),
	LANTHI tinyint,
	NGTHI smalldatetime,
	DIEM numeric(4,2),
	KQUA varchar(10),
	CONSTRAINT PK_KETQUATHI PRIMARY KEY (MAHV,MAMH,LANTHI)
)
ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_KETQUATHI_HOCVIEN FOREIGN KEY (MAHV)
	REFERENCES HOCVIEN(MAHV)
ALTER TABLE KETQUATHI
ADD CONSTRAINT FK_KETQUATHI_MONHOC FOREIGN KEY (MAMH)
	REFERENCES MONHOC(MAMH)
--Them GHICHU, DIEMTB, XEPLOAI cho HOCVIEN--
ALTER TABLE HOCVIEN ADD GHICHU varchar(50)
ALTER TABLE HOCVIEN ADD DIEMTB float
ALTER TABLE HOCVIEN ADD XEPLOAI varchar(20)
--2--draft
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_MAHV CHECK(MAHV='K%')
--3--
ALTER TABLE GIAOVIEN ADD
CONSTRAINT CK_GV_GT CHECK(GIOITINH IN ('Nam','Nu'))
ALTER TABLE HOCVIEN ADD
CONSTRAINT CK_HV_GT CHECK(GIOITINH = 'Nam' OR GIOITINH = 'Nu')
--4--
ALTER TABLE HOCVIEN ALTER COLUMN DIEMTB numeric(4,2)
ALTER TABLE KETQUATHI 
ADD CONSTRAINT CK_KQ_D CHECK(DIEM>=0 AND DIEM<=10)
--5--draft
ALTER TABLE KETQUATHI
ADD CONSTRAINT CK_KQUA_DAT CHECK((DIEM BETWEEN 5 AND 10) AND KQUA = 'Dat')
ALTER TABLE KETQUATHI 
DROP CONSTRAINT CK_KQUA_KDAT CHECK((DIEM BETWEEN 0 AND 5) AND KQUA = 'Khong dat')

--6--
ALTER TABLE KETQUATHI ADD
CONSTRAINT CK_KQ_LT CHECK(LANTHI<=3)
--7--
ALTER TABLE GIANGDAY ADD
CONSTRAINT CK_GD_HK CHECK(HOCKY<=3)
--8--
ALTER TABLE GIAOVIEN 
ADD CONSTRAINT CK_GV_HVI CHECK(HOCVI IN ('CN','KS','Ths','TS','PTS'))
--------------------------------Lab2--------------------------------
SET DATEFORMAT dmy
-- Thêm gữ liệu vào bảng

--Khoa
INSERT INTO KHOA VALUES('KHMT','Khoa hoc may tinh','7/6/2005','GV01')
INSERT INTO KHOA VALUES('HTTT','He thong thong tin','7/6/2005','GV02')
INSERT INTO KHOA VALUES('CNPM','Cong nghe phan mem','7/6/2005','GV04')
INSERT INTO KHOA VALUES('MTT','Mang va truyen thong','20/10/2005','GV03')
INSERT INTO KHOA VALUES('KTMT','Ky thuat may tinh','20/12/2005','GV14')

--MONHOC
INSERT INTO MONHOC VALUES('THDC','Tin hoc dai cuong',3,1,'KHMT')
INSERT INTO MONHOC VALUES('CTRR','Cau truc roi rac',3,1,'KHMT')
INSERT INTO MONHOC VALUES('CSDL','Co so du lieu',3,1,'HTTT')
INSERT INTO MONHOC VALUES('CTDLGT','Cau truc du lieu va giai thuat',3,1,'KHMT')
INSERT INTO MONHOC VALUES('PTTKTT','Phan tich thiet ke thuat toan',3,1,'KHMT')
INSERT INTO MONHOC VALUES('DHMT','Do hoa may tinh',3,1,'KHMT')
INSERT INTO MONHOC VALUES('KTMT','Kien truc may tinh',3,1,'KTMT')
INSERT INTO MONHOC VALUES('TKCSDL','Thiet ke co so du lieu',3,1,'HTTT')
INSERT INTO MONHOC VALUES('PTTKHTTT','Phan tich thiet ke he thong thong tin',3,1,'HTTT')
INSERT INTO MONHOC VALUES('HDH','He dieu hanh',3,1,'KTMT')
INSERT INTO MONHOC VALUES('NMCNPM','Nhap mon cong nghe phan mem',3,1,'CNPM')
INSERT INTO MONHOC VALUES('LTCFW','Lap trinh C for win', 3, 1,'CNPM')
INSERT INTO MONHOC VALUES('LTHDT', 'Lap trinh huong doi tuong', 3, 1, 'CNPM')

--DIEUKIEN
INSERT INTO DIEUKIEN VALUES('CSDL','CTRR')
INSERT INTO DIEUKIEN VALUES('CSDL','CTDLGT')
INSERT INTO DIEUKIEN VALUES('CTDLGT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKTT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKTT','CTDLGT')
INSERT INTO DIEUKIEN VALUES('DHMT','THDC')
INSERT INTO DIEUKIEN VALUES('LTHDT','THDC')
INSERT INTO DIEUKIEN VALUES('PTTKHTTT','CSDL')

--GIAOVIEN
INSERT INTO GIAOVIEN VALUES('GV01','Ho Thanh Son','PTS','GS','Nam','2/5/1950','11/1/2004',5.00,2250000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV02','Tran Tam Thanh','TS','PGS','Nam','17/12/1965','20/4/2004',4.50,2025000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV03','Do Nghiem Phung','TS','GS','Nu','1/8/1950','23/9/2004',4.00,1800000,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV04','Tran Nam Son','TS','PGS','Nam','22/2/1961','12/1/2005',4.50,2025000,'KTMT')
INSERT INTO GIAOVIEN VALUES('GV05','Mai Thanh Danh','ThS','GV','Nam','12/3/1958','12/1/2005',3.00,1350000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV06','Tran Doan Hung','TS','GV','Nam','11/3/1953','12/1/2005',4.50,2025000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV07','Nguyen Minh Tien','ThS','GV','Nam','23/11/1971','1/3/2005',4.00,1800000,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV08','Le Thi Tran','KS','','Nu','26/3/1974','1/3/2005',1.69,760500,'KHMT')
INSERT INTO GIAOVIEN VALUES('GV09','Nguyen To Lan','ThS','GV','Nu','31/12/1966','1/3/2005',4.00,1800000,'HTTT')
INSERT INTO GIAOVIEN VALUES('GV10','Le Tran Anh Loan','KS','','Nu','17/7/1972','1/3/2005',1.86,837000,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV11','Ho Thanh Tung','CN','GV','Nam','12/1/1980','15/5/2005',2.67,1201500,'MTT')
INSERT INTO GIAOVIEN VALUES('GV12','Tran Van Anh','CN','','Nu','29/3/1981','15/5/2005',1.69,760500,'CNPM')
INSERT INTO GIAOVIEN VALUES('GV13','Nguyen Linh Dan','CN','','Nu','23/5/1980','15/5/2005',1.69,760500,'KTMT')
INSERT INTO GIAOVIEN VALUES('GV14','Truong Minh Chau','ThS','GV','Nu','30/11/1976','15/5/2005',3.00,1350000,'MTT')
INSERT INTO GIAOVIEN VALUES('GV15', 'Le Ha Thanh', 'ThS', 'GV', 'Nam', '4/5/1978', '15/5/2005', 3.00, 1350000,'KHMT')


--LOP
INSERT INTO LOP VALUES('K11','Lop 1 khoa 1','K1108',11,'GV07')
INSERT INTO LOP VALUES('K12','Lop 2 khoa 1','K1205',12,'GV09')
INSERT INTO LOP VALUES('K13','Lop 3 khoa 1','K1305',12,'GV14')

--HOCVIEN
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1101','Nguyen Van','A','27/1/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1102','Tran Ngoc','Han','14/3/1986','Nu','Kien Giang','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1103','Ha Duy','Lap','18/4/1986','Nam','Nghe An','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1104','Tran Ngoc','Linh','30/3/1986','Nu','Tay Ninh','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1105','Tran Minh','Long','27/2/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1106','Le Nhat','Minh','24/1/1986','Nam','TpHCM','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1107','Nguyen Nhu','Nhut','27/1/1986','Nam','Ha Noi','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1108','Nguyen Manh','Tam','27/2/1986','Nam','Kien Giang','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1109','Phan Thi Thanh','Tam','27/1/1986','Nu','Vinh Long','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1110','Le Hoai','Thuong','5/2/1986','Nu','Can Tho','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1111','Le Ha','Vinh','25/12/1986','Nam','Vinh Long','K11')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1201','Nguyen Van','B','11/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1202','Nguyen Thi Kim','Duyen','18/1/1986','Nu','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1203','Tran Thi Kim','Duyen','17/9/1986','Nu','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1204','Truong My','Hanh','19/5/1986','Nu','Dong Nai','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1205','Nguyen Thanh','Nam','17/4/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1206','Nguyen Thi Truc','Thanh','4/3/1986','Nu','Kien Giang','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1207','Tran Thi Bich','Thuy','8/2/1986','Nu','Nghe An','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1208','Huynh Thi Kim','Trieu','8/4/1986','Nu','Tay Ninh','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1209','Pham Thanh','Trieu','23/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1210','Ngo Thanh','Tuan','14/2/1986','Nam','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1211','Do Thi','Xuan','9/3/1986','Nu','Ha Noi','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1212','Le Thi Phi','Yen','12/3/1986','Nu','TpHCM','K12')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1301','Nguyen Thi Kim','Cuc','9/6/1986','Nu','Kien Giang','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1302','Truong Thi My','Hien','18/3/1986','Nu','Nghe An','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1303','Le Duc','Hien','21/3/1986','Nam','Tay Ninh','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1304','Le Quang','Hien','18/4/1986','Nam','TpHCM','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1305','Le Thi','Huong','27/3/1986','Nu','TpHCM','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1306','Nguyen Thai','Huu','30/3/1986','Nam','Ha Noi','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1307','Tran Minh','Man','28/5/1986','Nam','TpHCM','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1308','Nguyen Hieu','Nghia','8/4/1986','Nam','Kien Giang','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1309','Nguyen Trung','Nghia','18/1/1987','Nam','Nghe An','K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1310','Tran Thi Hong','Tham','22/4/1986','Nu','Tay Ninh','K13') 
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1311', 'Tran Minh', 'Thuc', '4/4/1986', 'Nam', 'TpHCM', 'K13')
INSERT INTO HOCVIEN(MAHV,HO,TEN,NGSINH,GIOITINH,NOISINH,MALOP) VALUES('K1312', 'Nguyen Thi Kim', 'Yen', '7/9/1986', 'Nu', 'TpHCM', 'K13')

--GIANGDAY
INSERT INTO GIANGDAY VALUES('K11','THDC','GV07',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K12','THDC','GV06',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K13','THDC','GV15',1,2006,'2/1/2006','12/5/2006')
INSERT INTO GIANGDAY VALUES('K11','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K12','CTRR','GV02',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K13','CTRR','GV08',1,2006,'9/1/2006','17/5/2006')
INSERT INTO GIANGDAY VALUES('K11','CSDL','GV05',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K12','CSDL','GV09',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K13','CTDLGT','GV15',2,2006,'1/6/2006','15/7/2006')
INSERT INTO GIANGDAY VALUES('K13','CSDL','GV05',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K13','DHMT','GV07',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K11','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K12','CTDLGT','GV15',3,2006,'1/8/2006','15/12/2006')
INSERT INTO GIANGDAY VALUES('K11','HDH','GV04',1,2007,'2/1/2007','18/2/2007')
INSERT INTO GIANGDAY VALUES('K12','HDH','GV04',1,2007,'2/1/2007','20/3/2007')
INSERT INTO GIANGDAY VALUES('K11','DHMT','GV07',1,2007,'18/2/2007','20/3/2007')

--KETQUATHI
INSERT INTO KETQUATHI VALUES('K1101','CSDL',1,'20/7/2006',10.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1101','CTDLGT',1,'28/12/2006',9.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1101','THDC',1,'20/5/2006',9.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1101','CTRR',1,'13/5/2006',9.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',1,'20/7/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',2,'27/7/2006',4.25,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1102','CSDL',3,'10/8/2006',4.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',1,'28/12/2006',4.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',2,'5/1/2007',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1102','CTDLGT',3,'15/1/2007',6.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1102','THDC',1,'20/5/2006',5.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1102','CTRR',1,'13/5/2006',7.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1103','CSDL',1,'20/7/2006',3.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1103','CSDL',2,'27/7/2006',8.25,'Dat')
INSERT INTO KETQUATHI VALUES('K1103','CTDLGT',1,'28/12/2006',7.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1103','THDC',1,'20/5/2006',8.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1103','CTRR',1,'13/5/2006',6.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1104','CSDL',1,'20/7/2006',3.75,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1104','CTDLGT',1,'28/12/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1104','THDC',1,'20/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',1,'13/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',2,'20/5/2006',3.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1104','CTRR',3,'30/6/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1201','CSDL',1,'20/7/2006',6.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1201','CTDLGT',1,'28/12/2006',5.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1201','THDC',1,'20/5/2006',8.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1201','CTRR',1,'13/5/2006',9.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1202','CSDL',1,'20/7/2006',8.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1202','CTDLGT',1,'28/12/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1202','CTDLGT',2,'5/1/2007',5.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1202','THDC',1,'20/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1202','THDC',2,'27/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',1,'13/5/2006',3.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',2,'20/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1202','CTRR',3,'30/6/2006',6.25,'Dat')
INSERT INTO KETQUATHI VALUES('K1203','CSDL',1,'20/7/2006',9.25,'Dat')
INSERT INTO KETQUATHI VALUES('K1203','CTDLGT',1,'28/12/2006',9.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1203','THDC',1,'20/5/2006',10.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1203','CTRR',1,'13/5/2006',10.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1204','CSDL',1,'20/7/2006',8.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1204','CTDLGT',1,'28/12/2006',6.75,'Dat')
INSERT INTO KETQUATHI VALUES('K1204','THDC',1,'20/5/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1204','CTRR',1,'13/5/2006',6.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1301','CSDL',1,'20/12/2006',4.25,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1301','CTDLGT',1,'25/7/2006',8.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1301','THDC',1,'20/5/2006',7.75,'Dat')
INSERT INTO KETQUATHI VALUES('K1301','CTRR',1,'13/5/2006',8.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1302','CSDL',1,'20/12/2006',6.75,'Dat')
INSERT INTO KETQUATHI VALUES('K1302','CTDLGT',1,'25/7/2006',5.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1302','THDC',1,'20/5/2006',8.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1302','CTRR',1,'13/5/2006',8.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1303','CSDL',1,'20/12/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',1,'25/7/2006',4.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',2,'7/8/2006',4.00,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','CTDLGT',3,'15/8/2006',4.25,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','THDC',1,'20/5/2006',4.50,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','CTRR',1,'13/5/2006',3.25,'Khong Dat')
INSERT INTO KETQUATHI VALUES('K1303','CTRR',2,'20/5/2006',5.00,'Dat')
INSERT INTO KETQUATHI VALUES('K1304','CSDL',1,'20/12/2006',7.75,'Dat')
INSERT INTO KETQUATHI VALUES('K1304','CTDLGT',1,'25/7/2006',9.75,'Dat')
INSERT INTO KETQUATHI VALUES('K1304','THDC',1,'20/5/2006',5.50,'Dat')
INSERT INTO KETQUATHI VALUES('K1304', 'CTRR', 1, '13/5/2006', 5.00, 'Dat')
INSERT INTO KETQUATHI VALUES('K1305', 'CSDL', 1, '20/12/2006', 9.25, 'Dat')
INSERT INTO KETQUATHI VALUES('K1305', 'CTDLGT', 1, '25/7/2006', 10.00, 'Dat')
INSERT INTO KETQUATHI VALUES('K1305', 'THDC', 1, '20/5/2006', 8.00, 'Dat')
INSERT INTO KETQUATHI VALUES('K1305', 'CTRR', 1, '13/5/2006', 10.00, 'Dat')

--11. Học viên ít nhất là 18 tuổi.
ALTER TABLE HOCVIEN
ADD CONSTRAINT CK_HV_18T CHECK(YEAR(GETDATE())-YEAR(NGSINH)>=18)
--12. Giảng dạy một môn học ngày bắt đầu (TUNGAY) phải nhỏ hơn ngày kết thúc (DENNGAY).
ALTER TABLE GIANGDAY
ADD CONSTRAINT CK_GD_BD_KT CHECK(TUNGAY<=DENNGAY)
--13. Giáo viên khi vào làm ít nhất là 22 tuổi.
ALTER TABLE GIAOVIEN
ADD CONSTRAINT CK_GV_22T CHECK(YEAR(NGVL)-YEAR(NGSINH)>=22)
--14. Tất cả các môn học đều có số tín chỉ lý thuyết và tín chỉ thực hành chênh lệch nhau không quá 3.
ALTER TABLE MONHOC
ADD CONSTRAINT CK_MH_LT_TH CHECK(ABS(TCLT-TCTH)<=3)
--III. Ngôn ngữ truy vấn dữ liệu
--1. In ra danh sách (mã học viên, họ tên, ngày sinh, mã lớp) lớp trưởng của các lớp.
use qlgv
SELECT HOCVIEN.MAHV, CONCAT(HOCVIEN.HO,' ', HOCVIEN.TEN) AS HOTEN, HOCVIEN.NGSINH, HOCVIEN.MALOP 
FROM HOCVIEN  JOIN LOP
ON HOCVIEN.MAHV = LOP.TRGLOP
--2. In ra bảng điểm khi thi (mã học viên, họ tên , lần thi, điểm số) môn CTRR của lớp “K12”, sắp xếp theo tên, họ học viên.
SELECT HV.MAHV, CONCAT(HV.HO, ' ', HV.TEN) AS HOTEN, KQ.LANTHI, KQ.DIEM
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV 
WHERE KQ.MAMH = 'CTRR' AND HV.MALOP = 'K12'
--GROUP BY HV.MAHV
--3. In ra danh sách những học viên (mã học viên, họ tên) và những môn học mà học viên đó thi lần thứ nhất đã đạt.
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN, MH.TENMH 
FROM (HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV) JOIN MONHOC MH ON MH.MAMH = KQ.MAMH 
WHERE LANTHI = '1' AND KQUA = 'Dat'
SELECT * FROM KETQUATHI
--4. In ra danh sách học viên (mã học viên, họ tên) của lớp “K11” thi môn CTRR không đạt (ở lần thi 1).
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE HV.MALOP = 'K11' AND KQ.MAMH = 'CTRR' AND KQ.KQUA = 'Khong dat' AND KQ.LANTHI = '1'
--5. * Danh sách học viên (mã học viên, họ tên) của lớp “K” thi môn CTRR không đạt (ở tất cả các lần thi).


--------------------------------Lab3--------------------------------
--II. Ngôn ngữ thao tác dữ liệu
--1. Tăng hệ số lương thêm 0.2 cho những giáo viên là trưởng khoa.
USE QLGV
UPDATE GIAOVIEN 
SET GIAOVIEN.HESO = GIAOVIEN.HESO + 0.2
WHERE GIAOVIEN.MAGV IN (
	SELECT GIAOVIEN.MAGV 
	FROM GIAOVIEN JOIN KHOA ON GIAOVIEN.MAGV = KHOA.TRGKHOA 
)
--2. Cập nhật giá trị điểm trung bình tất cả các môn học  (DIEMTB) của mỗi học viên (tất cả các môn học đều có hệ số 1 và nếu học viên thi một môn nhiều lần, chỉ lấy điểm của lần thi sau cùng).
SELECT KQ.MAHV, KQ.MAMH, MAX(KQ.LANTHI) AS SOLANTHI INTO KQ1
FROM KETQUATHI KQ 
GROUP BY MAHV, MAMH

SELECT KQ.MAHV, AVG(DIEM) AS DIEMTB INTO KQ2 
FROM KETQUATHI KQ JOIN KQ1 ON KQ.MAHV = KQ1.MAHV AND KQ.MAMH = KQ1.MAMH 
WHERE KQ.LANTHI = KQ1.SOLANTHI
GROUP BY KQ.MAHV 
SELECT * FROM KQ2

UPDATE HOCVIEN
SET HOCVIEN.DIEMTB = KQ2.DIEMTB FROM KQ2
WHERE HOCVIEN.MAHV = KQ2.MAHV

DROP TABLE KQ1 
DROP TABLE KQ2
--3. Cập nhật giá trị cho cột GHICHU là “Cam thi” đối với trường hợp: học viên có một môn bất kỳ thi lần thứ 3 dưới 5 điểm.
UPDATE HOCVIEN 
SET GHICHU = 'Cam thi' 
WHERE HOCVIEN.MAHV IN (
	SELECT KETQUATHI.MAHV 
	FROM KETQUATHI 
	WHERE LANTHI = '3' AND DIEM < 5
)
--4. Cập nhật giá trị cho cột XEPLOAI trong quan hệ HOCVIEN như sau:
	--• Nếu DIEMTB  9 thì XEPLOAI =”XS”
	--• Nếu  8  DIEMTB < 9 thì XEPLOAI = “G”
	--• Nếu  6.5  DIEMTB < 8 thì XEPLOAI = “K”
	--• Nếu  5    DIEMTB < 6.5 thì XEPLOAI = “TB”
	--• Nếu  DIEMTB < 5 thì XEPLOAI = ”Y”
UPDATE HOCVIEN 
SET XEPLOAI = 'XS'
WHERE HOCVIEN.DIEMTB >= 9 

UPDATE HOCVIEN 
SET XEPLOAI = 'G'
WHERE HOCVIEN.DIEMTB >= 8 AND HOCVIEN.DIEMTB < 9

UPDATE HOCVIEN 
SET XEPLOAI = 'K'
WHERE HOCVIEN.DIEMTB >= 6.5 AND HOCVIEN.DIEMTB < 8

UPDATE HOCVIEN 
SET XEPLOAI = 'TB'
WHERE HOCVIEN.DIEMTB >= 5 AND HOCVIEN.DIEMTB < 6.5

UPDATE HOCVIEN 
SET XEPLOAI = 'Y'
WHERE HOCVIEN.DIEMTB > 5

--III. Ngôn ngữ truy vấn dữ liệu
--6. Tìm tên những môn học mà giáo viên có tên “Tran Tam Thanh” dạy trong học kỳ 1 năm 2006. ?
SELECT HOCVIEN.TEN 
FROM HOCVIEN 
WHERE HOCVIEN.MAHV IN (
	SELECT MAHV 
	FROM HOCVIEN HV JOIN GIANGDAY GD ON HV.MALOP = GD.MALOP
	WHERE HOCKY = '1' AND YEAR(NAM) = '2006' AND MAGV = (
		SELECT GIANGDAY.MAGV 
		FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
		WHERE GIAOVIEN.HOTEN = 'Tran Tam Thanh'
	)
)
--7. Tìm những môn học (mã môn học, tên môn học) mà giáo viên chủ nhiệm lớp “K11” dạy trong học kỳ 1 năm 2006.
SELECT MAGVCN INTO GV_K11 
FROM LOP 
WHERE MALOP = 'K11'
SELECT MAGV INTO GV_1_2006
FROM GIANGDAY 
WHERE HOCKY = '1' AND  NAM = '2006'

SELECT GD.MAMH, MH.TENMH 
FROM GIANGDAY GD JOIN MONHOC MH ON GD.MAMH = MH.MAMH 
WHERE GD.MAGV = (
	SELECT MAGV 
	FROM GV_K11 JOIN GV_1_2006 ON GV_K11.MAGVCN = GV_1_2006.MAGV
)
--8. Tìm họ tên lớp trưởng của các lớp mà giáo viên có tên “Nguyen To Lan” dạy môn “Co So Du Lieu”.?
SELECT GIANGDAY.MAGV INTO GV_NTL_CSDL
FROM GIAOVIEN JOIN GIANGDAY ON GIAOVIEN.MAGV = GIANGDAY.MAGV
WHERE GIAOVIEN.HOTEN = 'Nguyen To Lan' AND GIANGDAY.MAMH IN (
	SELECT MONHOC.MAMH 
	FROM GIANGDAY JOIN MONHOC ON GIANGDAY.MAMH = MONHOC.MAMH
	WHERE MONHOC.TENMH = 'Co So Du Lieu'
)
DROP TABLE GV_NTL_CSDL
SELECT CONCAT(HOCVIEN.HO,' ',HOCVIEN.TEN) AS HOTEN 
FROM (HOCVIEN JOIN LOP ON HOCVIEN.MAHV = LOP.TRGLOP) JOIN  GV_NTL_CSDL ON LOP.MAGVCN = GV_NTL_CSDL.MAGV 
--9. In ra danh sách những môn học (mã môn học, tên môn học) phải học liền trước môn “Co So Du Lieu”.
SELECT MH.MAMH, MH.TENMH 
FROM MONHOC MH JOIN DIEUKIEN DK ON DK.MAMH_TRUOC = MH.MAMH
WHERE DK.MAMH = (
	SELECT MH.MAMH
	FROM MONHOC MH 
	WHERE MH.TENMH = 'Co So Du Lieu'
)
--10. Môn “Cau Truc Roi Rac” là môn bắt buộc phải học liền trước những môn học (mã môn học, tên môn học) nào.
SELECT MH.MAMH, MH.TENMH
FROM MONHOC MH
WHERE MH.MAMH = (
	SELECT DK.MAMH
	FROM DIEUKIEN DK 
	WHERE DK.MAMH_TRUOC = (
		SELECT MH.MAMH
		FROM MONHOC MH 
		WHERE MH.TENMH = 'Cau Truc Roi Rac'
))
--11. Tìm họ tên giáo viên dạy môn CTRR cho cả hai lớp “K11” và “K12” trong cùng học kỳ 1 năm 2006.
SELECT GV.HOTEN 
FROM GIAOVIEN GV 
WHERE GV.MAGV = (
	SELECT GD.MAGV 
	FROM GIANGDAY GD 
	WHERE GD.MALOP = 'K11' AND GD.HOCKY = '1' AND NAM = '2006' AND GD.MAMH = 'CTRR'
	INTERSECT
	SELECT GD.MAGV
	FROM GIANGDAY GD 
	WHERE GD.MALOP = 'K12' AND GD.HOCKY = '1' AND NAM = '2006' AND GD.MAMH = 'CTRR'
)
SELECT * FROM GIANGDAY
SELECT * FROM GIAOVIEN
--12. Tìm những học viên (mã học viên, họ tên) thi không đạt môn CSDL ở lần thi thứ 1 nhưng chưa thi lại môn này.
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM HOCVIEN HV 
WHERE HV.MAHV IN (
	SELECT KQ.MAHV 
	FROM KETQUATHI KQ 
	WHERE LANTHI = '1' AND KQUA = 'Khong dat'
	EXCEPT 
	SELECT KQ.MAHV 
	FROM KETQUATHI KQ 
	WHERE (LANTHI = '2' OR LANTHI = '3')
)
--13. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (
	SELECT GV.MAGV 
	FROM GIAOVIEN GV
	EXCEPT
	SELECT GD.MAGV
	FROM GIANGDAY GD
)
--14. Tìm giáo viên (mã giáo viên, họ tên) không được phân công giảng dạy bất kỳ môn học nào thuộc khoa giáo viên đó phụ trách.
SELECT GV.MAGV, GV.HOTEN
FROM GIAOVIEN GV
WHERE GV.MAGV IN (
	SELECT GV.MAGV 
	FROM GIAOVIEN GV

	EXCEPT

	SELECT GD.MAGV
	FROM GIANGDAY GD
	WHERE GD.MAGV IN (
		SELECT GV.MAGV 
		FROM (GIAOVIEN GV JOIN KHOA K ON GV.MAKHOA = K.MAKHOA) JOIN MONHOC MH ON MH.MAKHOA = K.MAKHOA
	)
)
--15. Tìm họ tên các học viên thuộc lớp “K11” thi một môn bất kỳ quá 3 lần vẫn “Khong dat” hoặc thi lần thứ 2 môn CTRR được 5 điểm.
SELECT CONCAT(HV.HO,' ',HV.TEN) AS HOTEN 
FROM HOCVIEN HV 
WHERE HV.MAHV IN (
	SELECT HV.MAHV
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
	WHERE HV.MALOP = 'K11' AND KQ.LANTHI >= 3 AND KQ.KQUA = 'Khong Dat'
	UNION 
	SELECT HV.MAHV 
	FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
	WHERE HV.MALOP = 'K11' AND KQ.LANTHI = 2 AND KQ.MAMH = 'CTRR' AND KQ.DIEM = 5
)
--16. Tìm họ tên giáo viên dạy môn CTRR cho ít nhất hai lớp trong cùng một học kỳ của một năm học. ?
SELECT GD.MAGV INTO GV_CTRR
FROM GIANGDAY GD 
WHERE GD.MAMH = 'CTRR'
GROUP BY GD.MAGV

SELECT GD.MAGV, GD.MALOP INTO GV_LOP
FROM GIANGDAY GD JOIN GV_CTRR ON GV_CTRR.MAGV = GD.MAGV
WHERE GD.HOCKY IN (
	SELECT GD.HOCKY
	FROM GIANGDAY JOIN GV_CTRR ON GV_CTRR.MAGV = GIANGDAY.MAGV
) AND GD.NAM IN (
	SELECT  GD.NAM
	FROM GIANGDAY JOIN GV_CTRR ON GV_CTRR.MAGV = GIANGDAY.MAGV
)

SELECT GV_LOP.MAGV, COUNT(GV_LOP.MALOP)
FROM GV_LOP
--17. Danh sách học viên và điểm thi môn CSDL (chỉ lấy điểm của lần thi sau cùng).?
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN, KQ.DIEM 
FROM HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV
WHERE KQ.MAMH = 'CSDL'
GROUP BY HV.MAHV
HAVING KQ.LANTHI = MAX(KQ.LANTHI)
--18. Danh sách học viên và điểm thi môn “Co So Du Lieu” (chỉ lấy điểm cao nhất của các lần thi).?
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN, MAX(KQ.DIEM )
FROM (HOCVIEN HV JOIN KETQUATHI KQ ON HV.MAHV = KQ.MAHV) JOIN MONHOC MH ON MH.MAMH = KQ.MAMH
WHERE MH.MAMH = 'Co So Du Lieu'
--------------------------------Lab4--------------------------------     
--19. Khoa nào (mã khoa, tên khoa) được thành lập sớm nhất.
SELECT MAKHOA, TENKHOA
FROM KHOA K1
WHERE NGTLAP <= ALL (
	SELECT NGTLAP
	FROM KHOA K2
)
--20. Có bao nhiêu giáo viên có học hàm là “GS” hoặc “PGS”.
SELECT COUNT(MAGV) AS GV_GS_PGS
FROM GIAOVIEN 
WHERE GIAOVIEN.HOCHAM IN ('GS','PGS')
--21. Thống kê có bao nhiêu giáo viên có học vị là “CN”, “KS”, “Ths”, “TS”, “PTS” trong mỗi khoa.
SELECT K.MAKHOA, K.TENKHOA, COUNT(GV.MAGV) AS GV_HOCVI
FROM GIAOVIEN GV JOIN KHOA K ON GV.MAKHOA = K.MAKHOA
WHERE GV.HOCVI IN ('CN','KS','Ths','TS','PTS')
GROUP BY K.MAKHOA, K.TENKHOA 
--22. Mỗi môn học thống kê số lượng học viên theo kết quả (đạt và không đạt).
SELECT KQ1.MAMH, KQ1.DAT, KQ2.KDAT
FROM
(SELECT KQ.MAMH, COUNT(HV.MAHV) AS DAT
FROM KETQUATHI KQ JOIN HOCVIEN HV ON KQ.MAHV = HV.MAHV
WHERE KQ.KQUA = 'Dat'
GROUP BY KQ.MAMH) AS KQ1
JOIN 
(SELECT KQ.MAMH, COUNT(HV.MAHV) AS KDAT
FROM KETQUATHI KQ JOIN HOCVIEN HV ON KQ.MAHV = HV.MAHV
WHERE KQ.KQUA = 'Khong dat'
GROUP BY KQ.MAMH) AS KQ2
ON KQ1.MAMH = KQ2.MAMH
use QLGV
--23. Tìm giáo viên (mã giáo viên, họ tên) là giáo viên chủ nhiệm của một lớp, đồng thời dạy cho lớp đó ít nhất một môn học.
SELECT L.MALOP, GV.MAGV, GV.HOTEN 
FROM GIAOVIEN GV JOIN LOP L ON GV.MAGV = L.MAGVCN
WHERE GV.MAGV IN (
	SELECT MAGV 
	FROM GIANGDAY
	WHERE GIANGDAY.MALOP = L.MALOP
)
--24. Tìm họ tên lớp trưởng của lớp có sỉ số cao nhất.
SELECT L.TRGLOP, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM LOP L JOIN HOCVIEN HV ON HV.MAHV = L.TRGLOP
WHERE L.SISO >= ALL (
	SELECT SISO 
	FROM LOP
)
--?25. * Tìm họ tên những LOPTRG thi không đạt quá 3 môn (mỗi môn đều thi không đạt ở tất cả các lần thi).
SELECT CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM LOP L JOIN HOCVIEN HV ON HV.MAHV = L.TRGLOP
WHERE HV.MAHV IN (
	SELECT KQ.MAHV
	FROM KETQUATHI KQ JOIN (
		SELECT KQ1.MAHV, COUNT(DISTINCT MAMH) AS SOMH
		FROM KETQUATHI KQ1
		WHERE KQUA = 'Khong dat'
		GROUP BY MAHV 
	) AS KQ1 ON KQ.MAHV = KQ1.MAHV
	WHERE KQ1.SOMH >= 3
)
--26. Tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT TOP 1 HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM HOCVIEN HV
JOIN
(SELECT KQ.MAHV, COUNT(KQ.MAMH) AS MON_9_10
FROM KETQUATHI KQ 
WHERE KQ.DIEM IN (9,10)
GROUP BY KQ.MAHV) KQ1 
ON KQ1.MAHV = HV.MAHV
ORDER BY MON_9_10 DESC 
--27. Trong từng lớp, tìm học viên (mã học viên, họ tên) có số môn đạt điểm 9,10 nhiều nhất.
SELECT HV.MALOP, HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN
FROM (HOCVIEN HV JOIN LOP L ON HV.MALOP = L.MALOP)
JOIN
	(	SELECT KQ.MAHV, COUNT(KQ.MAMH) AS MON_9_10
		FROM KETQUATHI KQ 
		WHERE KQ.DIEM IN (9,10)
		GROUP BY KQ.MAHV) KQ1 
ON KQ1.MAHV = HV.MAHV
------------------------------
SELECT H.MALOP, K.MAHV, COUNT(*) AS SODIEM_9_10 INTO LOP_DIEM
FROM KETQUATHI K, HOCVIEN H 
WHERE K.MAHV = H.MAHV AND K.DIEM IN (9,10)
GROUP BY H.MALOP, K.MAHV


SELECT LD1.MALOP, LD1.MAHV 
FROM LOP_DIEM LD1
WHERE LD1.SODIEM_9_10 >= ALL (
	SELECT LD2.SODIEM_9_10
	FROM LOP_DIEM LD2 
	WHERE LD1.MALOP = LD2.MALOP
) 

-------------------------------
SELECT H.MALOP, K.MAHV, CONCAT(H.HO,' ',H.TEN) AS HOTEN,COUNT(*) AS SODIEM_9_10 
FROM KETQUATHI K, HOCVIEN H 
WHERE K.MAHV = H.MAHV AND K.DIEM IN (9,10)
GROUP BY H.MALOP, K.MAHV, CONCAT(H.HO,' ',H.TEN)
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
	FROM KETQUATHI K1, HOCVIEN H1 
	WHERE K1.DIEM IN (9,10) AND K1.MAHV = H1.MAHV AND H1.MALOP = H.MALOP 
	GROUP BY K1.MAHV 
)
--28. Trong từng học kỳ của từng năm, mỗi giáo viên phân công dạy bao nhiêu môn học, bao nhiêu lớp.
SELECT GD.NAM, GD.HOCKY, GV.HOTEN, COUNT(DISTINCT GD.MAMH) AS SOMON, COUNT(GD.MALOP) AS SOLOP 
FROM GIANGDAY GD JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV 
GROUP BY GD.NAM, GD.HOCKY, GV.HOTEN 
ORDER BY GD.NAM, GD.HOCKY
--?29. Trong từng học kỳ của từng năm, tìm giáo viên (mã giáo viên, họ tên) giảng dạy nhiều nhất.
SELECT GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTEN, COUNT(*) AS SOLOP  
FROM GIANGDAY GD JOIN GIAOVIEN GV ON GD.MAGV = GV.MAGV 
GROUP BY GD.NAM, GD.HOCKY, GV.MAGV, GV.HOTEN
HAVING COUNT(*) >= ALL (
	SELECT COUNT(*)
	FROM GIANGDAY GD1 JOIN GIAOVIEN GV1 ON GD1.MAGV = GV1.MAGV 
	WHERE GD.HOCKY = GD1.HOCKY  
	GROUP BY GD1.NAM, GD1.HOCKY
)
--30. Tìm môn học (mã môn học, tên môn học) có nhiều học viên thi không đạt (ở lần thi thứ 1) nhất.
SELECT TOP 1 MH.MAMH, MH.TENMH
FROM MONHOC MH JOIN 
(
	SELECT KQ.MAMH, COUNT(KQ.MAHV) AS THIROT
	FROM KETQUATHI KQ 
	WHERE KQ.LANTHI = '1' AND KQ.KQUA = 'Khong dat'
	GROUP BY KQ.MAMH 
) T ON MH.MAMH = T.MAMH 
ORDER BY THIROT DESC
use QLGV
--31. Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi thứ 1).
SELECT DISTINCT KETQUATHI.MAHV,CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN JOIN KETQUATHI ON HOCVIEN.MAHV = KETQUATHI.MAHV
WHERE KETQUATHI.MAHV NOT IN (
	SELECT DISTINCT MAHV
	FROM KETQUATHI
	WHERE KQUA='Khong Dat' AND LANTHI=1)
--32. * Tìm học viên (mã học viên, họ tên) thi môn nào cũng đạt (chỉ xét lần thi sau cùng).
SELECT MAHV, CONCAT(HO,' ',TEN) AS HOTEN 
FROM HOCVIEN
WHERE MAHV NOT IN (
	SELECT KQ1.MAHV 
	FROM KETQUATHI KQ1
	WHERE KQ1.KQUA='Khong dat'
	GROUP BY KQ1.MAHV, KQ1.LANTHI
	HAVING KQ1.LANTHI = (
		SELECT MAX(KQ2.LANTHI)
		FROM KETQUATHI KQ2
		WHERE KQ1.MAHV = KQ2.MAHV
	)
)
--33. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt (chỉ xét lần thi thứ 1).
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN 
FROM HOCVIEN HV 
WHERE NOT EXISTS (
	SELECT *
	FROM MONHOC MH 
	WHERE NOT EXISTS (
		SELECT *
		FROM KETQUATHI KQ 
		WHERE KQ.MAMH = MH.MAMH AND KQ.MAHV = HV.MAHV AND KQ.LANTHI = '1' AND KQ.KQUA = 'Dat'
	)
)
--34. * Tìm học viên (mã học viên, họ tên) đã thi tất cả các môn đều đạt  (chỉ xét lần thi sau cùng).
SELECT HV.MAHV, CONCAT(HV.HO,' ',HV.TEN) AS HOTEN 
FROM HOCVIEN HV 
WHERE NOT EXISTS (
	SELECT *
	FROM MONHOC MH 
	WHERE NOT EXISTS (
		SELECT *
		FROM KETQUATHI KQ 
		WHERE KQ.MAMH = MH.MAMH AND KQ.MAHV = HV.MAHV AND KQ.KQUA = 'Dat' AND KQ.LANTHI >= ALL (
			SELECT KQ1.LANTHI 
			FROM KETQUATHI KQ1 
			WHERE KQ.MAHV = KQ1.MAHV AND KQ.MAMH = KQ1.MAMH 
		)
	)
)
--35. ** Tìm học viên (mã học viên, họ tên) có điểm thi cao nhất trong từng môn (lấy điểm ở lần thi sau cùng).
SELECT TOP 1 KQ.MAHV, KQ.MAMH, KQ.DIEM
FROM KETQUATHI KQ 
WHERE KQ.LANTHI = (
	SELECT MAX(KQ2.LANTHI)
	FROM KETQUATHI KQ2 
	WHERE KQ2.MAHV = KQ.MAHV AND KQ2.MAMH = KQ.MAMH 
)
GROUP BY KQ.MAHV, KQ.MAMH, KQ.DIEM 
HAVING KQ.DIEM >= ALL (
	SELECT KQ1.DIEM
	FROM KETQUATHI KQ1 
	WHERE KQ1.MAHV = KQ.MAHV AND KQ1.MAHV = KQ.MAMH AND KQ1.LANTHI = (
		SELECT MAX(KQ3.LANTHI)
		FROM KETQUATHI KQ3 
		WHERE KQ3.MAMH = KQ1.MAMH AND KQ3.MAHV = KQ1.MAHV
	)
)
--------------------------------Lab5-------------------------------- 
--9. Lớp trưởng của một lớp phải là học viên của lớp đó.
CREATE TRIGGER trg_loptrg_lop ON LOP 
FOR INSERT, UPDATE 
AS 
BEGIN 
	IF EXISTS (
		SELECT *
		FROM INSERTED I JOIN HOCVIEN H ON I.MALOP = H.MALOP
		WHERE I.TRGLOP <> H.MAHV
	)
	BEGIN 
		PRINT('LOI: LOP TRUONG KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT('THEM MOI THANH CONG!')
	END
END
--10. Trưởng khoa phải là giáo viên thuộc khoa và có học vị “TS” hoặc “PTS”.
CREATE TRIGGER trg_trgkhoa_khoa ON KHOA
FOR INSERT, UPDATE 
AS 
BEGIN 
	IF EXISTS (
		SELECT *
		FROM INSERTED I JOIN GIAOVIEN GV ON I.MAKHOA = GV.MAKHOA
		WHERE I.TRGKHOA NOT IN (GV.MAGV) OR GV.HOCVI NOT IN ('TS','PTS')
	)
	BEGIN 
		PRINT('LOI: TRUONG KHOA KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT('THEM MOI THANH CONG!')
	END
END
--15. Học viên chỉ được thi một môn học nào đó khi lớp của học viên đã học xong môn học này.
CREATE TRIGGER trg_ngthi_kqthi ON KETQUATHI
FOR INSERT, UPDATE 
AS 
BEGIN 
	IF EXISTS (
		SELECT *
		FROM INSERTED I JOIN GIANGDAY GD ON I.MAMH = GD.MAMH
		WHERE I.NGTHI < GD.DENNGAY
	)
	BEGIN 
		PRINT('LOI: NGAY THI KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END
	ELSE
	BEGIN
		PRINT('THEM MOI THANH CONG!')
	END
END
USE QLGV
--16. Mỗi học kỳ của một năm học, một lớp chỉ được học tối đa 3 môn.
CREATE TRIGGER trg_upd_mh ON GIANGDAY
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM INSERTED I JOIN GIANGDAY GD ON I.MALOP = GD.MALOP 
		WHERE I.NAM = GD.NAM AND I.HOCKY = GD.HOCKY
		GROUP BY I.NAM, I.HOCKY
		HAVING COUNT(I.MAMH) > 3
	)
	BEGIN
		PRINT('LOI: MOI LOP CHI DUOC HOC TOI DA 3 MON HOC TRONG 1 HOC KI!')
		ROLLBACK TRANSACTION
	END 
	ELSE 
	BEGIN
		PRINT('THEM MON HOC THANH CONG!')
	END 
END 
--17. Sỉ số của một lớp bằng với số lượng học viên thuộc lớp đó.
CREATE TRIGGER trg_upd_siso ON HOCVIEN 
FOR INSERT, UPDATE 
AS 
BEGIN
	UPDATE LOP
	SET SISO = (
		SELECT COUNT(*)
		FROM HOCVIEN JOIN LOP ON HOCVIEN.MALOP = LOP.MALOP
	)
	FROM HOCVIEN JOIN LOP ON HOCVIEN.MALOP = LOP.MALOP 
	PRINT('SI SO LOP DA DUOC CAP NHAT!')
END
--18. Trong quan hệ DIEUKIEN giá trị của thuộc tính MAMH và MAMH_TRUOC trong cùng một bộ không được giống nhau (“A”,”A”) và cũng không tồn tại hai bộ (“A”,”B”) và (“B”,”A”).
CREATE TRIGGER trg_upd_dk ON DIEUKIEN
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM INSERTED I JOIN DIEUKIEN DK ON (I.MAMH = DK.MAMH)
		WHERE I.MAMH = I.MAMH_TRUOC OR (I.MAMH = DK.MAMH_TRUOC AND I.MAMH_TRUOC = DK.MAMH)
	)
	BEGIN
		PRINT('LOI: MAMH VA MAMH_TRUOC KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END 
	ELSE 
	BEGIN
		PRINT('THEM DIEU KIEN THANH CONG!')
	END 
END 
--19. Các giáo viên có cùng học vị, học hàm, hệ số lương thì mức lương bằng nhau.
CREATE TRIGGER trg_upd_mucluong ON GIAOVIEN 
FOR INSERT, UPDATE 
AS 
BEGIN
	UPDATE GIAOVIEN
	SET MUCLUONG = (
		SELECT GV.MUCLUONG
		FROM GIAOVIEN GV, INSERTED
		WHERE INSERTED.HOCVI = GV.HOCVI AND INSERTED.HOCHAM = GV.HOCHAM AND INSERTED.HESO = GV.HESO
	)
	FROM GIAOVIEN
	PRINT('MUC LUONG DA DUOC CAP NHAT!')
END
--20. Học viên chỉ được thi lại (lần thi >1) khi điểm của lần thi trước đó dưới 5.
CREATE TRIGGER trg_upd_kq ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM KETQUATHI KQ, INSERTED I 
		WHERE KQ.MAHV = I.MAHV AND KQ.LANTHI < I.LANTHI AND KQ.DIEM > 5
	)
	BEGIN
		PRINT('LOI: CHI DUOC THI LAI NEU DIEM THI < 5!')
		ROLLBACK TRANSACTION
	END 
	ELSE 
	BEGIN
		PRINT('THEM THANH CONG!')
	END 
END 
--21. Ngày thi của lần thi sau phải lớn hơn ngày thi của lần thi trước (cùng học viên, cùng môn học).
CREATE TRIGGER trg_upd_ngthi ON KETQUATHI
FOR INSERT, UPDATE
AS
BEGIN
	IF EXISTS (
		SELECT *
		FROM KETQUATHI KQ, INSERTED I 
		WHERE KQ.MAHV = I.MAHV AND KQ.MAMH = I.MAMH AND KQ.LANTHI < I.LANTHI AND KQ.NGTHI > I.NGTHI
	)
	BEGIN
		PRINT('LOI: NGAY THI KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END 
	ELSE 
	BEGIN
		PRINT('THEM THANH CONG!')
	END 
END 
USE QLGV
--22. Học viên chỉ được thi những môn mà lớp của học viên đó đã học xong.
CREATE TRIGGER trg_upd_thi ON KETQUATHI 
FOR INSERT, UPDATE
AS 
BEGIN
	IF EXISTS (
		SELECT *
		FROM GIANGDAY GD JOIN INSERTED I ON GD.MAMH = I.MAMH JOIN HOCVIEN HV ON HV.MAHV = I.MAHV
		WHERE  I.NGTHI < I.NGTHI
	)
	BEGIN
		PRINT('LOI: MON THI KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END
	ELSE 
	BEGIN
		PRINT('THEM THANH CONG!')
	END
END
--23. Khi phân công giảng dạy một môn học, phải xét đến thứ tự trước sau giữa các môn học (sau khi học xong những môn học phải học trước mới được học những môn liền sau).
CREATE TRIGGER trg_gday ON GIANGDAY 
FOR INSERT, UPDATE 
AS 
BEGIN 
	IF EXISTS (
		SELECT *
		FROM INSERTED I, DIEUKIEN DK 
		WHERE I.MAMH = DK.MAMH AND DK.MAMH_TRUOC IN (
			SELECT GD1.MAMH 
			FROM GIANGDAY GD1
			WHERE GD1.MAMH = DK.MAMH_TRUOC AND I.TUNGAY < GD1.DENNGAY
		)
	)
	BEGIN
		PRINT('LOI: MON THI KHONG HOP LE!')
		ROLLBACK TRANSACTION
	END
	ELSE 
	BEGIN
		PRINT('THEM THANH CONG!')
	END
END
use QLGV
--24. Giáo viên chỉ được phân công dạy những môn thuộc khoa giáo viên đó phụ trách.
CREATE TRIGGER trg_upd_GV ON GIANGDAY
FOR INSERT, UPDATE
AS 
BEGIN
	IF NOT EXISTS (
		SELECT * 
		FROM GIAOVIEN GV JOIN MONHOC MH ON GV.MAKHOA = MH.MAKHOA JOIN GIANGDAY GD ON GD.MAMH = MH.MAMH
	)
	BEGIN
		PRINT('LOI: GIAO VIEN CHI DAY NHUNG MON MA KHOA PHU TRACH!')
		ROLLBACK TRANSACTION
	END
	ELSE 
	BEGIN
		PRINT('THEM THANH CONG!')
	END
END
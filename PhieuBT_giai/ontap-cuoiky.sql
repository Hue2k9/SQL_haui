--Câu 2 a Hãy tạo hàm đưa ra MaVTu, TênVT, Đpn giá xuất, Số lượng xuất, Thành tiền (trong đó
-- Thành tiền=(SoLuongX*DonGiaX) theo ngày xuất và mavtu từ bàn phím
CREATE FUNCTION fn_cau2(@NgayX DATE, @MaVT CHAR(5))
RETURNS @tenbang TABLE (MaVT CHAR(5), TenVT NVARCHAR(50), DGX INT, SLX INT, ThanhTien INT)
AS
BEGIN
	INSERT @tenbang
		SELECT Ton.MaVTu, tenVTU, DonGiaX, SoLuongX,DonGiaX*SoLuongX 
		FROM Ton INNER JOIN Xuat ON Xuat.MAVTu = TON.MaVTu
		WHERE TON.MaVTu = @MaVT AND NgayX = @NgayX
	RETURN 
END
SELECT * FROM Ton 
SELECT * FROM Xuat 
SELECT * FROM dbo.fn_cau2('2020-2-15', 'VT01') -- không có dl thỏa mãn
SELECT * FROM dbo.fn_cau2('2021-04-25', 'VT001') -- có dư liệu
-- 2b Tạo 1 hàm tính tổng số lượng nhập của 1 vật tư với mã vật tư được nhập từ bàn phím.
CREATE FUNCTION fn_cau2b (@MaVT char(5))
RETURNS int
AS
BEGIN
	DECLARE @tong INT
	SELECT @tong = SUM(SoLuongN) FROM dbo.Nhap
	WHERE MAVTU = @MaVT
	RETURN @tong
END
SELECT * FROM Nhap
SELECT dbo.fn_cau2b('VT11') -- không có
SELECT dbo.fn_cau2b('VT002') 'tổng nhâpj' -- có dl
PRINT N'Tổng nhập là '+ CAST(dbo.fn_cau2b('VT002') AS CHAR(5))
--3a Hãy tạo thủ tục xóa 1 vật tư từ bảng Ton với tham biến truyền vào là mavt, hãy kiểm tra
--xem mavt đó có trong bảng Nhap, Xuat hay không? Nếu có thì không cho phép xóa ngược lại cho phép xóa.
CREATE PROC sp_Cau3a(@mavt char(5))
AS
BEGIN
	IF (EXISTS(SELECT * FROM Nhap WHERE MaVTu = @mavt)) 
	PRINT N'Mã vật tư này đã có trong bảng nhập nên không xóa được'
	ELSE 
		IF (EXISTS(SELECT * FROM Xuat WHERE MaVTu = @mavt)) 
		PRINT N'Mã vật tư này đã có trong bảng Xuat nên không xóa được'
		ELSE	
		DELETE FROM Ton WHERE MaVtu = @mavt
END

SELECT * FROM XUAT
SELECT * FROM Nhap 
SELECT * FROM Ton 

EXEC dbo.sp_Cau3a 'VT001' -- vật tư có trong bảng Nhâp
EXEC dbo.sp_Cau3a 'VT003' -- vật tư có trong bảng Xuât
INSERT Ton VALUES ('VT11', 'Máy giặt', 10)
EXEC dbo.sp_Cau3a 'VT11' 
--b. Viết thủ tục thêm mới 1 vật tư với mã vật tư, tên vật tư, số lượng tồn nhập từ bàn phím,
--nếu tên vật tư đó tồn tại trước đó hãy hiển thị thông báo, ngược lại cho phép thêm mới
CREATE PROC sp_cau3b (@MaVt char(5), @tenVT nvarchar(50), @slton int)
AS
BEGIN
	IF(EXISTS (SELECT * FROM Ton WHERE TenVTu = @tenVT))
		PRINT N'Tên này đã có, không chèn được'
	ELSE
		INSERT Ton VALUES (@Mavt, @TenVT, @slTon)
END 
SELECT * FROM Ton

EXEC sp_cau3b 'VT005', N'Khăn giấy', 10 -- tên vật tư đã có
EXEC sp_cau3b 'VT005', N'Khăn giấy đa năng', 10 -- tên vật tư chưa có
-- 3c Hãy viết thủ tục đưa ra MaVT,TenVT,SoLuongT của vật tư với tên vật tư được nhập từ
-- bàn phím, nếu tên tên vật tư không tồn tại hãy đưa ra thông báo.

Alter PROC sp_cau3c (@tenVT nvarchar(50))
AS
BEGIN
	IF(NOT EXISTS (SELECT * FROM Ton WHERE TenVTu = @tenVT))
		PRINT N'Tên vật tư này không có'
	ELSE
		SELECT maVtu, tenVTu, SoluongT
		FROM Ton 
		WHERE TenVTu = @tenVT
END 

EXEC sp_cau3c N'Khăn giấy' -- có dl
EXEC sp_cau3c N'Khăn giấy abc'-- không có dl
-- 4a Viết Triger Insert cho bảng Nhap sao cho khi nhập vật tư hợp lệ (MaVT ở bảng Nhap đã
có trong bảng Ton) thì số lượng ở bảng Ton được cập nhật tăng theo số lượng nhập. Trái
lại thì Roll Back đồng thời đưa ra thông báo cho người dùng biết “Mã VT chưa có mặt
trong bảng Ton“.

CREATE TRIGGER tg_Cau4a
ON Nhap
FOR INSERT
AS 
BEGIN
	IF (NOT EXISTS(SELECT * FROM Ton WHERE MaVTu = (SELECT MaVTu FROM Inserted))) 
	BEGIN
		RAISERROR (N'Mã VT chưa có mặt trong bảng Ton',16,1)
		ROLLBACK TRANSACTION
    END 
	UPDATE Ton 
		SET SoluongT = SoLuongT + (SELECT SoluongN FROM Inserted)
	WHERE MaVTu = (SELECT MaVTu FROM Inserted)
END  

SELECT * FROM dbo.Nhap
SELECT * FROM TOn
ALTER TABLE Nhap NOCHECK CONSTRAINT ALL 
INSERT Nhap VALUES ('PN004', 'VT006',10, 2000, '2022-2-25')--mã vật tư chưa có
INSERT Nhap VALUES ('PN005', 'VT001',10, 2000, '2022-2-25')

--4b Tạo Trigger Update trên bảng XUAT cập nhật lại số lượng xuất, kiểm tra xem nếu số lượng
xuất mới – số lượng xuất cũ <= số lượng tồn hay không? nếu thỏa mãn hãy cập nhật lại số
lượng trên bảng TON, ngược lại đưa ra thông báo.

CREATE TRIGGER tg_cau4b
ON Xuat
FOR UPDATE
AS 
BEGIN
	DECLARE @slcu INT, @slmoi int, @slton int
	SELECT @slcu = SoLuongX FROM Deleted
	SELECT @slmoi = SoLuongX FROM Inserted
	SELECT @slton = SOluongT FROM Ton WHERE MaVTu = (SELECT MaVtu FROM Inserted)
	IF @slmoi -@slcu > @slton 
	BEGIN
		RAISERROR ('Hàng không đủ',16,1)
		ROLLBACK TRANSACTION
    END 
	UPDATE dbo.TON
	SET SoluongT = SoLuongT - (@slmoi -@slcu)
	WHERE MaVTu = (SELECT MaVtu FROM Inserted)
END 
SELECT * FROM dbo.TON
SELECT * FROM Xuat

Update Xuat SET SoluongX = 20 WHERE SoHDX = 'Px001' AND MaVTu = 'VT001' -- tm

Update Xuat SET SoluongX = 200 WHERE SoHDX = 'Px001' AND MaVTu = 'VT001'-- sl k đủ
USE master;
GO
IF DB_ID('DBFinal') IS NOT NULL
BEGIN
    DROP DATABASE DBFinal;
END
GO
CREATE DATABASE DBFinal;
GO
USE DBFinal;
GO

-- Tạo bảng Account
CREATE TABLE Account(
    AccountID int identity(1, 1) primary key not null,
    Username varchar(50) not null,
    Password varchar(50) not null,
    Role varchar(10) check (Role in ('admin', 'waiter', 'cashier')) not null
);

-- Tạo bảng Staff
CREATE TABLE Staff(
    StaffID int primary key not null, 
    AccountID int not null,
    Name nvarchar(50) not null,
    Role varchar(10) check (Role in ('staff', 'manager')) not null,
    foreign key (AccountID) references Account(AccountID) on delete cascade on update no action
);

-- Tạo bảng Dish
CREATE TABLE Dish(
    DishID int identity(1, 1) primary key not null,
    DishName nvarchar(100) not null,
    Price money not null,
    Status varchar(10) check (Status in ('yes', 'no')) not null,
    ImageLink nvarchar(255) not null
);

-- Tạo bảng Table
CREATE TABLE [Table](
    TableID int primary key not null,
    TableStatus varchar(10) default 'available' check (TableStatus in ('available', 'occupied')) not null
);

-- Tạo bảng Order
CREATE TABLE [Order](
    OrderID int identity(1, 1) primary key not null,
    TableID int not null,
    OrderTime datetime default GETDATE(),
	OrderStatus nvarchar(20) default 'Not Yet' check (OrderStatus in ('Not Yet', 'Done')) not null
    foreign key (TableID) references [Table](TableID) 
);

-- Tạo bảng OrderDetail
CREATE TABLE OrderDetail(
    OrderDetailID int identity(1, 1) primary key not null,
    OrderID int not null,
    DishID int not null,
    Quantity int not null,
    Price money not null,
	-- update
    Status nvarchar(50) default 'Waiting' check (Status in ('Waiting', 'Served', 'Not Served')),
	Urgent bit DEFAULT 0 not null,
    foreign key (OrderID) references [Order](OrderID) on delete cascade on update no action,
    foreign key (DishID) references Dish(DishID) on delete no action on update no action
);

-- Tạo bảng Bill
CREATE TABLE Bill(
    BillID int identity(1, 1) primary key not null,
    TableID INT NOT NULL,                  
    DishID INT NOT NULL,                   
    Quantity INT NOT NULL,                 
    Price money NOT NULL,        
    TotalAmount AS (Quantity * Price) PERSISTED, 
    BillTime DATETIME DEFAULT GETDATE(),
    foreign key (TableID) REFERENCES [dbo].[Table](TableID),  
    foreign key (DishID) REFERENCES [dbo].[Dish](DishID)
);

-------------INSERT DATA-------------
-- Chèn dữ liệu vào bảng Account
INSERT INTO Account (Username, Password, Role)
VALUES 
    ('khanhnd', 'he186956', 'admin'),
    ('nghiatt', 'he180517', 'cashier'),
    ('truongtq', 'he186765', 'waiter'),
    ('trungnm', 'he186069', 'waiter'),
    ('sondp', 'he182318', 'waiter');

-- Chèn dữ liệu vào bảng Staff
INSERT INTO Staff (StaffID, AccountID, Name, Role)
VALUES 
    (186956, 1, N'Nguyễn Duy Khánh', 'manager'), 
    (180517, 2, N'Trần Tình Nghĩa', 'staff'),
    (186765, 3, N'Trương Quốc Trường', 'staff'),
    (186069, 4, N'Nguyễn Mạnh Trung', 'staff'),
    (182318, 5, N'Đinh Phúc Sơn', 'staff');

-- Chèn dữ liệu vào bảng Dish
INSERT INTO Dish (DishName, Price, Status, ImageLink)
VALUES 
    (N'Chả Giò Ngon', 125000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/cha-gio-ngon1524754463.jpg&w=600&h=480&zc=2&q=85'),
    (N'Nem Cua Bể Hải Phòng', 155000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/nem-cua-be-hai-phong1524754311.jpg&w=600&h=480&zc=2&q=85'),
    (N'Bánh Tôm Hồ Tây', 95000, 'no', 'https://quanngon138.com/timthumb.php?src=upload/product/banh-tom-ho-tay1524750611.jpg&w=600&h=480&zc=2&q=85'),
    (N'Chả Mực Hạ Long', 205000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/cha-muc-ha-long1524750448.jpg&w=600&h=480&zc=2&q=85'),
    (N'Cá Trứng Tẩm Bột Chiên Giòn', 105000, 'no', 'https://quanngon138.com/timthumb.php?src=upload/product/ca-trung-tam-bot-chien-gion1520413932.jpg&w=600&h=480&zc=2&q=85'),
    (N'Chả cá thác lác chiên', 200000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/cha-ca-thac-lac-chien1524750346.jpg&w=600&h=480&zc=2&q=85'),
    (N'Súp Cua', 40000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/sup-cua1520414593.jpg&w=600&h=480&zc=2&q=85'),
    (N'Há Cảo Xíu Mại Tôm Thịt', 135000, 'no', 'https://quanngon138.com/timthumb.php?src=upload/product/ha-cao-xiu-mai-tom-thit1524738461.JPG&w=600&h=480&zc=2&q=85'),
    (N'Lạc Rang Húng Lìu', 35000, 'yes', 'https://quanngon138.com/timthumb.php?src=upload/product/lac-rang-hung-liu1520414853.jpg&w=600&h=480&zc=2&q=85'),
    (N'Khoai Tây Chiên Bơ', 95000, 'no', 'https://quanngon138.com/timthumb.php?src=upload/product/khoai-tay-chien-bo1524738432.jpg&w=600&h=480&zc=2&q=85');

-- Chèn dữ liệu vào bảng Table (chèn trước bảng Order)
INSERT INTO [Table] (TableID, TableStatus)
VALUES 
    (1, 'occupied'),  
    (2, 'available'),
    (3, 'occupied'),  
    (4, 'available'),
    (5, 'occupied'),  
    (6, 'available'),
    (7, 'occupied'),  
    (8, 'available'),
    (9, 'occupied'),  
    (10, 'available');


-- Chèn dữ liệu vào bảng Order (chèn trước bảng OrderDetail)
INSERT INTO [Order] (TableID)
VALUES 
    (1),  
    (2),  
    (3),  
    (4), 
    (5),  
    (6),  
    (7),  
    (8),  
    (9),  
    (10),
	(1);

-- Chèn dữ liệu vào bảng OrderDetail
INSERT INTO OrderDetail (OrderID, DishID, Quantity, Price)
VALUES 
    (1, 1, 3, 125000), 
    (2, 2, 2, 155000), 
    (3, 3, 1, 95000),  
    (4, 4, 4, 205000),  
    (5, 5, 2, 105000),  
    (6, 6, 1, 200000),  
    (7, 7, 5, 40000),  
    (8, 8, 3, 135000),  
    (9, 9, 4, 35000),  
    (10, 10, 2, 95000),
	(11, 1, 2, 125000),
	(11, 3, 2, 95000);

-- Chèn dữ liệu vào bảng Bill
INSERT INTO Bill (TableID, DishID, Quantity, Price)
VALUES 
    (1, 1, 3, 125000),  
    (2, 2, 2, 155000),  
    (3, 3, 1, 95000),  
    (4, 4, 4, 205000),  
    (5, 5, 2, 105000);
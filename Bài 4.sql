CREATE DATABASE productsManager;
USE productsManager;

CREATE TABLE ORDERS (
    OrderID INT PRIMARY KEY AUTO_INCREMENT,
    CustomerName VARCHAR(100),
    OrderDate DATETIME,
    TotalAmount DECIMAL(18, 2),
    Status VARCHAR(20), -- 'Completed', 'Canceled', 'Pending'
    IsDeleted TINYINT(1) DEFAULT 0
);

INSERT INTO ORDERS (CustomerName, OrderDate, TotalAmount, Status) VALUES
('Nguyen Van A', '2023-01-10', 500000, 'Completed'),
('Khach hang vang lai', '2023-02-15', 1200000, 'Canceled'),
('Tran Thi B', '2023-05-20', 300000, 'Canceled'),
('Le Van C', '2024-01-05', 850000, 'Completed');

UPDATE ORDERS
SET IsDeleted = 1
WHERE Status = 'Canceled';

SELECT OrderID, CustomerName, OrderDate, TotalAmount
FROM ORDERS
WHERE Status = 'Completed'
  AND IsDeleted = 0;
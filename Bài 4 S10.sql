CREATE DATABASE PharmacyDB;
USE PharmacyDB;

CREATE TABLE Pharmacy_Inventory (
    Inventory_ID INT AUTO_INCREMENT PRIMARY KEY,
    Drug_Name VARCHAR(255),
    Batch_Number VARCHAR(50),
    Expiry_Date DATE,
    Quantity INT
);

INSERT INTO Pharmacy_Inventory
(Drug_Name, Batch_Number, Expiry_Date, Quantity)
VALUES
('Paracetamol', 'B001', '2026-12-01', 500),
('Paracetamol', 'B002', '2025-10-15', 300),
('Amoxicillin', 'B003', '2025-08-20', 200),
('Vitamin C', 'B004', '2027-01-10', 700),
('Paracetamol Extra', 'B005', '2025-06-01', 150);

CREATE INDEX idx_drug_name
ON Pharmacy_Inventory(Drug_Name);

CREATE INDEX idx_expiry_date
ON Pharmacy_Inventory(Expiry_Date);

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date = '2025-10-15';

DROP INDEX idx_drug_name ON Pharmacy_Inventory;
DROP INDEX idx_expiry_date ON Pharmacy_Inventory;

CREATE INDEX idx_drug_expiry
ON Pharmacy_Inventory(Drug_Name, Expiry_Date);

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name = 'Paracetamol'
AND Expiry_Date = '2025-10-15';

SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE 'Para%';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE 'Para%';

SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%cetamol%';

EXPLAIN
SELECT *
FROM Pharmacy_Inventory
WHERE Drug_Name LIKE '%cetamol%';

ALTER TABLE Pharmacy_Inventory
ADD FULLTEXT(Drug_Name);

SELECT *
FROM Pharmacy_Inventory
WHERE MATCH(Drug_Name)
AGAINST('Paracetamol');
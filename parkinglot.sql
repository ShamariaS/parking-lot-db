CREATE DATABASE parkinglot_db;
USE parkinglot_db;
CREATE TABLE Parking_Spots (
spotID INT AUTO_INCREMENT PRIMARY KEY,
SpotNumber VARCHAR(20) UNIQUE,
SpotType ENUM('Two-Wheeler', 'Four-Wheeler', 'Electric', 'Handicap'),
IsOccupied BOOLEAN DEFAULT FALSE
);
CREATE TABLE Vehicles (
    VehicleID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleNumber VARCHAR(20) UNIQUE,
    VehicleType ENUM('Two-Wheeler', 'Four-Wheeler'),
    OwnerName VARCHAR(100),
    Phone VARCHAR(15)
);
CREATE TABLE ParkingRecords (
    RecordID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleID INT,
    SpotID INT,
    EntryTime DATETIME,
    ExitTime DATETIME,
    Duration INT, 
    TotalAmount DECIMAL(10,2)
    );
CREATE TABLE Rates (
    RateID INT AUTO_INCREMENT PRIMARY KEY,
    VehicleType ENUM('Two-Wheeler', 'Four-Wheeler', 'Electric', 'Handicap') NOT NULL,
    RatePerHour DECIMAL(10,2) NOT NULL
);
    CREATE TABLE Payments (
    PaymentID INT AUTO_INCREMENT PRIMARY KEY,
    RecordID INT,
    PaymentTime DATETIME DEFAULT CURRENT_TIMESTAMP,
    AmountPaid DECIMAL(10,2),
    PaymentMethod ENUM('Cash', 'Card', 'UPI')
);
SHOW TABLES;

SELECT ps.SpotNumber, v.VehicleNumber, v.OwnerName, v.VehicleType
FROM Parking_Spots ps
JOIN ParkingRecords pr ON ps.SpotID = pr.SpotID
JOIN Vehicles v ON pr.VehicleID = v.VehicleID
WHERE ps.IsOccupied = TRUE AND pr.ExitTime IS NULL;

SELECT SUM(AmountPaid) AS TotalRevenue
FROM Payments
WHERE PaymentTime >= NOW() - INTERVAL 7 DAY;

SELECT v.VehicleType, AVG(pr.Duration) AS AvgDuration
FROM ParkingRecords pr
JOIN Vehicles v ON pr.VehicleID = v.VehicleID
WHERE pr.Duration IS NOT NULL
GROUP BY v.VehicleType;

SELECT v.VehicleNumber, v.OwnerName
FROM ParkingRecords pr
JOIN Vehicles v ON pr.VehicleID = v.VehicleID
WHERE pr.ExitTime IS NULL;

SELECT SpotType, COUNT(*) AS AvailableSpots
FROM Parking_Spots
WHERE IsOccupied = FALSE
GROUP BY SpotType;
#DATA INSERTION
INSERT INTO Parking_Spots (SpotNumber, SpotType, IsOccupied) VALUES
('P1', 'Four-Wheeler', TRUE),
('P2', 'Two-Wheeler', TRUE),
('P3', 'Four-Wheeler', TRUE),
('P4', 'Electric', FALSE),
('P5', 'Two-Wheeler', FALSE),
('P6', 'Four-Wheeler', TRUE),
('P7', 'Handicap', FALSE),
('P8', 'Four-Wheeler', FALSE),
('P9', 'Handicap', TRUE),
('P10', 'Two-Wheeler', TRUE),
('P11', 'Electric', TRUE),
('P12', 'Four-Wheeler', TRUE),
('P13', 'Electric', FALSE),
('P14', 'Electric', TRUE),
('P15', 'Four-Wheeler', TRUE),
('P16', 'Two-Wheeler', FALSE),
('P17', 'Four-Wheeler', FALSE),
('P18', 'Electric', TRUE),
('P19', 'Two-Wheeler', FALSE),
('P20', 'Handicap', FALSE);
SELECT * FROM Parking_Spots;
INSERT INTO Vehicles (VehicleNUmber, VehicleType, OwnerName, Phone) VALUES
('ABC1203456', 'Four-Wheeler', 'Shamaria Jones', '8031234567'),
('DEF4567890', 'Two-Wheeler', 'Kiara Mikel', '1234567891'),
('GHI1AB9012', 'Four-Wheeler', 'Ty Johnson', '8034567892'),
('JKL1AB3456', 'Two-Wheeler', 'Khalil Hart', '8034567893'),
('MNO1AB7890', 'Four-Wheeler', 'Tyler Brown', '8034567894'),
('PQR1AB1122', 'Two-Wheeler', 'Emma Green', '3084567895'),
('STU1AB3344', 'Four-Wheeler', 'Frank Jones', '3084567896'),
('VWX1AB5566', 'Two-Wheeler', 'Tina Myers', '3084567897'),
('YYZ1AB7788', 'Four-Wheeler', 'Chloe Williams', '3084567898'),
('SNS1AB9900', 'Two-Wheeler', 'Taylor Swift', '8034567899');
SELECT * FROM Vehicles;
INSERT INTO ParkingRecords (VehicleID, SpotID, EntryTime, ExitTime, Duration, TotalAmount)
VALUES 
(1, 22, '2025-04-20 08:00:00', '2025-04-20 10:00:00', 120, 10.00),
(2, 23, '2025-04-20 09:15:00', NULL, NULL, NULL), -- still parked
(3, 24, '2025-04-20 07:00:00', '2025-04-20 09:30:00', 150, 12.50),
(4, 25, '2025-04-19 12:00:00', '2025-04-19 14:00:00', 120, 10.00),
(5, 26, '2025-04-20 11:00:00', NULL, NULL, NULL), -- still parked
(6, 27, '2025-04-18 18:00:00', '2025-04-18 19:00:00', 60, 5.00),
(7, 28, '2025-04-20 08:30:00', NULL, NULL, NULL), -- still parked
(8, 29, '2025-04-19 09:45:00', '2025-04-19 11:00:00', 75, 6.25),
(9, 30, '2025-04-20 07:45:00', NULL, NULL, NULL), -- still parked
(10, 31, '2025-04-17 13:00:00', '2025-04-17 15:00:00', 120, 10.00),
(1, 32, '2025-04-16 10:30:00', '2025-04-16 11:30:00', 60, 5.00),
(2, 33, '2025-04-15 16:00:00', '2025-04-15 18:30:00', 150, 12.50),
(3, 34, '2025-04-14 14:00:00', '2025-04-14 16:00:00', 120, 10.00),
(4, 35, '2025-04-13 10:15:00', '2025-04-13 11:15:00', 60, 5.00),
(5, 36, '2025-04-12 12:30:00', '2025-04-12 13:30:00', 60, 5.00);
SELECT * FROM ParkingRecords;
INSERT INTO Rates (VehicleType, RatePerHour) VALUES
('Two-Wheeler', 3.00),
('Four-Wheeler', 5.00);
SELECT * FROM Rates;
INSERT INTO Payments (RecordID, PaymentTime, AmountPaid, PaymentMethod)
VALUES
(1, '2025-04-23 08:15:00', 5.00, 'Card'),
(2, '2025-04-23 09:10:00', 7.50, 'Cash'),
(3, '2025-04-22 14:00:00', 10.00, 'Paypal'),
(4, '2025-04-22 15:30:00', 6.25, 'Cash'),
(5, '2025-04-22 17:45:00', 8.00, 'Card'),
(6, '2025-04-21 10:05:00', 9.50, 'Paypal'),
(7, '2025-04-21 12:20:00', 4.00, 'Card'),
(8, '2025-04-20 14:10:00', 7.75, 'Cash'),
(9, '2025-04-20 16:35:00', 11.00, 'Card'),
(10, '2025-04-20 18:25:00', 9.00, 'Paypal');

#FUNCTIONAL SQL REQUIREMENTS
INSERT INTO ParkingRecords (VehicleID, SpotID, EntryTime) 
VALUES (3, 25, NOW());
UPDATE Parking_Spots 
SET IsOccupied = 1 
WHERE SpotID = 25;
UPDATE ParkingRecords 
SET ExitTime = NOW(), 
    Duration = TIMESTAMPDIFF(MINUTE, EntryTime, NOW()) 
WHERE RecordID = 12;
UPDATE ParkingRecords 
SET TotalAmount = ROUND(Duration / 60 * (
    SELECT RatePerHour 
    FROM Rates 
    WHERE VehicleType = (
        SELECT VehicleType 
        FROM Vehicles 
        WHERE VehicleID = ParkingRecords.VehicleID
    )
), 2) 
WHERE RecordID = 12;
INSERT INTO Payments (RecordID, PaymentTime, AmountPaid, PaymentMethod) 
VALUES (12, NOW(), 100.00, 'Card');

#REPORT & ANALYTICS QURIES 
SELECT SpotNumber, SpotType, CASE WHEN IsOccupied = 1 THEN 'Occupied' ELSE 
'Available' END AS Status FROM Parking_Spots;

SELECT v.VehicleNumber, v.OwnerName, p.EntryTime, s.SpotNumber FROM ParkingRecords 
p JOIN Vehicles v ON p.VehicleID = v.VehicleID JOIN Parking_Spots s ON p.SpotID = 
s.SpotID WHERE p.ExitTime IS NULL;

SELECT SpotType, COUNT(*) AS AvailableSpots FROM Parking_Spots WHERE IsOccupied = 
0 GROUP BY SpotType; 

SELECT v.VehicleNumber, TIMESTAMPDIFF(MINUTE, p.EntryTime, p.ExitTime) AS 
DurationMinutes, ROUND(TIMESTAMPDIFF(HOUR, p.EntryTime, p.ExitTime) * 
r.RatePerHour, 2) AS Amount FROM ParkingRecords p JOIN Vehicles v ON p.VehicleID = 
v.VehicleID JOIN Rates r ON v.VehicleType = r.VehicleType WHERE p.ExitTime IS NOT 
NULL;

SELECT v.VehicleNumber, TIMESTAMPDIFF(MINUTE, EntryTime, ExitTime) AS 
DurationMinutes FROM ParkingRecords p JOIN Vehicles v ON p.VehicleID = v.VehicleID 
WHERE p.ExitTime IS NOT NULL ORDER BY DurationMinutes DESC LIMIT 3;

SELECT DATE(PaymentTime) AS Date, SUM(AmountPaid) AS TotalEarned FROM Payments 
WHERE PaymentTime >= CURDATE() - INTERVAL 7 DAY GROUP BY 
DATE(PaymentTime);

SELECT v.VehicleType, ROUND(AVG(TIMESTAMPDIFF(MINUTE, p.EntryTime, 
p.ExitTime)), 2) AS AvgDuration FROM ParkingRecords p JOIN Vehicles v ON p.VehicleID = 
v.VehicleID WHERE p.ExitTime IS NOT NULL GROUP BY v.VehicleType;

SELECT OwnerName, COUNT(*) AS TotalVisits FROM Vehicles v JOIN ParkingRecords p 
ON v.VehicleID = p.VehicleID GROUP BY OwnerName ORDER BY TotalVisits DESC 
LIMIT 5;

SELECT DATE(EntryTime) AS Date, COUNT(*) AS VehiclesParked, SUM(TotalAmount) AS 
Revenue, ROUND(AVG(Duration), 2) AS AvgDuration FROM ParkingRecords WHERE 
EntryTime >= CURDATE() - INTERVAL 7 DAY GROUP BY DATE(EntryTime);



























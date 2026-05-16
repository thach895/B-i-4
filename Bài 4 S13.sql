CREATE DATABASE IF NOT EXISTS RikkeiClinicDB;
USE RikkeiClinicDB;

CREATE TABLE Appointments (
    appointment_id INT PRIMARY KEY AUTO_INCREMENT,
    patient_name VARCHAR(100) NOT NULL,
    doctor_name VARCHAR(100) NOT NULL,
    appointment_date DATETIME NOT NULL,
    status VARCHAR(20) NOT NULL
);

INSERT INTO Appointments
(patient_name, doctor_name, appointment_date, status)
VALUES
('Nguyen Van A', 'Dr. Minh', '2026-07-10 08:00:00', 'Pending'),
('Tran Thi B', 'Dr. Minh', '2026-07-10 09:00:00', 'Cancelled'),
('Le Van C', 'Dr. Huy', '2026-07-10 10:00:00', 'Pending');

DELIMITER $$

CREATE TRIGGER trg_prevent_double_booking_insert
BEFORE INSERT
ON Appointments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE doctor_name = NEW.doctor_name
        AND appointment_date = NEW.appointment_date
        AND status <> 'Cancelled'
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END $$

DELIMITER ;

DELIMITER $$

CREATE TRIGGER trg_prevent_double_booking_update
BEFORE UPDATE
ON Appointments
FOR EACH ROW
BEGIN
    IF EXISTS (
        SELECT 1
        FROM Appointments
        WHERE doctor_name = NEW.doctor_name
        AND appointment_date = NEW.appointment_date
        AND status <> 'Cancelled'
        AND appointment_id <> OLD.appointment_id
    ) THEN
        SIGNAL SQLSTATE '45000'
        SET MESSAGE_TEXT = 'Lỗi: Bác sĩ đã có lịch hẹn vào khung giờ này';
    END IF;
END $$

DELIMITER ;

INSERT INTO Appointments
(patient_name, doctor_name, appointment_date, status)
VALUES
('Pham Thi D', 'Dr. Minh', '2026-07-10 11:00:00', 'Pending');

INSERT INTO Appointments
(patient_name, doctor_name, appointment_date, status)
VALUES
('Hoang Van E', 'Dr. Minh', '2026-07-10 08:00:00', 'Pending');

INSERT INTO Appointments
(patient_name, doctor_name, appointment_date, status)
VALUES
('Le Thi F', 'Dr. Minh', '2026-07-10 09:00:00', 'Pending');

UPDATE Appointments
SET status = 'Completed'
WHERE appointment_id = 1;

SELECT * FROM Appointments;
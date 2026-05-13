DELIMITER //
CREATE PROCEDURE GetPatientDebt(
    IN p_patient_id INT,
    IN p_phone VARCHAR(15),
    OUT p_total_due DECIMAL(18,2),
    OUT p_message VARCHAR(100)
)
BEGIN
    IF p_patient_id IS NULL AND p_phone IS NULL THEN
        SET p_total_due = 0;
        SET p_message = 'Lỗi: Phải nhập ID hoặc số điện thoại';
    ELSEIF p_patient_id IS NOT NULL THEN
        SELECT pi.total_due
        INTO p_total_due
        FROM Patient_Invoices pi
        WHERE pi.patient_id = p_patient_id;
        IF p_total_due IS NULL THEN
            SET p_total_due = 0;
            SET p_message = 'Không tìm thấy bệnh nhân';
        ELSE
            SET p_message = 'Tra cứu thành công';
        END IF;
    ELSEIF p_phone IS NOT NULL THEN
        SELECT pi.total_due
        INTO p_total_due
        FROM Patients p
        JOIN Patient_Invoices pi
            ON p.patient_id = pi.patient_id
        WHERE p.phone = p_phone;
        IF p_total_due IS NULL THEN
            SET p_total_due = 0;
            SET p_message = 'Không tìm thấy bệnh nhân';
        ELSE
            SET p_message = 'Tra cứu thành công';
        END IF;
    END IF;
END //
DELIMITER ;
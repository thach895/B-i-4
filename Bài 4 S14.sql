DELIMITER //

CREATE PROCEDURE PayHospitalFee(
    IN p_patient_id INT,
    IN p_amount DECIMAL(18,2),
    OUT p_message VARCHAR(255)
)
BEGIN

    DECLARE v_balance DECIMAL(18,2);

    -- Bắt lỗi SQL
    DECLARE EXIT HANDLER FOR SQLEXCEPTION
    BEGIN
        ROLLBACK;

        SET p_message = 'Lỗi: Giao dịch thất bại';
    END;

    START TRANSACTION;

    -- Kiểm tra số tiền hợp lệ
    IF p_amount <= 0 THEN

        ROLLBACK;

        SET p_message = 'Lỗi: Số tiền thanh toán không hợp lệ';

    ELSE

        -- Lấy số dư ví
        SELECT balance
        INTO v_balance
        FROM Wallets
        WHERE patient_id = p_patient_id;

        -- Kiểm tra đủ tiền
        IF v_balance >= p_amount THEN

            -- Trừ tiền ví
            UPDATE Wallets
            SET balance = balance - p_amount
            WHERE patient_id = p_patient_id;

            -- Giảm công nợ
            UPDATE Patient_Invoices
            SET total_due = total_due - p_amount
            WHERE patient_id = p_patient_id;

            COMMIT;

            SET p_message = 'Thanh toán thành công';

        ELSE

            ROLLBACK;

            SET p_message = 'Lỗi: Số dư ví không đủ';

        END IF;

    END IF;

END //

DELIMITER ;
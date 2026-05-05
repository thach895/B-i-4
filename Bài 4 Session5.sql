SELECT order_id, customer_id, status, cancel_reason
FROM Orders
WHERE cancel_reason = 'KHACH_HUY'
   OR cancel_reason = 'QUAN_DONG_CUA'
   OR cancel_reason = 'KHONG_CO_TAI_XE'
   OR cancel_reason = 'BOM_HANG';
   
SELECT order_id, customer_id, status, cancel_reason
FROM Orders
WHERE cancel_reason IN (
    'KHACH_HUY',
    'QUAN_DONG_CUA',
    'KHONG_CO_TAI_XE',
    'BOM_HANG'
);
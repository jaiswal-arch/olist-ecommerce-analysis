CREATE VIEW `e-commerece-489804.ECommerce.monthly_revenue` AS
SELECT 
 FORMAT_DATE('%Y-%m', o.order_purchase_timestamp) AS month,
 ROUND(SUM(op.payment_value), 2) AS total_revenue,
 COUNT(DISTINCT o.order_id) AS total_orders
FROM `ECommerce.Orders`as o JOIN `ECommerce.Order_payments` as op 
ON o.order_id=op.order_id
WHERE o.order_status='delivered'
GROUP BY month
ORDER BY month;
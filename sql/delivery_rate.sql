CREATE VIEW `e-commerece-489804.ECommerce.delivery_rate` AS
SELECT
  COUNTIF(order_delivered_customer_date <= order_estimated_delivery_date) AS on_time,
  COUNTIF(order_delivered_customer_date > order_estimated_delivery_date) AS late,
  COUNT(*) AS total_delivered,
  ROUND(COUNTIF(order_delivered_customer_date <= order_estimated_delivery_date) * 100.0 
    / COUNT(*), 2) AS on_time_pct,
  ROUND(COUNTIF(order_delivered_customer_date > order_estimated_delivery_date) * 100.0 
    / COUNT(*), 2) AS late_pct  
FROM `ECommerce.Orders`
WHERE order_status = 'delivered'
  AND order_delivered_customer_date IS NOT NULL
  AND order_estimated_delivery_date IS NOT NULL;
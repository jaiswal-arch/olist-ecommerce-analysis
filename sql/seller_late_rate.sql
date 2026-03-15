CREATE VIEW `e-commerece-489804.ECommerce.seller_late_rate` AS
SELECT
  oi.seller_id,
  COUNT(DISTINCT o.order_id) AS total_orders,
  COUNTIF(o.order_delivered_customer_date > o.order_estimated_delivery_date) AS late_orders,
  ROUND(COUNTIF(o.order_delivered_customer_date > o.order_estimated_delivery_date) * 100.0
    / COUNT(DISTINCT o.order_id), 2) AS late_rate_pct
FROM `ECommerce.Orders` o
JOIN `ECommerce.Order_items` oi ON o.order_id = oi.order_id
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
  AND o.order_estimated_delivery_date IS NOT NULL
GROUP BY oi.seller_id
HAVING total_orders >= 20  -- filters out sellers with too few orders to be meaningful
ORDER BY late_rate_pct DESC
LIMIT 20;
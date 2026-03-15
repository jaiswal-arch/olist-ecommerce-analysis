CREATE VIEW `e-commerece-489804.ECommerce.repeat_purchase_rate` AS
WITH customer_order_counts AS (
  SELECT
    c.customer_unique_id,
    COUNT(DISTINCT o.order_id) AS total_orders
  FROM `ECommerce.Customers` c
  JOIN `ECommerce.Orders` o ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
)
SELECT
  COUNTIF(total_orders = 1) AS one_time_customers,
  COUNTIF(total_orders > 1) AS repeat_customers,
  COUNT(*) AS total_customers,
  ROUND(COUNTIF(total_orders > 1) * 100.0 / COUNT(*), 2) AS repeat_rate_pct
FROM customer_order_counts;
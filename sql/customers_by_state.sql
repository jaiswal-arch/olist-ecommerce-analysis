CREATE VIEW `e-commerece-489804.ECommerce.customers_by_state` AS
SELECT
  c.customer_state,
  COUNT(DISTINCT c.customer_id) AS total_customers,
  ROUND(COUNT(DISTINCT c.customer_id) * 100.0 /
    SUM(COUNT(DISTINCT c.customer_id)) OVER(), 2) AS pct_of_total
FROM `ECommerce.Customers` c
JOIN `ECommerce.Orders` o ON c.customer_id = o.customer_id
WHERE o.order_status = 'delivered'
GROUP BY c.customer_state
ORDER BY total_customers DESC;
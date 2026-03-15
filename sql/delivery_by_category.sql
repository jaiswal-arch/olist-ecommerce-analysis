CREATE VIEW `e-commerece-489804.ECommerce.delivery_by_category` AS
SELECT
  pc.string_field_1 AS category,
  COUNT(DISTINCT o.order_id) AS total_orders,
  ROUND(AVG(
    DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)
  ), 1) AS avg_delivery_days,
  ROUND(MAX(
    DATE_DIFF(o.order_delivered_customer_date, o.order_purchase_timestamp, DAY)
  ), 1) AS max_delivery_days
FROM `ECommerce.Orders` o
JOIN `ECommerce.Order_items` oi ON o.order_id = oi.order_id
JOIN `ECommerce.Products` p ON oi.product_id = p.product_id
JOIN `ECommerce.Product_category` pc
  ON p.product_category_name = pc.string_field_0
WHERE o.order_status = 'delivered'
  AND o.order_delivered_customer_date IS NOT NULL
GROUP BY category
ORDER BY avg_delivery_days DESC
LIMIT 15;
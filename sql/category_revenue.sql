CREATE VIEW `e-commerece-489804.ECommerce.category_revenue` AS
SELECT 
  pc.string_field_1 as category,
  ROUND(SUM(op.payment_value), 2) AS total_revenue,
  COUNT(DISTINCT o.order_id) AS total_orders
FROM `ECommerce.Orders` o
JOIN `ECommerce.Order_items` oi ON o.order_id=oi.order_id
JOIN `ECommerce.Products` p ON p.product_id=oi.product_id
JOIN `ECommerce.Order_payments` op ON op.order_id=o.order_id
JOIN `ECommerce.Product_category` pc ON p.product_category_name=string_field_0
WHERE o.order_status='delivered'
GROUP BY category
ORDER BY total_revenue DESC
LIMIT 15;
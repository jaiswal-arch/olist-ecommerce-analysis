CREATE OR REPLACE VIEW `e-commerece-489804.ECommerce.avg_order_value` AS
SELECT
  pc.string_field_1 as category,
  SUM(op.payment_value) / COUNT(DISTINCT o.order_id) AS avg_order_value
FROM `ECommerce.Orders` o 
JOIN `ECommerce.Order_items` oi ON o.order_id=oi.order_id
JOIN `ECommerce.Products` p ON p.product_id=oi.product_id
JOIN `ECommerce.Order_payments` op ON op.order_id=o.order_id
JOIN `ECommerce.Product_category` pc ON p.product_category_name = pc.string_field_0
WHERE o.order_status = 'delivered'
GROUP BY category
ORDER BY avg_order_value DESC
LIMIT 15; 
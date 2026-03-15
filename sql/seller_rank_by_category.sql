CREATE VIEW `e-commerece-489804.ECommerce.seller_rank_by_category` AS
WITH seller_category_revenue AS (
  SELECT
    oi.seller_id,
    pc.string_field_1 AS category_english,
    ROUND(SUM(op.payment_value), 2) AS total_revenue,
    COUNT(DISTINCT o.order_id) AS total_orders
  FROM `ECommerce.Orders` o
  JOIN `ECommerce.Order_items` oi ON o.order_id = oi.order_id
  JOIN `ECommerce.Products` pr ON oi.product_id = pr.product_id
  JOIN `ECommerce.Order_payments` op ON o.order_id = op.order_id
  JOIN `ECommerce.Product_category` pc
    ON pr.product_category_name = pc.string_field_0
  WHERE o.order_status = 'delivered'
  GROUP BY oi.seller_id, category_english
)
SELECT
  seller_id,
  category_english,
  total_revenue,
  total_orders,
  RANK() OVER (PARTITION BY category_english ORDER BY total_revenue DESC) AS rank_in_category
FROM seller_category_revenue
QUALIFY rank_in_category <= 3  -- top 3 sellers per category
ORDER BY category_english, rank_in_category;

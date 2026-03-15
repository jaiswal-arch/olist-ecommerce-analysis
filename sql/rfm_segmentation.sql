CREATE VIEW `e-commerece-489804.ECommerce.rfm_segmentation` AS
WITH rfm_base AS (
  SELECT
    c.customer_unique_id,
    DATE_DIFF(DATE '2018-10-01', MAX(DATE(o.order_purchase_timestamp)), DAY) AS recency,
    COUNT(DISTINCT o.order_id) AS frequency,
    ROUND(SUM(op.payment_value), 2) AS monetary
  FROM `ECommerce.Customers` c
  JOIN `ECommerce.Orders` o ON c.customer_id = o.customer_id
  JOIN `ECommerce.Order_payments` op ON o.order_id = op.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY c.customer_unique_id
),
rfm_scored AS (
  SELECT
    customer_unique_id,
    recency,
    frequency,
    monetary,
    NTILE(3) OVER (ORDER BY recency ASC) AS r_score,   -- lower recency = better
    NTILE(3) OVER (ORDER BY frequency DESC) AS f_score,
    NTILE(3) OVER (ORDER BY monetary DESC) AS m_score
  FROM rfm_base
)
SELECT
  customer_unique_id,
  recency,
  frequency,
  monetary,
  r_score,
  f_score,
  m_score,
  CASE
    WHEN r_score = 3 AND f_score = 3 AND m_score = 3 THEN 'High Value'
    WHEN r_score >= 2 AND f_score >= 2 THEN 'Mid Value'
    ELSE 'Low Value'
  END AS customer_segment
FROM rfm_scored
ORDER BY monetary DESC;
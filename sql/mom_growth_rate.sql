CREATE VIEW `e-commerece-489804.ECommerce.mom_growth_rate` AS
WITH monthly_revenue AS (
  SELECT
    FORMAT_DATE('%Y-%m', o.order_purchase_timestamp) AS month,
    ROUND(SUM(op.payment_value), 2) AS total_revenue
  FROM `ECommerce.Orders` o
  JOIN `ECommerce.Order_payments` op ON o.order_id = op.order_id
  WHERE o.order_status = 'delivered'
  GROUP BY month
)
SELECT
  month,
  total_revenue,
  LAG(total_revenue) OVER (ORDER BY month) AS prev_month_revenue,
  ROUND(
    (total_revenue - LAG(total_revenue) OVER (ORDER BY month)) * 100.0
    / LAG(total_revenue) OVER (ORDER BY month), 2
  ) AS mom_growth_pct
FROM monthly_revenue
ORDER BY month;
CREATE VIEW `e-commerece-489804.ECommerce.cohort_retention` AS
WITH cohort_base AS (
  SELECT
    c.customer_unique_id,
    FORMAT_DATE('%Y-%m', o.order_purchase_timestamp) AS order_month,
    MIN(FORMAT_DATE('%Y-%m', o.order_purchase_timestamp)) 
      OVER (PARTITION BY c.customer_unique_id) AS cohort_month
  FROM `ECommerce.Customers` c
  JOIN `ECommerce.Orders` o ON c.customer_id = o.customer_id
  WHERE o.order_status = 'delivered'
),
cohort_data AS (
  SELECT
    customer_unique_id,
    cohort_month,
    DATE_DIFF(
      PARSE_DATE('%Y-%m', order_month),
      PARSE_DATE('%Y-%m', cohort_month),
      MONTH
    ) AS months_since_first_order
  FROM cohort_base
)
SELECT
  cohort_month,
  months_since_first_order,
  COUNT(DISTINCT customer_unique_id) AS customers
FROM cohort_data
WHERE months_since_first_order BETWEEN 0 AND 3
GROUP BY cohort_month, months_since_first_order
ORDER BY cohort_month, months_since_first_order;
WITH daily_sales AS (
  SELECT 
    pharmacy_name, 
    report_date, 
    SUM(price * count) AS daily_total 
  FROM 
    pharma_orders 
  GROUP BY 
    pharmacy_name, 
    report_date
) 
SELECT 
  po.pharmacy_name, 
  po.order_id, 
  po.drug, 
  po.price, 
  po.count, 
  po.city, 
  po.report_date, 
  po.customer_id, 
  ds.daily_total, 
  SUM(po.price * po.count) OVER (PARTITION BY po.pharmacy_name ORDER BY po.report_date) AS cumulative_sales 
FROM 
  pharma_orders po 
  INNER JOIN daily_sales ds ON po.pharmacy_name = ds.pharmacy_name 
  AND po.report_date = ds.report_date 
ORDER BY 
  po.pharmacy_name, 
  po.report_date

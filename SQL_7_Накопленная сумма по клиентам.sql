SELECT 
  p.customer_id, 
  CONCAT(c.last_name, ' ', c.first_name, ' ', c.second_name) AS full_name, 
  order_id, 
  SUM(p.price * p.count) AS sum_amount, 
  report_date, 
  SUM(SUM(p.price * p.count)) OVER (PARTITION BY p.customer_id ORDER BY report_date ASC) AS cumulative_amount 
FROM 
  pharma_orders p 
  INNER JOIN customers c ON p.customer_id = c.customer_id 
GROUP BY 
  p.customer_id, 
  full_name, 
  order_id, 
  report_date 
ORDER BY 
  full_name ASC, 
  report_date ASC

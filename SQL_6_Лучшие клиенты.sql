SELECT 
  c.customer_id, 
  c.last_name, 
  c.first_name, 
  c.second_name, 
  SUM(po.price * po.count) AS total_spent, 
  ROW_NUMBER() OVER (ORDER BY SUM(po.price * po.count) DESC) AS rank 
FROM 
  customers c 
  INNER JOIN pharma_orders po ON c.customer_id = po.customer_id 
GROUP BY 
  c.customer_id, 
  c.first_name, 
  c.last_name, 
  c.second_name 
ORDER BY 
  total_spent DESC 
LIMIT 
  10

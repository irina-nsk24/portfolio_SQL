SELECT 
  pharmacy_name, 
  SUM(PRICE * COUNT) AS order_amnt 
FROM 
  pharma_orders 
GROUP BY 
  pharmacy_name 
ORDER BY 
  order_amnt DESC 
LIMIT 
  3

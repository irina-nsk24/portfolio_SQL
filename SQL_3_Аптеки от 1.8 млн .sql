SELECT 
  pharmacy_name, 
  SUM(PRICE * COUNT) AS order_amnt 
FROM 
  pharma_orders 
GROUP BY 
  pharmacy_name 
HAVING 
  SUM(PRICE * COUNT) > 1800000 
ORDER BY 
  order_amnt DESC
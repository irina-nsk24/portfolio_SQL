SELECT 
  drug, 
  SUM(PRICE * COUNT) AS order_amnt_drug 
FROM 
  pharma_orders 
GROUP BY 
  drug 
ORDER BY 
  order_amnt_drug DESC 
LIMIT 
  3
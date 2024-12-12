SELECT 
  pharmacy_name, 
  COUNT(DISTINCT customer_id) as customer_count 
FROM 
  pharma_orders po 
GROUP BY 
  pharmacy_name 
ORDER BY 
  customer_count DESC
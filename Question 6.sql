SELECT 
  runner_id, 
  order_id, 
  REPLACE(distance, 'km', '')::numeric(3, 1) / REGEXP_REPLACE(duration, '[^0-9]', '')::numeric(3, 1) as speed_km_per_minute 
FROM 
  runner_orders 
WHERE 
  duration <> 'null' 
ORDER BY 
  runner_id, 
  order_id 

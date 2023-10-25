SELECT 
ro.runner_id
,AVG(datediff('minute',pickup_time::timestamp_ntz,co.order_time))*-1 AS AVG_MINS
FROM customer_orders AS CO 
INNER JOIN
runner_orders as RO
ON co.order_id = ro.order_id
WHERE pickup_time != 'null'
GROUP BY ro.runner_id

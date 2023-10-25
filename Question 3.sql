SELECT COUNT(CO.order_id) AS number_of_pizzas
,CO.order_id
,CO.order_time
,(datediff('minute',pickup_time::timestamp_ntz,co.order_time))*-1 AS MINS
 FROM customer_orders AS CO
 INNER JOIN runner_orders AS RO
ON CO.order_id = RO.order_id
WHERE RO.pickup_time != 'null'
 GROUP BY CO.order_id
,CO.order_time
,RO.pickup_time
ORDER BY MINS DESC

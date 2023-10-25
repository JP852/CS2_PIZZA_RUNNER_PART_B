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

or with the CTE to calcualte the AVG for the number of pizzas

WITH CTE AS(
    SELECT 
co.order_id
,COUNT(pizza_id) AS number_of_pizzas
,MAX(datediff('minute',pickup_time::timestamp_ntz,order_time)*-1) AS PREP_TIME
FROM runner_orders AS ro
INNER JOIN customer_orders AS co
ON ro.order_id = co.order_id
WHERE ro.pickup_time != 'null'
GROUP BY co.order_id
)
SELECT AVG(PREP_TIME)
,number_of_pizzas
FROM CTE
GROUP BY number_of_pizzas

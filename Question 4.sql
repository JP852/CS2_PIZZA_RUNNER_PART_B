SELECT customer_id
,AVG(REPLACE(DISTANCE,'km','')::numeric(3,1)) AS DIST
FROM customer_orders AS co
INNER JOIN runner_orders AS ro
ON co.order_id = ro.order_id
WHERE DURATION != 'null'
GROUP BY customer_id

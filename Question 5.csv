
Using the duration: 

WITH CTE AS
(
SELECT order_id
,LEFT(DURATION,2)::numeric(3,0) AS DUR
FROM runner_orders
WHERE duration != 'null'
)
SELECT MAX(DUR) - MIN(DUR) AS DIFFERENCE
FROM CTE

using the difference from order time, pickup time:

WITH CTE AS(
SELECT co.ORDER_ID 
,MAX(DATEDIFF('minute',ORDER_TIME,pickup_time::timestamp_ntz)) AS DIFFERENCE
FROM customer_orders AS co
INNER JOIN runner_orders AS ro
ON co.order_id = ro.order_id
WHERE pickup_time != 'null'
GROUP BY co.order_id
)
SELECT MAX(DIFFERENCE) - MIN(DIFFERENCE) AS MINS_DIFF
FROM CTE

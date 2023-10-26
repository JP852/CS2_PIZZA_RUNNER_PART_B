SELECT runner_id
,SUM(CASE WHEN pickup_time != 'null' THEN 1 ELSE 0 END)
/
COUNT(runner_id)
FROM runner_orders
GROUP BY runner_id

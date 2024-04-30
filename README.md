# CS2_PIZZA_RUNNER_PART_B

![image](https://github.com/JP852/CS2_PIZZA_RUNNER_PART_B/assets/142391590/7b8774af-03cb-487e-a54c-18369c7b06f8)

## Link to Challenge

https://blog.devgenius.io/danny-mas-sql-case-study-2-pizza-runner-solutions-38c90e3bb6ad

## SQL Techniques Used

- CTEs
- Table Joins
- Aggregation
- Group By
- Order By
- Where Clause
- Data Type Changes
- Left Function
- Max Function
- Min Function

## Questions

### Question 1 - How many runners signed up for each 1 week period? (i.e. week starts 2021-01-01)

```
SELECT
    DATE_TRUNC('week',REGISTRATION_DATE)  + 4
    ,COUNT(runner_id) AS "Runners" 
        FROM RUNNERS
           GROUP BY DATE_TRUNC('week',REGISTRATION_DATE)  + 4

```

### Question 2 - What was the average time in minutes it took for each runner to arrive at the Pizza Runner HQ to pickup the order?

```
SELECT 
    ro.runner_id
    ,AVG(datediff('minute',pickup_time::timestamp_ntz,co.order_time))*-1 AS AVG_MINS
        FROM customer_orders AS CO 
            INNER JOIN runner_orders as RO
            ON co.order_id = ro.order_id
                WHERE pickup_time != 'null'
                    GROUP BY ro.runner_id

```

### Question 3 - Is there any relationship between the number of pizzas and how long the order takes to prepare?

```
SELECT 
    COUNT(CO.order_id) AS number_of_pizzas
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

```

With the CTE to calcualte the AVG for the number of pizzas:

```
WITH CTE AS(
 
SELECT 
    co.order_id 
    ,COUNT(pizza_id) AS number_of_pizzas
    ,MAX(datediff('minute',pickup_time::timestamp_ntz,order_time)*-1) AS PREP_TIME
        FROM runner_orders AS ro
            INNER JOIN customer_orders AS co
            ON ro.order_id = co.order_id
                WHERE ro.pickup_time != 'null'
                    GROUP BY co.order_id)
SELECT 
    AVG(PREP_TIME)
    ,number_of_pizzas
        FROM CTE
            GROUP BY number_of_pizzas

```

### Question 4 - What was the average distance travelled for each customer?

```
SELECT 
    customer_id
    ,AVG(REPLACE(DISTANCE,'km','')::numeric(3,1)) AS DIST
        FROM customer_orders AS co
            INNER JOIN runner_orders AS ro
            ON co.order_id = ro.order_id
                WHERE DURATION != 'null'
                    GROUP BY customer_id

```

### Question 5 - What was the difference between the longest and shortest delivery times for all orders?

Using the duration: 

```
SELECT 
    customer_id
    ,AVG(REPLACE(DISTANCE,'km','')::numeric(3,1)) AS DIST
        FROM customer_orders AS co
            INNER JOIN runner_orders AS ro
            ON co.order_id = ro.order_id
                WHERE DURATION != 'null'
                    GROUP BY customer_id

```

Using the difference from order time, pickup time:

```
WITH CTE AS(
 
SELECT 
    co.ORDER_ID 
    ,MAX(DATEDIFF('minute',ORDER_TIME,pickup_time::timestamp_ntz)) AS DIFFERENCE
        FROM customer_orders AS co
            INNER JOIN runner_orders AS ro
            ON co.order_id = ro.order_id
                WHERE pickup_time != 'null'
                    GROUP BY co.order_id)
SELECT 
    MAX(DIFFERENCE) - MIN(DIFFERENCE) AS MINS_DIFF
        FROM CTE

```

### Question 6 - What was the average speed for each runner for each delivery and do you notice any trend for these values?

```
SELECT 
    runner_id
    ,order_id
    ,REPLACE(distance, 'km', '')::numeric(3, 1) / REGEXP_REPLACE(duration, '[^0-9]', '')::numeric(3, 1) as speed_km_per_minute 
        FROM runner_orders 
            WHERE duration <> 'null' 
                ORDER BY runner_id
                ,order_id 

```

### Question 7 - What is the successful delivery percentage for each runner?

```
SELECT 
    runner_id
    ,SUM(CASE WHEN pickup_time != 'null' THEN 1 ELSE 0 END)/COUNT(runner_id)
        FROM runner_orders
            GROUP BY runner_id

```

















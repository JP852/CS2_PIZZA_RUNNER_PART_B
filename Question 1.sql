SELECT
DATE_TRUNC('week',REGISTRATION_DATE)  + 4
,COUNT(runner_id) AS "Runners"
FROM RUNNERS
GROUP BY DATE_TRUNC('week',REGISTRATION_DATE)  + 4

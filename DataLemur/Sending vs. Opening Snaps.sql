WITH send AS (
SELECT
age_bucket,
SUM(time_spent) as send_time
FROM activities a
LEFT JOIN age_breakdown b 
     ON a.user_id = b.user_id
WHERE activity_type = 'send'
GROUP BY 1
)
,

open AS (
SELECT
age_bucket,
SUM(time_spent) as open_time
FROM activities a
LEFT JOIN age_breakdown b 
     ON a.user_id = b.user_id
WHERE activity_type = 'open'
GROUP BY 1
)

SELECT 
s.age_bucket,
ROUND(send_time*100.0/(send_time + open_time),2) as send_perc,
ROUND(open_time*100.0/(send_time + open_time),2) as open_perc
FROM send s  JOIN open o ON s.age_bucket = o.age_bucket

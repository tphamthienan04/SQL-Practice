with cohort AS (
SELECT 
user_id,
date_trunc(min(partition_date),month) as cohort_month

FROM transport_requests
GROUP BY 1
),

active_month AS (
SELECT
user_id,
date_trunc(partition_date, month) as active_month

FROM transport_requests
GROUP BY 1
),

retention AS (
SELECT
c.cohort_month,
date_diff(am.active_month, c.cohort_month,month) as month_number,
count(c.user_id) as nb_user

FROM cohort c
LEFT JOIN active_month am
   ON c.user_id = am.user_id
   AND c.cohort_month < am.active_month

GROUP BY 1,2
)

SELECT * 
FROM retention
ORDER BY cohort_month, month_number

with raw AS (
SELECT 
user_id,
service_id,
min(partition_date) as first_date_by_service 

FROM transport_requests

GROUP BY 1,2
),

raw2 AS (
SELECT 
user_id,
min(partition_date) as first_date_by_service 

FROM transport_requests

GROUP BY 1
),

total1 AS (
SELECT 
date_trunc(first_date_by_service,month) as first_month,
service_id,
count(distinct user_id) as nb_user

FROM raw

GROUP BY 1,2 
),

total2 AS (
SELECT
date_trunc(first_date_by_service,month) as first_month,
“All service” as service_id,
count(distinct user_id) as nb_user

FROM raw2

GROUP BY 1,2
),

SELECT * FROM total1
UNION ALL
SELECT * FROM total2

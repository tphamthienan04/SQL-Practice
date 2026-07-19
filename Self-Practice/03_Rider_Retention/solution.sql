with cohort as (
SELECT
rider_id,
min(partition_date) as first_date

FROM transport_requests
GROUP BY 1
),

segment as (
SELECT
c.rider_id,
c.first_date,

CASE WHEN COUNT (dispatch_id) > 10 then ‘power’
           ELSE ‘non-power’
as segment


FROM cohort c
LEFT JOIN transport_requests tr
     ON c.rider_id = tr.rider_id
     AND tr.partition_date between c.first_date and date_add(c.first_date, interval 30 day)
     AND tr.dispatch_status in (3,11,55)

GROUP BY 1,2
),

activity as (
SELECT
s.rider_id,
s.segment,
s.first_date,
date_diff(tr.partition_date, s.first_date) as days_since_first

FROM segment s
LEFT JOIN transport_requests tr
      ON s.rider_id = tr.rider_id
      AND tr.partition_date <= date_add(s.first_date,interval 90 day)
      AND tr.dispatch_status in (3,11,55)

GROUP BY 1,2,3
)

SELECT 
segment,
CASE WHEN days_since_first between 0 and 30 THEN ‘retained_0_30’,
           WHEN days_since_first between 31 and 60 THEN ‘retained_31_60’,
           WHEN days_since_first between 61 and 90 THEN ‘retained_61_90’
     END as tag_time,
COUNT(DISTINCT rider_id) AS total_riders,

FROM activity
GROUP BY 1,2

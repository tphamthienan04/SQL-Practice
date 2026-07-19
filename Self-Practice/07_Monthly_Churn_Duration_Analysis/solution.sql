WITH active_month AS (
SELECT
user_id,
DATE_TRUNC(partition_date,month) as active_month
FROM transport_requests
GROUP BY 1,2
),
first_month AS (
	SELECT
		user_id,
		DATE_TRUNC(MIN(partition_date),month) as first_month
	FROM transport_requests
	GROUP BY 1,2
),
calendar_month AS (
SELECT 
month
FROM UNNEST(
        GENERATE_DATE_ARRAY(
            '2023-01-01',
            DATE_TRUNC(CURRENT_DATE(), MONTH),
            INTERVAL 1 MONTH
        )
    ) AS month
),
full_month_per_user AS (
SELECT
fm.user_id,
cm.month
FROM first_month fm
LEFT JOIN calendar_month cm
      ON cm.month >= fm.first_month 
),
inactive AS (
	SELECT
		pu.user_id,
		pu.month,
		CASE WHEN pu.month is NULL THEN 1 ELSE 0 END as is_active 
	FROM full_month_per_user pu
	LEFT JOIN active_month am
		ON pu.user_id = am.user_id
		AND pu.month = am.month
),
months_since_active AS (
    	SELECT
        cur.user_id,
        cur.month AS churn_month,
        cur.is_inactive,
        (
            SELECT MIN(DATE_DIFF(cur.month, a.month, MONTH))
            FROM active_month a
            WHERE a.user_id = cur.user_id
              AND a.month < cur.month
        ) AS months_since_last_active
    FROM inactive cur
    WHERE cur.is_inactive = 1
),

churn_tag AS (
    SELECT
        user_id,
        churn_month,
        CASE
            WHEN months_since_last_active = 1 THEN 'churn_1'
            WHEN months_since_last_active = 2 THEN 'churn_2'
            WHEN months_since_last_active = 3 THEN 'churn_3'
            ELSE 'churn_over_3'
        END AS churn_group
    FROM months_since_active
)

SELECT
    churn_month as month,
    COUNT(DISTINCT CASE WHEN churn_group = 'churn_1' THEN user_id END) AS churn_1_month,
    COUNT(DISTINCT CASE WHEN churn_group = 'churn_2' THEN user_id END) AS churn_2_month,
    COUNT(DISTINCT CASE WHEN churn_group = 'churn_3' THEN user_id END) AS churn_3_month,
    COUNT(DISTINCT CASE WHEN churn_group = 'churn_over_3' THEN user_id END) AS churn_over_3_month,
    COUNT(DISTINCT user_id) as total_churn
FROM churn_tag
GROUP BY 1
ORDER BY 1


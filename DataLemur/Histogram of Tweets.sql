WITH raw AS (
SELECT 
user_id,
COUNT(DISTINCT tweet_id) as tweet_bucket
FROM tweets
WHERE tweet_date BETWEEN '01/01/2022' AND '12/31/2022'
GROUP BY 1
)

SELECT
tweet_bucket,
COUNT(DISTINCT user_id) as users_num
FROM raw
GROUP BY 1
ORDER BY 1 

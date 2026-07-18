WITH raw AS (
SELECT
DISTINCT user_id,
MAX(DATE(post_date)) as last_post,
MIN(DATE(post_date)) as first_post

FROM posts
WHERE DATE(post_date) BETWEEN '01/01/2021' AND '12/31/2021'
GROUP BY 1)

SELECT
user_id,
last_post - first_post as days_between
FROM raw
GROUP BY 1,2
HAVING last_post - first_post > 0
ORDER BY 1 DESC


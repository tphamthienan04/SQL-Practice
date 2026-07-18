WITH raw AS (
SELECT
DISTINCT sender_id,
COUNT(DISTINCT message_id) as message_count,
ROW_NUMBER() OVER (
      ORDER BY COUNT(DISTINCT message_id) DESC) as ranking
FROM messages
WHERE DATE(sent_date) BETWEEN '08-01-2022' AND '08-31-2022'
GROUP BY 1
)

SELECT
sender_id,
message_count

FROM raw
WHERE ranking <= 2
ORDER BY message_count DESC



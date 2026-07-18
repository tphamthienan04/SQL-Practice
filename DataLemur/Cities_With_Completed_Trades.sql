WITH ranking AS (
SELECT
u.city,
COUNT(DISTINCT CASE WHEN status = 'Completed' THEN order_id END ) as nb_completed_trades,
ROW_NUMBER () OVER (
              ORDER BY COUNT(DISTINCT CASE WHEN status = 'Completed' THEN order_id END ) DESC) as ranking

FROM trades t 
LEFT JOIN users u ON t.user_id = u.user_id
GROUP BY 1
)

SELECT 
city,
nb_completed_trades

FROM ranking
WHERE ranking <= 3

WITH ranktransaction AS (
SELECT
user_id,
spend,
transaction_date,
ROW_NUMBER() OVER (
          PARTITION BY user_id
          ORDER BY transaction_date ASC
        ) AS ranktransaction

FROM transactions

)

SELECT
user_id,
spend,
transaction_date
FROM ranktransaction
WHERE ranktransaction = 3

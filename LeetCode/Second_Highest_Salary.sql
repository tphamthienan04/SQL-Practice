WITH ranking AS (
    SELECT 
    salary,
    DENSE_RANK () OVER (
        ORDER BY salary DESC) as ranking

    FROM Employee
    GROUP BY 1
)

SELECT
MAX(salary) as SecondHighestSalary
FROM ranking
WHERE ranking = 2

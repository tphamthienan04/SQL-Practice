CREATE FUNCTION getNthHighestSalary(N INT) RETURNS INT
BEGIN
  RETURN (
      # Write your MySQL query statement below.
     WITH ranking AS (
    SELECT 
        salary,
        DENSE_RANK () OVER (ORDER BY salary DESC) as ranking
    FROM Employee
    GROUP BY 1
)

SELECT
    MAX(salary) AS SecondHighestSalary 
FROM ranking
WHERE ranking = N
  );
END

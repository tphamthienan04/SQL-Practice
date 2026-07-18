WITH 

ranking AS (
  SELECT
  DISTINCT salary,
  DENSE_RANK() OVER (
      ORDER BY salary DESC)
      as ranking
  
  FROM employee)
  
SELECT
salary as second_highest_salary
FROM ranking
WHERE ranking = 2

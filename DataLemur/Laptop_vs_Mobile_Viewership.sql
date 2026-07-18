SELECT
candidate_id
FROM candidates
WHERE skill in ('Python', 'Tableau', 'PostgreSQL')
GROUP BY 1
HAVING COUNT (DISTINCT skill) = 3

WITH duplicate AS (
SELECT
company_id
FROM job_listings
GROUP BY company_id, title, description
HAVING COUNT(DISTINCT job_id) > 1
)

SELECT 
COUNT(DISTINCT company_id) as duplicate_companies
FROM duplicate

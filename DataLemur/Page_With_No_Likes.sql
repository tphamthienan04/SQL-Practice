SELECT
DISTINCT a.page_id
FROM pages a
LEFT JOIN page_likes b 
      ON a.page_id = b.page_id
WHERE b.page_id is NULL
ORDER BY 1 ASC

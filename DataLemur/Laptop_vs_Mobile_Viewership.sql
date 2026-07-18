SELECT
COUNT(CASE WHEN device_type = 'laptop' THEN  view_time END) as laptop_views,
(COUNT(CASE WHEN device_type = 'tablet'  THEN  view_time END) + COUNT(CASE WHEN device_type = 'phone'  THEN  view_time END)) as mobile_views
FROM viewership

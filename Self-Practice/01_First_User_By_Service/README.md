Problem

Given a table transport_requests containing all completed trips.

column
user_id
service_id
partition_date

Write a SQL query to calculate:

Number of users whose first-ever trip was in each month by service.
Number of users whose first-ever trip across all services was in each month.

Expected output

| first_month | service_id | nb_user |

Concepts

MIN()
GROUP BY
DATE_TRUNC()
UNION ALL

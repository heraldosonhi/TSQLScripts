-- Find duplicate columns
SELECT column1 , COUNT(column2)
FROM TABLE_NAME
GROUP BY column1
HAVING COUNT(column1) > 2

WITH total_girls_births AS (

	SELECT SUM(Births) AS Total_Girls_Births
	FROM names
	WHERE Gender = 'F'
),
	top_5_name AS (
	SELECT Name, SUM(Births) AS Num_Births_Name
	FROM names
	WHERE Gender = 'F'
	GROUP BY Name
	ORDER BY SUM(Births) DESC
	LIMIT 5
)
SELECT 
	t2.Name, 
    t2.Num_Births_Name,
    t1.Total_Girls_Births,
    ROUND((t2.num_births_name/t1.total_girls_births)*100,2) AS Percentage
FROM total_girls_births t1 
CROSS JOIN top_5_name t2
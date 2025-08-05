
WITH total_boys_births AS (

	SELECT SUM(Births) AS Total_Boys_Births
	FROM names
	WHERE Gender = 'M'
),
	top_name AS (
	SELECT Name, SUM(Births) AS Num_Births_Name
	FROM names
	WHERE Gender = 'M'
	GROUP BY Name
	ORDER BY SUM(Births) DESC
	LIMIT 1
)
SELECT 
	t2.Name, 
    t2.Num_Births_Name,
    t1.Total_Boys_Births,
    ROUND((t2.Num_Births_Name/t1.total_boys_births)*100,2) AS Percentage
FROM total_boys_births t1 
CROSS JOIN top_name t2
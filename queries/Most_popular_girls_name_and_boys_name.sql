-- Most popular girl name and boy name
WITH
	Total_Boys_And_Girls_Births AS (
	SELECT SUM(Births) AS Total_Boys_And_Girls_Births
    FROM names
	)
	,
	Most_Popular_Girl AS (
	SELECT Name, SUM(Births) as Num_Births
	FROM names
	WHERE Gender = 'F'
	GROUP BY Name
	ORDER BY Num_Births DESC
	LIMIT 1
	), 
	Most_Popular_Boy AS (
	SELECT Name, SUM(Births) as Num_Births
	FROM names
	WHERE Gender ='M'
	GROUP BY Name
	ORDER BY Num_Births DESC
	LIMIT 1
    ),
	Union_Tables AS (
	SELECT *
	FROM Most_Popular_Girl
	UNION
	SELECT *
	FROM Most_Popular_Boy 
)
SELECT *
FROM Union_Tables t1
CROSS JOIN Total_Boys_And_Girls_Births t2
;

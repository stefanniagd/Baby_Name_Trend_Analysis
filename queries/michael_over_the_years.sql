WITH 
	total_boys_births_per_year AS (
	SELECT Year AS Year_Total, SUM(Births) AS Total_Boys_Births
	FROM names
	WHERE Gender = 'M'
	GROUP BY Year
    ), 
	boys_names_popularity AS (
	SELECT Year, Name, SUM(Births) num_babies,
	ROW_NUMBER() OVER(PARTITION BY YEAR ORDER BY SUM(Births) DESC) as Popularity
	FROM names
	WHERE Gender = 'M'
	GROUP BY Year, Name
    ), 
	boys_popularity AS (
    SELECT *
    FROM boys_names_popularity
    WHERE Name = 'Michael'
    ), 
    join_michael_popularity_and_total_boys_births_per_year AS (
    SELECT *
    FROM boys_popularity t1
    INNER JOIN total_boys_births_per_year t2
		ON t1.Year = t2.Year_Total
	)
    SELECT *, ROUND((num_babies/Total_Boys_Births) * 100 ,2)AS Percentage
	FROM join_michael_popularity_and_total_boys_births_per_year
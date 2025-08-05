WITH 
	total_girls_births_per_year AS (
	SELECT Year AS Year_Total, SUM(Births) AS Total_Girl_Births
	FROM names
	WHERE Gender = 'F'
	GROUP BY Year
    ), 
	girl_names_popularity AS (
	SELECT Year, Name, SUM(Births) num_babies,
	ROW_NUMBER() OVER(PARTITION BY YEAR ORDER BY SUM(Births) DESC) as Popularity
	FROM names
	WHERE Gender = 'F'
	GROUP BY Year, Name
    ), 
	jessica_popularity AS (
    SELECT *
    FROM girl_names_popularity
    WHERE Name = 'Jessica'
    ), 
    join_jessica_popularity_and_total_girls_births_per_year AS (
    SELECT *
    FROM jessica_popularity t1
    INNER JOIN total_girls_births_per_year t2
		ON t1.Year = t2.Year_Total
	)
    SELECT *, ROUND((num_babies/Total_Girl_Births) * 100 ,2)AS Percentage
	FROM join_jessica_popularity_and_total_girls_births_per_year
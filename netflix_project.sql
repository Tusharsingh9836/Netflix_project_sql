-- nefflix project


CREATE TABLE netflix
(
	show_id	VARCHAR(5),
	type    VARCHAR(10),
	title	VARCHAR(250),
	director VARCHAR(550),
	casts	VARCHAR(1050),
	country	VARCHAR(550),
	date_added	VARCHAR(55),
	release_year	INT,
	rating	VARCHAR(15),
	duration	VARCHAR(15),
	listed_in	VARCHAR(250),
	description VARCHAR(550)
);

SELECT * FROM netflix;
 

-- problem 1. Count the number of Movies vs TV Shows



select type_of, count(type_of)
	from netflix 
		group by type_of


--problem 2. Find the most common rating for movies and TV shows


select type_of , rating 
		from (select type_of , rating , count(*),
					rank()over(partition by type_of order by count(*) desc ) as ranking
					from netflix
					group by 1,2) x
				where ranking = 1;


--problem 3. List all movies released in a specific year (e.g., 2020)

select * from netflix

select *
	from netflix
		where release_year ='2020'
			and
				type_of = 'Movie'


-- problem 4. Find the top 5 countries with the most content on Netflix

		

select unnest(string_to_array(country,',')) , count(*) as total_content
	from netflix
		group by unnest(string_to_array(country,','))
			order by total_content desc
				limit 5


--problem 5. Identify the longest movie

select max(duration) from netflix
	where type_of = 'Movie'
	select * from netflix


-- problem 6. Find content added in the last 5 years

select * FROM netflix
 where 	
 	to_date(date_added , 'Month DD,YYYY') >= current_date - interval '5 years'


--problem 7. Find all the movies/TV shows by director 'Rajiv Chilaka'!

select * from netflix
where 
	director like '%Rajiv Chilaka%'

--problem 8. List all TV shows with more than 5 seasons

select * , cast(split_part(duration,' ',1) as int) 
	from netflix 
		where type_of = 'TV Show'
		and
			cast(split_part(duration,' ',1) as int)  > 5

			
--PROBLEM 9. Count the number of content items in each genre

SELECT unnest(string_to_array(listed_in,',' )) , count(*) from netflix
GROUP BY 1
order by 2 desc

--problem 10.Find each year and the average numbers of content release in India on netflix. return top 5 year with highest avg content release!



SELECT   
	extract(year from to_date(date_added,'Month DD , YYYY')) as per_year , 
		count(*),
			round(count(*)::numeric/(select count(*) from netflix where country  = 'India') * 100 , 2) as avg_yearly_releasedMovie
		from netflix
			where country = 'India'
				group by 1 	
				order by 3 desc
				limit 5


--problem  11. List all movies that are documentaries
select * from netflix
 where type_of = 'Movie'
 and listed_in like '%Documentaries%'


 --problem 12. Find all content without a director

 select * from netflix
 	where director is null

--problem 13. Find how many movies actor 'Salman Khan' appeared in last 10 years!

select *  
from netflix
where type_of = 'Movie'
			and
		casts like '%Salman Khan%'
			and
		release_year::numeric > extract(year from(current_date)) - 10


		
 --problem 14. Find the top 10 actors who have appeared in the highest number of movies produced in India.

 select unnest(string_to_array(casts,',')) as actor , count(*)
 from netflix 
 where country = 'India' 
 group by 1 
 order by 2 desc
 limit 10


--  problem 15.Categorize the content based on the presence of the keywords 'kill' and 'violence' in 
-- the description field. Label content containing these keywords as 'Bad' and all other 
-- content as 'Good'. Count how many items fall into each category.


with bad_good_table as
(

select * ,

	case
		when  description ilike '%kill%'
	or
			description ilike '%violence%'
				then 'Bad_film'

						else 'Good_flim'

	end as category
from netflix
)

select category , count(*) as total_content
from bad_good_table
group by 1








		
 

























































				

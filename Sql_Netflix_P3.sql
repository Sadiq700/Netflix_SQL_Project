drop table if exists netflix;
create table netflix
(
   show_id	varchar(6),
   type	varchar(10),
   title	varchar(150),
   director	varchar(215),
   casts	varchar(800),
   country	varchar(130),
   date_added	varchar(50),
   release_year	int,
   rating	varchar(10),
   duration	varchar(20),
   listed_in	varchar(85),
   description varchar(260)
);

 select * from netflix;

 -- Business Problems 

 -- 1. Count the Number of Movies vs TV Shows

    select
	 type,
	 count(*) Total_Content
	from netflix
	group by type;

	-- 2. Find the Most Common Rating for Movies and TV Shows
	
  select type,
   rating
  from
  (
  select type,
   rating, 
   count(*),
   rank() over(partition by type order by count(*) desc) ranking
  from netflix
  group by 1,2
 ) as t1
 where ranking = 1;

-- 3. List All Movies Released in a Specific Year (e.g., 2020)

 select *
 from netflix
 where type = 'Movie' and release_year = '2020';

--4. Find the Top 5 Countries with the Most Content on Netflix

  select unnest(string_to_array(country, ', ')) New_Country,
  count(*) Total_Content
  from netflix
  group by 1
  order by 2 desc
  limit 5;

--5. Identify the Longest Movie

 select title, duration
  from netflix
  where type = 'Movie' 
  and 
  duration = (select max(duration) from netflix);

-- 6. Find Content Added in the Last 5 Years

	select * 
	from netflix
	where to_date(date_added, 'Month DD, YYYY') > current_date - interval '5 years'

-- 7. Find All Movies/TV Shows by Director 'Rajiv Chilaka'

	select *
	from netflix
	where director ilike '%Rajiv Chilaka%'

-- 8. List All TV Shows with More Than 5 Seasons

    select *
	from netflix
	where type='TV Show' 
	and 
	split_part (duration, ' ', 1)::numeric > 5

-- 9. Count the Number of Content Items in Each Genre

  select unnest(string_to_array(listed_in, ',') ) gener, count(*) total_content
  from netflix
  group by 1

-- 10.Find each year and the average numbers of content release in India on netflix.

   select Extract(year from to_date(date_added, 'Month DD, YYYY')) as year,
   count(*),Round(count(*)::numeric/(select count(*) from netflix where country = 'India')::numeric * 100,2) avg_content
   from netflix
   where country = 'India'
   group by 1

-- 11. List All Movies that are Documentaries

   select * 
   from netflix
   where type = 'Movie'
   and listed_in ilike '%Documentaries%'

-- 12. Find All Content Without a Director

   select *
   from netflix
   where director is null

-- 13. Find How Many Movies Actor 'Shah Rukh Khan' Appeared in the Last 10 Years

    select *
	from netflix
	where casts ilike '%Shah Rukh Khan%'
	and
	release_year > Extract(year from current_date) -  10 

-- 14. Find the Top 10 Actors Who Have Appeared in the Highest Number of Movies Produced in India

     select unnest(String_to_array(casts, ',')) Actors, count(*) total_content
	 from netflix
	 where type = 'Movie'
	 and 
	 country ilike '%India%'
	 Group By 1
	 order by 2 desc
	 Limit 10

-- 15. Categorize Content Based on the Presence of 'Kill' and 'Violence' Keywords

   With CTE
   as
  (
	select *,
	 case
	   When description ilike '%kill%' or
	        description ilike '%Violence%' then 'Bad_Content'
		Else 'Good_Content'
	  End category
	 from netflix
	)
   Select category, count(*) total_content
   from cte
   group by 1












   




	
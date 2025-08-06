# Netflix Movies and TV Shows Data Analysis using SQL
![Netflix Logo](https://github.com/Sadiq700/Netflix_SQL_Project/blob/main/Netflix%20logo.webp)

## Overview
This project involves a comprehensive analysis of Netflix's movies and TV shows data using SQL. The goal is to extract valuable insights and answer various business questions based on the dataset. The following README provides a detailed account of the project's objectives, business problems, solutions, findings, and conclusions.

## Objectives
* Analyze the distribution of content types (movies vs TV shows).
* Identify the most common ratings for movies and TV shows.
* List and analyze content based on release years, countries, and durations.
* Explore and categorize content based on specific criteria and keywords.

## Dataset
The data for this project is sourced from the Kaggle dataset:
* Dataset Link: [Movies Dataset](https://www.kaggle.com/datasets/shivamb/netflix-shows?resource=download)

## Schema
```sql
DROP TABLE IF EXISTS netflix;
CREATE TABLE netflix
(
    show_id      VARCHAR(5),
    type         VARCHAR(10),
    title        VARCHAR(250),
    director     VARCHAR(550),
    casts        VARCHAR(1050),
    country      VARCHAR(550),
    date_added   VARCHAR(55),
    release_year INT,
    rating       VARCHAR(15),
    duration     VARCHAR(15),
    listed_in    VARCHAR(250),
    description  VARCHAR(550)
);
```

## Business Problems and Solutions

## 1. Count the Number of Movies vs TV Shows
```sql
 select
	 type,
	 count(*) Total_Content
	from netflix
	group by type
```
## Objective: Determine the distribution of content types on Netflix.

## 2. Find the Most Common Rating for Movies and TV Shows
```sql
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
 where ranking = 1
```
## Objective: Identify the most frequently occurring rating for each type of content.

## 3. List All Movies Released in a Specific Year (e.g., 2020)
```sql
  select *
 from netflix
 where type = 'Movie' and release_year = '2020'
```
## Objective: Retrieve all movies released in a specific year.

## 4. Find the Top 5 Countries with the Most Content on Netflix
```sql
   select unnest(string_to_array(country, ', ')) New_Country,
  count(*) Total_Content
  from netflix
  group by 1
  order by 2 desc
  limit 5
```
## Objective: Identify the top 5 countries with the highest number of content items.

## 5. Identify the Longest Movie
```sql
   select title, duration
  from netflix
  where type = 'Movie' 
  and 
  duration = (select max(duration) from netflix)
```
## Objective: Find the movie with the longest duration.















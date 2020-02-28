-- 3.1 Write a query to list all the film titles

select title from film;

-- 3.2 Write a query to return the actor's first names and 
-- last names only (with the column headings "First Name" and "Last Name")

select first_name as "First Name", last_name as "Last Name" from actor;

-- 3.3 How many rows are in the inventory table?

select * from inventory;

-- 4581

-- 3.4 Write a query that returns all the columns from the actor 
-- table without using the * wildcard in the SELECT clause

select actor_id, first_name, last_name last_update from actor;

-- 3.5 Write a query to obtain the length of each customer's 
-- first name (*remember to look for string functions in the 
-- documentation that can help*)

select first_name, length(first_name) as length from customer;

-- 3.6 Write a query to return the initials for each customer

select 
	first_name,
	last_name, 
	upper(substring(first_name from 1 for 1) || substring(last_name from 1 for 1)) as initials -- solution uses left function
from customer;


-- 3.7 Each film has a rental_rate, which is how much money it costs for a customer to rent 
-- out the film. Each film also has a replacement_cost, which is how much money the film 
-- costs to replace. Write a query to figure out how many times each film must be rented 
-- out to cover its replacement cost.

select title, rental_rate, replacement_cost, ceiling(replacement_cost / rental_rate) as "num rentals to break-even" from film;

-- 3.8 Write a query to list all the films with a 'G' rating

select title, rating from film
where rating = 'G';

-- 3.9 List all the films longer than 2 hours (note each film 
-- has a length in minutes)

select title, length from film
where length > 120;

-- 3.10 Write a query to list all the rentals made before June, 2005

select rental_id, rental_date from rental
where rental_date < '2005-06-01';

-- 3.11 In Exercise 3.7, you wrote a query to figure out how many times each film
-- must be rented out to cover its replacement cost. Now write a query to return 
-- only those films that must be rented out more than 30 times to cover their replacement cost.

select title, 
	rental_rate, 
	replacement_cost, 
	ceiling(replacement_cost / rental_rate) as "num rentals to break-even" 
from film
where ceiling(replacement_cost / rental_rate) > 30;


-- 3.12 Write a query to show all rentals made by the customer with ID 388 in 2005

select rental_id, rental_date 
from rental
where customer_id = 388 and rental_date > '2005-01-01' and rental_date < '2006-01-01'; 

-- 3.13 We’re trying to list all films with a length of an hour or less. Show two 
-- different ways to fix our query below that isn't working (one using the NOT keyword, and one without)

select title, rental_duration, length
from film
where not length > 60;

select title, rental_duration, length
from film
where length <= 60;

-- 3.14 Explain what each of the two queries below are doing and why
--  they generate different results. Which one is probably a mistake and why?

select title, rating
from film
where rating != 'G'
  and rating != 'PG';
-- filters all movies with G and PG ratings
 
select title, rating
from film
where rating != 'G'
  or rating != 'PG';
-- doesn't really filter anything, probably the mistake 
 

-- 3.15 Write a single query to show all rentals where the return date is greater than the 
-- rental date, or the return date is equal to the rental date, or the return date is less 
-- than the rental date. How many rows are returned? Why doesn't this match the number of 
-- rows in the table overall?

 
 select rental_id, rental_date, return_date from rental
where (return_date > rental_date) or
	  (return_date = rental_date) or
	  (return_date < rental_date);
 
 -- could be null values
 
-- 3.16 Write a query to list the rentals that haven't been returned


 select rental_id, return_date from rental 
 where return_date is null;
 
-- 3.17 Write a query to list the films that have a rating that is not 'G' or 'PG'

select title, rating from film 
where rating != 'G' and rating != 'PG' or rating is null;
 
 
-- 3.18 Write a query to return the films with a rating of 'PG', 'G', or 'PG-13'

select title, rating from film
where rating in ('PG', 'G', 'PG-13');
 

-- 3.19 Write a query equivalent to the one below using BETWEEN.

select title, length
from film
where length >= 90
  and length <= 120;
 
select title, length
from film
where length between 90 and 120;

-- 3.20 Write a query to return all film titles that end with the word "GRAFFITI"

select title from film 
where title like '%GRAFFITI';

-- 3.21 In exercise 3.17 you wrote a query to list the films that have a rating that is not 'G' or 'PG'. 
-- Re-write this query using NOT IN. Do your results include films with a NULL rating?

select title, rating from film 
where rating not in ('PG', 'G');

-- 3.22 Write a query to list all the customers with an email address. Order the customers by last name descending

select first_name, last_name 
from customer
where email is not null
order by last_name desc;


-- 3.23 Write a query to list the country id's and cities from the city table, first ordered by country id ascending, then by city alphabetically.

select country_id, city from city
order by country_id asc, city;

-- 3.24 Write a query to list actors ordered by the length of their full name ("[first_name] [last_name]") descending.

select 
	first_name || ' ' || last_name as "full_name",
	length(first_name || ' ' || last_name) as len
from actor
order by len desc;

-- 3.26 Fix the query below, which we wanted to use to list all the rentals that happened after 10pm at night.

select rental_id, date_part('hour', rental_date) as "rental hour"
from rental
where date_part('hour', rental_date) >= 22;

-- 3.27 Write a query to return the 3 most recent payments received

select payment_id, payment_date
from payment
order by payment_date desc
limit 3;

-- 3.28 Return the 4 films with the shortest length that are not R rated. For films with the same length, order them alphabetically

select title, length, rating
from film 
where rating != 'R'
order by length, title
limit 4;

-- 3.29 Write a query to return the last 3 payments made in January, 2007

select payment_id, amount, payment_date
from payment
where payment_date < '2007-02-01'
  and payment_date >= '2007-01-01'
order by payment_date desc
limit 3;

-- 3.30 Can you think of a way you could, as in the previous exercise, 
-- return the last 3 payments made in January, 2007 but have those same 3 
-- output rows ordered by date ascending? (Don't spend too long on this...)

select payment_id, amount, payment_date
from payment
where payment_date > '2007-01-31' and payment_date < '2007-02-01'
order by payment_date desc
limit 3;



-- 3.31 Write a query to return all the unique ratings films can have, ordered alphabetically (not including NULL)

select distinct rating
from film
where rating is not null;


-- 3.32 Write a query to help us quickly see if there is any hour of the day that we have never rented a film out on (maybe the staff always head out for lunch?)

select distinct date_part('hour', rental_date) as hr
from rental
order by hr;


-- 3.33 Write a query to help quickly check whether the same rental 
-- rate is used for each rental duration (for example - is the rental rate always 4.99 when the rental duration is 3?)

select distinct rental_duration, rental_rate
from film
order by rental_duration, rental_rate desc;

-- 3.34 Can you explain why the first query below works, but the second one, which simply adds the DISTINCT keyword, doesn't? (this is quite challenging)

select first_name
from actor
order by last_name;

select distinct first_name
from actor
order by last_name;
-- order by expressions must appear in select list


-- 3.35 Write a query to return an ordered list of distinct ratings for films in 
-- our films table along with their descriptions (you will have to type in the descriptions yourself)

select distinct rating, 
	case rating
		when 'G' then 'General'
		when 'PG' then 'Parental Guidance Recommended'
		when 'PG-13' then 'Parents Strongly Cautioned'
		when 'R' then 'Restricted'
		when 'NC-17' then 'Adults Only'
	end as "rating_description"
from film
where rating is not null
order by rating;

-- 3.36 Write a query to output 'Returned' for returned rentals and 'Not Returned' for rentals that 
-- haven't been returned. Order the output to show those not returned first.

select rental_id, rental_date, return_date, 
	case 
		when return_date is null then 'Not Returned'
		else 'Returned'
	end as "return_status"
from rental
order by rental_date desc;

-- 3.37 Imagine you were asked to write a query to populate a 'country picker' for some internal company dashboard. 
-- Write a query to return the countries in alphabetical order, but also with the twist that the first 3 countries in the 
-- list must be 1) Australia 2) United Kingdom 3) United States and then normal alphabetical order after that (maybe you want 
-- them first because, for example, most of your customers come from these countries)

select country from country
order by 
	case country 
		when 'Australia' then 0
		when 'United Kingdom' then 1
		when 'United States' then 2
	end, country;


-- 3.38 We want to give a prize to 5 random customers each month. Write a query that will return 5 random customers each 
-- time it is run (you may find a particular math function helpful - make sure to search the documentation!)

select first_name, last_name, email from customer order by random() limit 5;
	
-- 3.39 Give 3 different solutions to list the rentals made in June, 2005. In one solution, use the 
-- date_part function. In another, use the BETWEEN keyword. In the third, don't use either date_part or BETWEEN.
	

select rental_id, rental_date
from rental
where date_part('month', rental_date) = 6 and date_part('year', rental_date) = 2005;

select rental_id, rental_date
from rental
where rental_date between '2005-06-01' and '2005-07-01';

select rental_id, rental_date
from rental
where rental_date > '2005-06-01' and rental_date < '2005-07-01';

-- 3.40 Return the top 5 films for $ per minute (rental_rate / length) of entertainment

select title, rental_rate, length, (rental_rate / length) as "per_minute"
from film
where length != 0
order by per_minute desc
limit 5;

-- 3.41 Write a query to list all customers who have a first name containing the letter 'A' twice or more

select first_name from customer
where first_name like '%A%A%';


-- 3.42 PostgreSQL supports an interesting variation of DISTINCT called DISTINCT ON. Visit the official 
-- documentation page and read about DISTINCT ON. See if you can figure out how you would use it in a 
-- query to return the most recent rental for each customer

select distinct on (customer_id) customer_id, rental_date 
from rental
order by customer_id, rental_date desc;


-- 3.43 Write a query to list all the customers with an email address but not in the format [first_name].[last_name]@sakilacustomer.org

select first_name, last_name, email from customer
where email not like '%.%@sakilacustomer.org';










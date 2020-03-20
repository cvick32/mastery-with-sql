-- 5.1 Write a query to print a description of each film's length as 
-- shown in the output below. When a film does not have a length, 
-- print: [title] is unknown length

select title || ' is ' || coalesce(length || ' minutes', 'unknown length') as length_desc
from film;


-- 5.2 You want to play a movie title guessing game with some friends. 
-- Write a query to print only the first 3 letters of each film title 
-- and then '*' for the rest (The repeat function may come in handy here...)

select left(title, 3) || repeat('*', length(title) - 3) as "Guess!"
from film;

-- 5.3 Write a query to list the percentage of films that are rated NC-17, 
-- G, PG, PG-13, NC-17, and R, rounded to the nearest integer.

select 
	round(100.0 * count(*) filter(where rating = 'NC-17') / count(*)) as "% NC-17",
	round(100.0 * count(*) filter(where rating = 'PG') / count(*)) as "% PG",
	round(100.0 * count(*) filter(where rating = 'G') / count(*)) as "% G",
	round(100.0 * count(*) filter(where rating = 'R') / count(*)) as "% R",
	round(100.0 * count(*) filter(where rating = 'PG-13') / count(*)) as "% PG-13"
from film;

-- 5.4 Try a few of the different explicit casting operations listed below to get 
-- familiar with how casting behaves. Was the behaviour what you expected?

select int '33';
select numeric '33.3';
select cast(33.3 as int);
select cast(33.8 as int);
select 33::text;
select 'hello'::varchar(2);
select cast(30000 as smallint);
select 12.1::numeric(3,1);

-- 5.5 Show 3 different ways to input the timestamptz representing 4th March, 2019 at 3:30pm in New York, USA

select * from pg_timezone_names;

select 
	timestamptz '2019-03-04 15:30 EST',
	timestamptz '2019-03-04 03:30PM -5',
	timestamptz '2019-03-04 03:30PM America/New_York';

-- 5.6 The rental duration in the film table is currently stored as an integer, representing the number of days. 
-- Write a query to return this as an interval instead and then add one day to the duration


select title, 
	cast(rental_duration || ' days' as interval) as "duration", 
	cast(rental_duration || ' days' as interval) + interval '1 day' as "duration + 1"
from film;

-- 5.7 You have a theory that certain hours of the day might be busiest for rentals. To investigate this 
-- write a query to list out for all time the the number of rentals made during each hour of the day

select 
	date_part('hour', rental_date) as hr,
	count(*)
from rental
group by hr
order by count;


-- 5.8 If you wanted to aggregate payments received by year and month you could write a query as below using 
-- the date_part function. Try and simplify this query by instead using the date_trunc function to achieve 
-- effectively the same result (ignoring the slight difference in date presentation)

select
  date_trunc('month', payment_date) as "month",
  sum(amount) as total
from payment
group by "month"
order by "month";


-- 5.9 Write a query to return a count of the number of films that were rented out on the last day of a month

select count(*) as "total # of EOM rentals"
from rental
where date_trunc('month', rental_date) + interval '1 month' - interval '1 day' = date_trunc('day', rental_date);

-- 5.10 Write a query to list the film titles that have spaces at the beginning or end (we want to flag them so we know to clean them up!)

select count(*) as "spaces"
from film 
where left(title, 1) = ' ' or right(title, 1) = ' ';

-- 5.11 Write a query to sum up, for each customer, the total number of hours they have had films rented out 
-- for. Return only the top 3 customers with the most hours.

select 
	customer_id, 
	round(sum(date_part('epoch', return_date - rental_date)) / 3600) as hrs_rented
from rental
group by customer_id
order by hrs_rented desc
limit 3;

-- 5.12  write a query to generate a list of timestamps which represent the first day of every month in 2019, at 5pm UTC

select * from generate_series('2019-01-01 17:00 UTC'::timestamptz, '2019-12-01 17:00 UTC'::timestamptz, '1 month');

-- 5.13 Return a count of the number of occurrences of the letter 'A' in each customer's first name (this is a 
-- common interview question for SQL related jobs!). Order the output by the count descending.

select first_name, length(first_name) - length(replace(first_name, 'A', '')) as count
from customer
order by count desc;

-- 5.14 Write a query to tally up the total amount of money made on weekends (Saturday and Sunday)

select sum(amount) as "total $"
from payment
where date_part('isodow', payment_date) in (6, 7);

















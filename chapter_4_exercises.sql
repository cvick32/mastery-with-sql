-- 4.1 Write a query to return the total count of customers in the customer table and the count of how many customers provided an email address

select count(*) as "# customers", count(email) as "# customers with email" from customer;

-- 4.2 Building on the previous exercise, now return an additional result showing the percentage of 
-- customers with an email address (as a helpful hint, if you're getting 0 try multiplying the fraction 
-- by 100.0 - we'll examine why this is necessary in an upcoming chapter on data types)

select count(*) as "# customers", count(email) as "# customers with email", 
	100.0 * count(email) / count(*) as "% with email" from customer;
	

-- 4.3 Write a query to return the number of distinct customers who have made payments

select count(distinct customer_id) as count from payment;

-- 4.4 What is the average length of time films are rented out for

select avg(return_date - rental_date) from rental;


-- 4.5 Write a query to return the sum total of all payment amounts received

select sum(amount) from payment;

-- 4.6 List the number of films each actor has appeared in and order the results from most popular to least

select actor_id, count(*) as num_films
from film_actor
group by actor_id
order by num_films desc;

-- 4.7 List the customers who have made over 40 rentals

select customer_id
from rental
group by customer_id
having count(*) > 40;

-- 4.8 We want to compare how the staff are performing against each other on a month to month basis. So for 
-- each month and year, show for each staff member how many payments they handled, the total amount of money 
-- they accepted, and the average payment amount

select 
	date_part('year', payment_date) as year, 
	date_part('month', payment_date) as month, staff_id, 
	count(*) as num_payments, 
	sum(amount) as payment_total, 
	avg(amount) as avg_payment_total
from payment
group by 
	date_part('year', payment_date), 
	date_part('month', payment_date), 
	staff_id;

-- 4.9 Write a query to show the number of rentals that were returned within 3 days, the number returned 
-- in 3 or more days, and the number never returned (for the logical comparison check you can use the 
-- following code snippet to compare against an interval: where return_date - rental_date < interval '3 days')

select 
	count(*) filter(where return_date - rental_date < interval '3 days') as "lt 3 days",
	count(*) filter(where return_date - rental_date >= interval '3 days') as "gt 3 days",
	count(*) filter(where return_date is null) as "never returned"
from rental;

-- 4.10 Write a query to give counts of the films by their length in groups of 0 - 1hrs, 
-- 1 - 2hrs, 2 - 3hrs, and 3hrs+ (note: you might get slightly different numbers if doing 
-- inclusive or exclusive grouping - but don't sweat it!)

select 
	case 
		when length between 0 and 59 then '0-1hrs'
		when length between 60 and 119 then '1-2hrs'
		when length between 120 and 179 then '2-3hrs'
		else '3hrs+'
	end as len,
	count(*)
from film
group by 1
order by 1;

-- 4.12 Write a query to return the average rental duration for each customer in descending order

select customer_id, avg(return_date - rental_date) as avg_rent_dur
from rental
group by customer_id 
order by avg_rent_dur desc;

-- 4.13 Return a list of customer where all payments they’ve made have been over $2 (lookup the bool_and aggregate function which will be useful here)

select customer_id
from payment
group by customer_id
having bool_and(amount > 2);

-- 4.14 As a final fun finish to this chapter, run the following query to see a cool way you can generate ascii histogram charts. 
-- Look up the repeat function (you'll find it under 'String Functions and Operators') to see how it works and change 
-- the output character...and don't worry, I'll explain the ::int bit in the next chapter!

select rating, repeat('*', (count(*) / 10)::int) as "count/10"
from film
where rating is not null
group by rating;










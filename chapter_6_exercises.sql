-- 6.1 Write a query to return a list of all the films rented by PETER MENARD showing the most recent first

select rental_date, title
from rental
  inner join customer 
    on customer.customer_id = rental.customer_id
  inner join inventory
    on inventory.inventory_id = rental.inventory_id
  inner join film
    on film.film_id = inventory.film_id
where
  customer.first_name = 'PETER'
order by rental_date desc;

-- 6.2 Write a query to list the full names and contact details for the manager of each store

select store.store_id, staff.first_name || ' ' || staff.last_name as Manager, staff.email as Email
from store
  inner join staff 
    on store.manager_staff_id = staff.staff_id
    
-- 6.3 Write a query to return the top 3 most rented out films and how many times they've been rented out
    

select inventory.film_id, film.title, count(*)
from rental
  inner join inventory 
    on inventory.inventory_id = rental.inventory_id
  inner join film
    on inventory.film_id = film.film_id
group by inventory.film_id, film.title
order by count(*) desc
limit 3;
    

-- 6.4 Write a query to show for each customer how many different (unique) films they've rented and how 
--  many different (unique) actors they've seen in films they've rented

select rental.customer_id, 
       count(distinct film.film_id) as num_films, 
       count(distinct film_actor.actor_id) as num_actors
from rental
  inner join inventory 
    on inventory.inventory_id = rental.inventory_id
  inner join film
    on film.film_id = inventory.film_id
  inner join film_actor
    on film.film_id = film_actor.film_id
group by rental.customer_id
order by rental.customer_id;
    
-- 6.5 Re-write the query below written in the older style of inner joins 
-- (which you still encounter surprisingly often online) using the more modern style. 
-- Re-write it once using ON to establish the join condition and the second time with USING.

select film.title, language.name as "language"
from film, language
where film.language_id = language.language_id;

select film.title, language.name as "language"
from film
  inner join language
    on film.language_id = language.language_id;

select film.title, language.name as "language"
from film
  join language using (language_id);
    
    
    
    
    
    
    
-- 2. Movies Not Rented in the past 3 months
-- Problem: List all movies that haven’t been rented in the 3 months. Include their film_id, title, and release_year.

-- Constraints:

-- Consider the past 3 months from the latest rental date in the rental table.
-- Order the results by release_year in descending order.
-- Expected Output:

-- film_id	title	release_year
-- 104	The Lost City	2020
-- 56	Ancient Warriors	2018
-- 210	Mythical Tales	2015

-- ======================================================================================================================================
-- ======================================================================================================================================


-- Inefficient
select film_id, title, release_year
from film
where film_id not in (
    select film_id
    from inventory
    where inventory_id in (
        select inventory_id
        from rental
        where rental_date >= date_sub((select max(rental_date) from rental), interval 3 month)
    )
)

-- Use joins

select distinct f.film_id, f.title, f.release_year
from film f left join inventory i on f.film_id = i.film_id
    left join rental r on i.inventory_id = r.inventory_id
and rental_date >= date_sub((select max(rental_date) from rental), interval 3 month)
where r.rental_id is null
order by f.release_year desc;
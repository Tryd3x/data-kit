-- Problem 21: Top Revenue Generating Movies by Location (Hard)
-- Problem:
-- Identify the top 5 revenue-generating movies for each store location in the past year. Include store_id, film_id, title, and total_revenue.

-- Constraints:

-- Use the following schema: store, rental, payment, inventory, film.
-- Only include revenue from the past 12 months.
-- Rank movies by total_revenue within each store.
-- Sort by store_id and total_revenue in descending order.
-- Output:

-- store_id	film_id	title	total_revenue
-- 1	101	Avengers	2000.00
-- 1	202	Inception	1800.00

-- ======================================================================================================================================
-- ======================================================================================================================================
with
    store_revenue as (
        select
            i.store_id,
            f.film_id,
            f.title,
            sum(p.amount) as total_revenue,
            rank() over (partition by store_id order by sum(p.amount) desc) as rnk    
        from
            payment p
            join rental r on r.rental_id = p.rental_id
            join inventory i on i.inventory_id = r.inventory_id 
            join film f on f.film_id = i.film_id
        where
            rental_date >= date_sub((select max(rental_date) from rental), interval 12 month)
        group by
            i.store_id,
            f.film_id
    )
select
    store_id,
    film_id,
    title,
    total_revenue
from
    store_revenue
where
    rnk <= 5

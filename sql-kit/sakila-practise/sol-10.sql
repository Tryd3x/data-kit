-- 10. Movie Pair Rentals
-- Problem: Determine the top 3 most frequently rented pairs of movies.

-- Constraints:

-- Consider only pairs rented by the same customer on the same day.
-- Output columns: movie_1, movie_2, rental_count.
-- Order by rental_count in descending order.
-- Expected Output:

-- movie_1	movie_2	rental_count
-- The Matrix	Inception	50
-- Avengers	Iron Man	45

-- ======================================================================================================================================
-- ======================================================================================================================================

with
    catalog as (
        select
            customer_id,
            rental_id,
            date(rental_date) as rental_date,
            film_id,
            title
        from 
            rental r join inventory using (inventory_id)
            join film using (film_id)
    )
select
    least(c1.title, c2.title) as movie_1,
    greatest(c1.title, c2.title) as movie_2,
    count(*) as rental_count
from
    catalog c1 join catalog c2
        on (c1.customer_id = c2.customer_id and c1.rental_date = c2.rental_date)
where
    c1.film_id < c2.film_id
group by
    c1.title, c2.title
order by
    rental_count desc
limit 3

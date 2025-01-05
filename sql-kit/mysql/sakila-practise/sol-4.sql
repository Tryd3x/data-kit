-- 4. Most Frequently Rented Movie Genres
-- Problem: Identify the top 3 most rented movie genres and their total rentals.

-- Constraints:

-- If two genres have the same number of rentals, rank them alphabetically.
-- Output columns: genre, total_rentals.
-- Expected Output:

-- genre	total_rentals
-- Action	250
-- Comedy	200
-- Thriller	175

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    c.name as genre,
    count(r.rental_id) as total_rentals
from
    rental r join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
    join film_category fc on i.film_id = fc.film_id
    join category c on fc.category_id = c.category_id
group by
    c.name
order by
    total_rentals desc,
    c.name
limit 3


-- 12. Most Popular Rental Times (Easy)
-- Problem:
-- Find the 3 most common rental times of the day. Include the hour and total_rentals.

-- Constraints:

-- Use the following schema:

-- rental:
-- rental_id, rental_date.
-- Extract the hour from rental_date.

-- Group by hour and count the number of rentals.

-- Sort by total_rentals in descending order.

-- Output:

-- hour	total_rentals
-- 18	150
-- 19	145

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    hour(rental_date) as hour,
    count(rental_id)  as total_rentals
from
    rental
group by
    hour(rental_date)
order by
    total_rentals desc
limit 3


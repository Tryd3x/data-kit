-- 5. Busiest Rental Hours
-- Problem: Find the 3 busiest hours of the day for rentals.

-- Constraints:

-- Output columns: hour, total_rentals.
-- Consider rental_date for extracting hours.
-- If two hours have the same number of rentals, order them numerically.
-- Expected Output:

-- hour	total_rentals
-- 18	120
-- 19	110
-- 20	105

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    hour(rental_date) as hour,
    count(rental_id) as total_rental
from
    rental
group by
    hour(rental_date)
order by
    total_rental desc
limit 3

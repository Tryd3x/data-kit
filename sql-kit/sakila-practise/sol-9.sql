-- 9. Peak Rental Days
-- Problem: Find the day of the week with the highest total rentals.

-- Constraints:

-- Output columns: day_of_week, total_rentals.
-- If two days have the same rentals, rank them alphabetically.
-- Expected Output:

-- day_of_week	total_rentals
-- Saturday	500
-- Friday	450

-- ======================================================================================================================================
-- ======================================================================================================================================


select
    dayname(payment_date) as day_of_week,
    count(rental_id) as total_rentals
from 
    payment
group by
    dayname(payment_date)
order by
    total_rentals desc
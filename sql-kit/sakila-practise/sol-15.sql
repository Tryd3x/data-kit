-- 15. Rentals by Day of the Week (Medium)
-- Problem:
-- Find the total rentals for each day of the week in the past year. Include day_of_week and total_rentals.

-- Constraints:

-- Use the following schema:

-- rental:
-- rental_id, rental_date.
-- Extract the day of the week from rental_date.

-- Sort results by total_rentals in descending order.

-- Output:

-- day_of_week	total_rentals
-- Saturday	200
-- Friday	180

-- ======================================================================================================================================
-- ======================================================================================================================================
with
    cutoff_date as (
        select date_sub(max(rental_date), interval 12 month) as cutoff
        from rental
    )
select
    dayname(rental_date) as day_of_week,
    count(*) as total_rentals
from
    rental 
where
    rental_date >= (select cutoff from cutoff_date)
group by
    dayname(rental_date)
order by
    total_rentals desc

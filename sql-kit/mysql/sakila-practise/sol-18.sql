-- 18. Frequent Customer Pairs (Hard)
-- Problem:
-- Identify the top 3 customer pairs who rented movies on the same day most frequently. Include customer_1, customer_2, and total_shared_rentals.

-- Constraints:

-- Use the following schema:

-- rental.
-- Only include customer pairs who rented movies on the same day at least once.

-- Sort by total_shared_rentals in descending order.

-- Output:

-- customer_1	customer_2	total_shared_rentals
-- John Doe	Alice Johnson	5

-- ======================================================================================================================================
-- ======================================================================================================================================
with
    rental_count as (
        select  
            date(rental_date) as date,
            customer_id,
            concat(first_name, " ", last_name) as name,
            count(rental_id) as rentals
        from
            rental r
            join customer c using (customer_id)
        group by
            date(rental_date),
            customer_id
    )
select 
    r1.name as customer_1,
    r2.name as customer_2,
    r1.rentals + r2.rentals as total_shared_rentals
from
    rental_count r1 
    join rental_count r2 
        on r1.date = r2.date and r1.customer_id < r2.customer_id
group by
    r1.date,
    r1.customer_id,
    r2.customer_id
order by
    total_shared_rentals desc
limit 3

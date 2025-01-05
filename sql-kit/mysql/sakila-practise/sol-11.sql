-- 11. Customers Without Rentals (Easy)
-- Problem:
-- Find customers who have not made a rental in the past 2 months. Include their customer_id and name.

-- Constraints:

-- Use the following schema:

-- customer:
-- customer_id, first_name, last_name.
-- rental:
-- rental_id, customer_id, rental_date.
-- Combine first_name and last_name as name.

-- Exclude customers who have made any rental in the past year.

-- Sort by customer_id.

-- Output:

-- customer_id	name
-- 145	John Doe
-- 302	Alice Johnson

-- ======================================================================================================================================
-- ======================================================================================================================================
select
    customer_id,
    concat(first_name, " ", last_name) as name
from
    customer
where
    customer_id not in (
        select
            customer_id
        from
            rental
        where
            rental_date >= date_sub((select max(rental_date) from rental),interval 2 month)
            and customer_id is not null
    )
order by
    customer_id;

-- Optimized version
with
    recent_renters as (
        select distinct customer_id
        from rental
        where rental_date >= date_sub((select max(rental_date) from rental), interval 2 month)
    )
select  
    c.customer_id,
    concat(c.first_name," ",c.last_name) as name
from
    customer c left join recent_renters rr on c.customer_id = rr.customer_id
where
    rr.customer_id is NULL
order by
    c.customer_id;
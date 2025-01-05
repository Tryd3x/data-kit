-- 19. High-Performing Genres (Hard)
-- Problem:
-- List genres that generated at least $3,000 in revenue in the past year. Include genre and total_revenue.

-- Constraints:

-- Use the following schema:

-- payment, rental, film_category, category.
-- Only include genres with total revenue above $3,000.

-- Sort by total_revenue in descending order.

-- Output:

-- genre	total_revenue
-- Action	15000.00

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    c.name,
    sum(p.amount) as total_revenue
from
    payment p
    join rental r on p.rental_id = r.rental_id
    join inventory i on r.inventory_id = i.inventory_id
    join film_category fc on i.film_id = fc.film_id 
    join category c on fc.category_id = c.category_id
where
    p.payment_date >= date_sub((select max(payment_date) from payment), interval 1 year)
group by
    c.category_id
having
    total_revenue >= 3000
order by
    total_revenue desc

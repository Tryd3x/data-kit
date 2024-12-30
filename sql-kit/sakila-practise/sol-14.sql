-- 14. Customers Who Rented Specific Genres (Medium)
-- Problem:
-- List customers who rented at least one movie in the Comedy genre in the past 6 months. Include customer_id, name, and total_comedy_rentals.

-- Constraints:

-- Use the following schema:

-- customer, rental, film_category, category.
-- Only include rentals from the last 6 months.

-- Group by customer_id.

-- Filter customers who rented at least 1 Comedy movie.

-- Output:

-- customer_id	name	total_comedy_rentals
-- 145	John Doe	5

-- ======================================================================================================================================
-- ======================================================================================================================================
select
    r.customer_id,
    concat(first_name," ",last_name) as name,
    count(*) as total_comedy_rentals
from
    customer cm
    join rental r on cm.customer_id = r.customer_id 
    join inventory i on r.inventory_id = i.inventory_id
    join film_category f on i.film_id = f.film_id
    join category c on f.category_id = c.category_id
where
    c.name = 'Comedy'
    and rental_date >= date_sub((select max(rental_date) from rental), interval 6 month)
group by
    r.customer_id
having
    total_comedy_rentals >=1
order by
    total_comedy_rentals desc


-- optimized
WITH latest_rental_date AS (
    SELECT DATE_SUB(MAX(rental_date), INTERVAL 6 MONTH) AS cutoff_date
    FROM rental
)
SELECT
    r.customer_id,
    CONCAT(first_name, " ", last_name) AS name,
    COUNT(*) AS total_comedy_rentals
FROM
    customer cm
    JOIN rental r ON cm.customer_id = r.customer_id
    JOIN inventory i ON r.inventory_id = i.inventory_id
    JOIN film_category f ON i.film_id = f.film_id
    JOIN category c ON f.category_id = c.category_id
    JOIN latest_rental_date
WHERE
    c.name = 'Comedy'
    AND r.rental_date >= cutoff_date
GROUP BY
    r.customer_id
HAVING
    total_comedy_rentals >= 1
ORDER BY
    total_comedy_rentals DESC;

    
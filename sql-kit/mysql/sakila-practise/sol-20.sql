-- 20. Late Returns (Hard)
-- Problem:
-- Find customers who returned movies more than 7 days after the rental date. Include customer_id, name, film_id, title, and days_late.

-- Constraints:

-- Use the following schema: rental, customer, inventory, film.
-- Calculate days_late as the difference between return_date and rental_date.
-- Only include customers with days_late > 7.
-- Sort by days_late in descending order.
-- Output:

-- customer_id	name	film_id	title	days_late
-- 101	Alice Johnson	22	Inception	10
-- 205	John Smith	45	Avengers	8

select
    c.customer_id,
    concat(first_name, " ", last_name) as name,
    f.film_id,
    f.title,
    datediff(r.return_date, r.rental_date) as days_late
from
    customer c
    join rental r on c.customer_id = r.customer_id
    join inventory i on r.inventory_id = i.inventory_id
    join film f on i.film_id = f.film_id
where
    datediff(r.return_date, r.rental_date) > 7
order by
    days_late desc

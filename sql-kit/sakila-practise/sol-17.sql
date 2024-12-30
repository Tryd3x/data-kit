-- 17. High Spending Customers (Hard)
-- Problem:
-- Find customers who spent more than $150 in total in the past year. Include customer_id, name, and total_spent.

-- Constraints:

-- Use the following schema:

-- customer, payment.
-- Combine first_name and last_name as name.

-- Only include payments made in the past year.

-- Sort results by total_spent in descending order.

-- Output:

-- customer_id	name	total_spent
-- 101	Alice Johnson	1500.00

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    c.customer_id,
    concat(c.first_name, " ", c.last_name) as name,
    sum(amount) as total_spent
from
    customer c  
    join payment p on c.customer_id = p.customer_id
where
    payment_date >= date_sub((select max(payment_date) from payment), interval 1 year)
group by
    c.customer_id,
    concat(c.first_name, " ", c.last_name)
having
    total_spent > 150
order by
    total_spent desc

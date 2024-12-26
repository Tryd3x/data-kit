-- 1. Top 5 Customers by Total Spending
-- Problem: Find the top 5 customers who have spent the most on rentals. Include their customer_id, name, and total_spent.

-- Constraints:

-- Include customers with at least 5 transactions.
-- Order by total_spent in descending order. If two customers have the same amount, sort them alphabetically by name.
-- Expected Output:

-- customer_id	name	total_spent
-- 45	John Doe	500.00
-- 32	Alice Smith	475.00
-- 67	Charlie Brown	460.00
-- 12	Emily White	455.00
-- 89	Bob Johnson	450.00


-- ======================================================================================================================================
-- ======================================================================================================================================


with 
customer_rentals as (
    select customer_id
    from rental
    group by customer_id
    having count(rental_id) >=5
),
total_amount as (
    select customer_id, sum(amount) as total_spent
    from payment
    where customer_id in (select * from customer_rentals)
    group by customer_id
)

select c.customer_id, concat(first_name," ", last_name) as name, total_spent
from customer c join total_amount ta
where c.customer_id = ta.customer_id
order by total_spent desc, name 
limit 5;
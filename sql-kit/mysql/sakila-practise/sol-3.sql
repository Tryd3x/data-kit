-- 3. Revenue by Month
-- Problem: Calculate the total revenue generated for each month in the past year.

-- Constraints:

-- Only include months where total revenue is greater than $1000.
-- Output columns: month, year, total_revenue.
-- Expected Output:

-- month	year	total_revenue
-- 12	2023	1200.50
-- 11	2023	1450.00
-- 10	2023	1350.75

-- ======================================================================================================================================
-- ======================================================================================================================================

select 
    month(payment_date) as month,
    year(payment_date) as year, 
    sum(amount) as total_revenue
from payment
group by month(payment_date), year(payment_date)
having sum(amount) > 1000
order by year, month;
-- 6. Employees with Sales Above Average
-- Problem: Find employees whose total sales exceed 110% of the average total sales across all employees.

-- Constraints:

-- Include their employee_id, name, and total_sales.
-- Order the results by total_sales in descending order.
-- Expected Output:

-- employee_id	name	total_sales
-- 1	John Doe	6000.00
-- 3	Alice Johnson	5800.00

-- ======================================================================================================================================
-- ======================================================================================================================================

select
    staff_id as employee_id,
    concat(first_name, " ", last_name) as name,
    sum(amount) as total_sales
from
    payment p join staff s using (staff_id)
group by
    staff_id
having 
    sum(amount) > (select 1.1*avg(amount) from payment)
order by
    total_sales desc
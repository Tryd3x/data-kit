-- 7. Customer Retention Rates
-- Problem: Calculate the retention rate for each month in the past year. Retention rate = (Number of customers with a rental this month who also rented last month) / (Number of customers who rented last month).

-- Constraints:

-- Output columns: month, year, retention_rate (percentage with 2 decimal places).
-- Only include months where at least 10 customers rented.
-- Expected Output:

-- month	year	retention_rate
-- 12	2023	80.50%
-- 11	2023	75.25%
-- 10	2023	82.00%

-- ======================================================================================================================================
-- ======================================================================================================================================

with
    unique_customer as (
        select
            month(rental_date) as month, 
            year(rental_date) as year,
            count(distinct customer_id) as unique_customers
        from
            rental
        group by
            month(rental_date), year(rental_date)
    ),
    reg_customer as (
        select
            month(r2.rental_date) as month,
            year(r2.rental_date) as year,
            count(distinct customer_id) as customers
        from
            rental r1 join rental r2 using (customer_id)
        where
            timestampdiff(month, r1.rental_date, r2.rental_date) = 1
        group by
            month(r2.rental_date), year(r2.rental_date)

    )
SELECT
    uc.month,
    uc.year,
    concat(ROUND((rc.customers / uc.unique_customers) * 100, 2),'%') AS retention_rate
FROM
    unique_customer uc
JOIN
    reg_customer rc
    ON uc.month = rc.month - 1 AND uc.year = rc.year
WHERE
    uc.unique_customers >= 10
ORDER BY
    uc.year, uc.month;



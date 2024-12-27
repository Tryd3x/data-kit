-- 8. Anomalous Revenue Days
-- Problem: Identify days where the total revenue was at least 30% higher or lower than the average daily revenue for the past year.

-- Constraints:

-- Output columns: date, total_revenue, difference_from_avg (positive/negative).
-- Order by difference_from_avg in descending order.
-- Expected Output:

-- date	total_revenue	difference_from_avg
-- 2023-12-15	1500.00	+500.00
-- 2023-11-22	500.00	-500.00

-- ======================================================================================================================================
-- ======================================================================================================================================

with overall_avg as (
    select
        avg(daily_revenue) as avg_daily_revenue
    from (
        select 
            date(payment_date) as date,
            sum(amount) as daily_revenue
        from payment
        group by date(payment_date)
    ) daily_totals
)

select
    date(payment_date) as date,
    sum(amount) as total_revenue,
    round(sum(amount) - (select avg_daily_revenue from overall_avg),2) as difference_from_avg
from
    payment
group by
    date(payment_date)
having
    abs(difference_from_avg) >=0.3*(select avg_daily_revenue from overall_avg)
order by
    difference_from_avg desc

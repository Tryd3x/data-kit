-- Problem 26: Advanced Customer Lifecycle Analysis (Hard)
-- Scenario:
-- The video rental company now wants a deeper understanding of customer behaviors, including complex patterns and trends across multiple dimensions. You need to generate actionable insights using advanced SQL techniques.

-- Dataset:

-- customer: Customer demographic information (customer_id, first_name, last_name, create_date, active, last_update).
-- rental: Rental details (rental_id, customer_id, rental_date, return_date).
-- payment: Payment transactions (payment_id, customer_id, rental_id, amount, payment_date).
-- film: Film information (film_id, title, description, release_year, rental_rate).

-- ======================================================================================================================================

-- Questions
-- a) Customer Churn with Trends:

-- Identify customers who have not rented any movies in the last 1 month but were active in the 1 month before that for the year 2005
-- Include customer_id, name, and last_active_period (e.g., Jan-Jun 2023).
-- Expected Output:

-- customer_id	name	last_active_period
-- 101	Alice Johnson	Jan-Jun 2023
-- 202	John Smith	Jan-Jun 2023
-- ======================================================================================================================================
with
    recent_rentals as (
        select 
            customer_id
        from
            rental
        where
            rental_date >= date_sub((select max(rental_date) from rental where year(rental_date)=2005), interval 1 month)
    ),
    no_recent_rentals as (
    select 
    distinct
        customer_id
    from    
        rental
    where
        customer_id not in (select customer_id from recent_rentals)
    ),
    active_rentals as (
        select
        distinct
            customer_id
        from
            rental
        where
            rental_date 
                between date_sub((select max(rental_date) from rental where year(rental_date)=2005), interval 2 month)
                    and date_sub((select max(rental_date) from rental where year(rental_date)=2005), interval 1 month)
    )
select
    customer_id,
    concat(first_name, " ", last_name) as name
from
    rental
    join customer using (customer_id)
where
    customer_id in (
        select customer_id from no_recent_rentals
    )
    and customer_id in (
        select customer_id from active_rentals
    )



-- ======================================================================================================================================

-- b) Most Profitable Genres by Region:
-- Identify the top 3 genres by total revenue for each region (state/city).
-- Include region, genre, and total_revenue.
-- Expected Output:

-- region	genre	total_revenue
-- Los Angeles	Action	5000.00
-- New York	Comedy	4500.00
-- ======================================================================================================================================

-- ======================================================================================================================================

-- c) Customer Segmentation by Lifetime Value:
-- Group customers into 4 tiers based on their lifetime spending:
-- Platinum: $1000+.
-- Gold: $500–999.
-- Silver: $100–499.
-- Bronze: <$100.
-- Include tier, customer_count, and average_spending.
-- Expected Output:

-- tier	customer_count	average_spending
-- Platinum	50	1200.00
-- Gold	100	750.00
-- ======================================================================================================================================

-- ======================================================================================================================================

-- d) Peak Rental Days by Movie Release Year:
-- Find the peak rental day for each movie release year. Include release_year, peak_rental_day, and total_rentals.
-- Expected Output:

-- release_year	peak_rental_day	total_rentals
-- 2020	Saturday	200
-- 2019	Friday	150
-- ======================================================================================================================================

-- ======================================================================================================================================

-- e) Revenue Recovery Opportunities:
-- Identify the 5 customers who rented the most movies in the past year but have had zero rentals in the last 3 months. Include customer_id, name, and last_rental_date.
-- Expected Output:

-- customer_id	name	last_rental_date
-- 301	Emily Brown	2023-08-15
-- 302	Jake White	2023-08-20
-- ======================================================================================================================================

-- ======================================================================================================================================

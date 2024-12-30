-- 16. Movies Rented in Sequential Months (Hard)
-- Problem:
-- Identify movies that were rented in at least 3 consecutive months in the past year. Include film_id and title.

-- Constraints:

-- Use the following schema:

-- rental, inventory, film.
-- Group by film_id and count the number of consecutive months where the movie was rented.

-- Only include movies rented in at least 3 consecutive months.

-- Output:

-- film_id	title
-- 14	The Matrix
-- 22	Inception

-- ======================================================================================================================================
-- ======================================================================================================================================

-- USING joins
with
    rentals as (
        select distinct
            i.film_id,
            f.title,
            year(r.rental_date) as rental_year,
            month(r.rental_date) as rental_month
        from
            rental r
            join inventory i on r.inventory_id = i.inventory_id
            join film f on i.film_id = f.film_id
        where
            r.rental_date >= date_sub((select max(rental_date) from rental), interval 12 month)
    )
select distinct
    r1.film_id,
    r1.title
from
    rentals r1
    join rentals r2 
        on r1.film_id = r2.film_id
        and (
            (r1.rental_year = r2.rental_year AND r1.rental_month = r2.rental_month-1)
            or (r1.rental_year = r2.rental_year-1 AND r1.rental_month = 12 AND r2.rental_month = 1)
        )
    join rentals r3
        on r2.film_id = r3.film_id
        and (
            (r2.rental_year = r3.rental_year AND r2.rental_month = r3.rental_month-1)
            or (r2.rental_year = r3.rental_year-1 AND r2.rental_month = 12 AND r3.rental_month = 1)
        )
order by
    r1.film_id 

-- USING LEAD()
with 
    temp as (
        select distinct
            f.film_id as film_id,
            f.title as title,
            year(r.rental_date) as year1,
            month(r.rental_date) as month1,
            lead(year(r.rental_date)) over (partition by f.film_id order by year(r.rental_date), month(r.rental_date)) as year2,
            lead(month(r.rental_date)) over (partition by f.film_id order by year(r.rental_date), month(r.rental_date)) as month2,
            lead(year(r.rental_date),2) over (partition by f.film_id order by year(r.rental_date), month(r.rental_date)) as year3,
            lead(month(r.rental_date),2) over (partition by f.film_id order by year(r.rental_date), month(r.rental_date)) as month3
        from
            rental r
            join inventory i on r.inventory_id = i.inventory_id
            join film f on i.film_id = f.film_id
        where
            r.rental_date >= date_sub((select max(rental_date) from rental), interval 1 year)
    )
select 
    film_id, title
from 
    temp
where
    (
        (year2 = year1 and month2 - month1 = 1)
        or (year1 + 1 = year2 and month1 = 12 and month2 = 1)
    )
    and
    (
        (year3 = year2 and month3 - month2 = 1)
        or (year2 + 1 = year3 and month2 = 12 and month3 = 1)
    )
order by
    film_id

-- Work on a dynamic solution for n consecutive months
with
    tk1 as (
        select distinct
            f.film_id as film_id,
            f.title as title,
            year(r.rental_date)*12 + month(r.rental_date) as norm_date
        from
            rental r
            join inventory i on r.inventory_id = i.inventory_id
            join film f on i.film_id = f.film_id
        where
            r.rental_date >= date_sub((select max(rental_date) from rental), interval 1 year)
    ),
    consecutive_grp as (
        select 
            film_id,
            title,
            norm_date,
            row_number() over (partition by film_id order by norm_date) as row_num,
            norm_date - row_number() over (partition by film_id order by norm_date) as diff
        from
            tk1
    )
select 
    film_id,
    title
from 
    consecutive_grp
group by
    film_id,
    title
having
    count(diff) >= 3
order by
    film_id

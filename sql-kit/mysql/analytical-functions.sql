-- ====================================
-- ========Analytical Functions========
-- ====================================
-- Retrieves the value of next|prev row by offset
-- (LEAD|LAG)(expression, offset, default) OVER (
--   [PARTITION BY partition_expression, ... ]
--   [ORDER BY order_expression [ASC|DESC], ... ]
-- )
-- expression = column_name or boolean_expression
-- offset = skip row
-- default = if no rows returned, default to what

-- Query - Fetch employee ID whose AVERAGE salary is more than the next consecutive employee
WITH
    avg_sal AS (
        SELECT
            emp_no,
            AVG(salary) as average_salary
        FROM
            salaries
        GROUP BY
            emp_no
    ),
    sal_diff AS (
        SELECT
            emp_no,
            average_salary - LEAD(average_salary,1) OVER() AS diff
        FROM
            avg_sal
    )
SELECT
    emp_no
FROM
    sal_diff
WHERE
    diff > 0



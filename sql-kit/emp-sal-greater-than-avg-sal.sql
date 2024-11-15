--- Query to find the list of employees whose salary is more than the average salary with respect to all employees
--- Two variations of the query:
--- 1. Join is better approach
--- 2. Subquery would re-run leading to optimization issue

WITH 
    avg_salary_all_employees AS (
        SELECT
            CAST(ROUND(AVG(s.salary), 2) AS SIGNED) AS avg_salary
        FROM
            salaries s
    ),
    total_emp_salary_ AS (
        SELECT
            s.emp_no,
            SUM(s.salary) as salary
        FROM
            salaries s
        GROUP BY
            s.emp_no
    )
SELECT
    *
FROM
    total_emp_salary_ tes 
    JOIN avg_salary_all_employees asae
WHERE
    tes.salary > asae.avg_salary
    -- (SELECT avg_salary FROM avg_salary_all_employees) 


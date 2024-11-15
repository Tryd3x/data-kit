-- https://www.tutorialspoint.com/mysql/mysql-date-time-functions.htm

-- Current Date+Time
SELECT NOW() AS cur_date_time;
SELECT CURRENT_TIMESTAMP;

-- Current Time
SELECT CURTIME() AS cur_time;
SELECT CURRENT_TIME;

-- Current Date
SELECT CURDATE() AS cur_date;
SELECT CURRENT_DATE;

-- Extract date from datetime
SELECT DATE('1996-09-26 16:44:15.581');

-- Extract time from datetime
SELECT TIME('1996-09-26 16:44:15.581');

-- Extract units from datetime
-- EXTRACT(params FROM column_name)
-- params:  MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
SELECT EXTRACT(MICROSECOND FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(SECOND FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(MINUTE FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(HOUR FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(DAY FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(WEEK FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(MONTH FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(QUARTER FROM '1996-09-26 16:44:15.581');
SELECT EXTRACT(YEAR FROM '1996-09-26 16:44:15.581');


-- =========================================================
-- ================== INTERVAL FUNCTION ====================
-- =========================================================

-- Add interval to date
-- DATE_ADD(date, INTERVAL expr_type)
-- expr_type: int PARAM
-- PARAM: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 MICROSECOND);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 SECOND);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 MINUTE);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 HOUR);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 DAY);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 WEEK);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 MONTH);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 QUARTER);
SELECT DATE_ADD('1996-09-26 16:44:15.581', INTERVAL 1 YEAR);

-- Subtract interval from date
-- DATE_SUB(date, INTERVAL expr_type)
-- expr_type: int PARAM
-- PARAM: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 MICROSECOND);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 SECOND);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 MINUTE);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 HOUR);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 DAY);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 WEEK);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 MONTH);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 QUARTER);
SELECT DATE_SUB('1996-09-26 16:44:15.581', INTERVAL 1 YEAR);

-- =========================================================
-- =========================================================

--  difference between two dates (returns days)
-- DATEDIFF(date1, date2);
SELECT DATEDIFF('2019-01-13', '2017-01-03');

-- difference between two dates (control return)
-- TIMESTAMPDIFF(interval, date1, date2)
-- interval: MICROSECOND, SECOND, MINUTE, HOUR, DAY, WEEK, MONTH, QUARTER, YEAR
SELECT TIMESTAMPDIFF(MONTH, '2023-09-20', '2024-09-20');

-- Add two dates
SELECT ADDDATE('2017-01-13', '2017-01-03');
-- Add two time
SELECT ADDTIME('10:40:32.88558', '06:04:01.222222');

WITH
    student_subject_pair AS (
        SELECT DISTINCT
            *
        FROM
            students stu, subjects sub
    ),
    attendees AS (
        SELECT DISTINCT
            ssp.student_id,
            ssp.subject_name,
            COUNT(e.student_id) as attended_exams
        FROM
            student_subject_pair ssp
            LEFT JOIN examinations e 
                ON ssp.student_id = e.student_id
                AND ssp.subject_name = e.subject_name
        GROUP BY
            ssp.student_id,
            ssp.subject_name
    )
SELECT
    s.student_id,
    s.student_name,
    a.subject_name,
    a.attended_exams
FROM
    students s JOIN attendees a ON s.student_id = a.student_id
ORDER BY
    s.student_id,
    a.subject_name

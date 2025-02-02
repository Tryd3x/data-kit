-- interval units crossing their limits would automatically be normalized
-- 26 hours -> changed to 1 day 2 hours
-- 34 days -> changed to 1 month 3 days, etc
SELECT justify_hours(INTERVAL '50 days 26 hours 25 minutes');


-- Extract/Convert date to a specific format
SELECT TO_CHAR(TIMESTAMP '1996-09-26 16:44:15.581', 'MM-YYYY')

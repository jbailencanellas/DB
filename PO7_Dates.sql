--query 2
--MariaDB
select LAST_DAY(NOW()) as myday;
--Postgres
SELECT (
        date_trunc('month', now()) + interval '1 month - 1 day'
    )::date;
--query 3
--MariaDB
select LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 3 month)) as myday;
--Postgres
SELECT (
        date_trunc('month', now()) - interval '3 months' + interval '1 month - 1 day'
    )::date as myday;
--query 4
--MariaDB
select DATE_FORMAT(
        LAST_DAY(DATE_SUB(CURDATE(), INTERVAL 3 month)),
        '%M  %d, %y'
    ) as myday;
--Postgres
SELECT TO_CHAR(
        (
            date_trunc('month', now()) - interval '3 months' + interval '1 month - 1 day'
        )::date,
        'Month DD,YY'
    ) as myday;
--query 5
--MariaDB
SELECT CONVERT_TZ(NOW(), 'Europe/Madrid', 'Europe/Madrid') AS datetime_madrid,
    CONVERT_TZ(NOW(), 'Europe/Madrid', 'America/Panama') AS datetime_panama;
--Postgres
SELECT CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Madrid' as datetime_madrid,
    CURRENT_TIMESTAMP AT TIME ZONE 'America/Panama' as datetime_panama;
--query 6
--MariaDB
SELECT CONVERT_TZ(NOW(), 'Europe/Madrid', 'Europe/Madrid') AS datetime_madrid,
    CONVERT_TZ(NOW(), 'Europe/Madrid', 'Australia/Sydney') AS datetime_sydney;
--Postgres
SELECT CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Madrid' as datetime_madrid,
    CURRENT_TIMESTAMP AT TIME ZONE 'Australia/Sydney' as datetime_sydney;
--query 7
--MariaDB
SELECT DATE_SUB(
        CONVERT_TZ(NOW(), 'Europe/Madrid', 'Europe/Madrid'),
        INTERVAL '3:25' HOUR_MINUTE
    ) AS datetime_madrid,
    DATE_SUB(
        CONVERT_TZ(NOW(), 'Europe/Madrid', 'Australia/Sydney'),
        INTERVAL '3:25' HOUR_MINUTE
    ) AS datetime_sydney;
--Postgres
SELECT CURRENT_TIMESTAMP AT TIME ZONE 'Europe/Madrid' - interval '3 hour 25 min' as datetime_madrid,
    CURRENT_TIMESTAMP AT TIME ZONE 'Australia/Sydney' - interval '3 hour 25 min' as datetime_sydney;
--query 8
--MariaDB
SELECT DATEDIFF(MAX(start_date), MIN(start_date)) AS MyDay
FROM employees;
--Postgres
select max(start_date) - min(start_date) as MyDay
from employees;
--query 9
--MariaDB
select surname,
    name,
    start_date
from employees
where dayofweek(start_date) = 3;
--Postgres
select surname,
    name,
    start_date
from employees
where extract(
        dow
        from start_date
    ) = 2;
--query 10
--MariaDB
select *
from employees
order by start_date asc
limit 1;
--Postgres
select *
from employees
order by start_date asc
limit 1;
--query 11
--MariaDB
select surname,
    name,
    TIMESTAMPDIFF(YEAR, start_date, now()) as years,
    TIMESTAMPDIFF(MONTH, start_date, now()) %12 as months
from employees
order by years desc;
--Postgres
select surname,
    name,
    date_part('year', age(start_date)) as years,
    date_part('month', age(start_date)) as months
from employees
order by years desc;
--query 12
--MariaDB
select year(start_date) as Year,
    month(start_date) as Month,
    day(start_date) as Day
from employees;
--Postgres
select date_part('YEAR', start_date) as Year,
    date_part('MONTH', start_date) as Month,
    date_part('DAY', start_date) as Day
from employees
order by Year asc;
--query 13
--MariaDB
select surname,
    name,
    start_date
from employees
where MONTHNAME(start_date) = 'june';
--Postgres
select surname,
    name,
    start_date
from employees
where trim(to_char(start_date, 'month')) = 'june';
--query 14
--MariaDB
select surname,
    name,
    date_format(start_date, '%W %d %M %Y %T') as 'start_date'
from employees
where MONTHNAME(start_date) = 'june';
--Postgres
select surname,
    name,
    to_char(start_date::date, 'Day Month, YYYY HH24:MI:SS') as date
from employees
where trim(to_char(start_date, 'month')) = 'june';
--query 15
--MariaDB
select YEAR(start_date) as Year,
    count(surname) as num_employees
from employees
group by YEAR(start_date);
--Postgres
select extract(
        Year
        from start_date
    ) as Year,
    count(surname) as num_employees
from employees
group by extract(
        Year
        from start_date
    )
order by Year asc;
--query 16
--MariaDB
select year(start_date) as years,
    count(*) as num_employees
from employees
group by year(start_date)
having count(*) = (
        select min(num_employees)
        from (
                select count(*) as num_employees
                from employees
                group by year(start_date)
            ) as minim
    )
order by years desc;
--Postgres
select extract(
        Year
        from start_date
    ) as Year,
    count(surname) as num_employees
from employees
group by extract(
        Year
        from start_date
    )
HAVING COUNT(*) = (
        select min(num_employees)
        from (
                select count(*) as num_employees
                from employees
                group by extract(
                        Year
                        from start_date
                    )
            ) as minim
    )
order by Year desc;
--query 17
--MariaDB
select year(start_date),
    count(*) as num_employees
from employees
group by year(start_date)
having count(*) = (
        select max(num_employees)
        from (
                select count(*) as num_employees
                from employees
                group by year(start_date)
            ) as maxim
    );
--Postgres
select extract(
        Year
        from start_date
    ) as Year,
    count(surname) as num_employees
from employees
group by extract(
        Year
        from start_date
    )
HAVING COUNT(*) = (
        select max(num_employees)
        from (
                select count(*) as num_employees
                from employees
                group by extract(
                        Year
                        from start_date
                    )
            ) as maxim
    );
--query 18
--MariaDB
select num,
    name,
    surname,
    TIMESTAMPDIFF(YEAR, start_date, now()) as years
from employees
where occu_code = 'MAN'
order by years desc;
--Postgres
select num,
    name,
    surname,
    date_part('year', age(start_date)) as years
from employees
where occu_code = 'MAN'
order by years desc;
--query 19
--MariaDB
select num,
    name,
    surname,
    TIMESTAMPDIFF(YEAR, start_date, now()) as years
from employees
where occu_code = 'MAN'
    and TIMESTAMPDIFF(YEAR, start_date, now()) > 5
order by years desc;
--Postgres
    select num,
        name,
        surname,
        date_part('year', age(start_date)) as years
    from employees
    where occu_code = 'MAN'
        and date_part('year', age(start_date)) > 5
    order by years desc;
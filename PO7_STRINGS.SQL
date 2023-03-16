--query 1
SELECT concat_ws(' ', name, surname) as fullname
from employees;
--query 2
--POSTGRES
select to_char(commission, 'FM99,999.00') as CommissionFormatted
from employees;
--MARIADB
select format(commission, 2, 'es_ES') as CommissionFormatted
from employees;
--query 3
select surname,
  POSITION('A' in surname) FirstA
from employees;
--query 4
SELECT surname,
  if (
    position(
      'A' in SUBSTRING(surname, position('A' in surname) + 1)
    ) <> 0,
    position(
      'A' in SUBSTRING(surname, position('A' in surname) + 1)
    ) + position('A' in surname),
    '0'
  ) as SecondA
from employees;
--query 5
select CONCAT_WS(
    ' ',
    CONCAT(
      UPPER(LEFT(E.name, 1)),
      LOWER(SUBSTRING(E.name, 2))
    ),
    CONCAT(
      UPPER(LEFT(E.surname, 1)),
      LOWER(SUBSTRING(E.surname, 2))
    )
  ) AS FullName
from employees E;
--query 6
SELECT CONCAT_WS(
    ' ',
    REPLACE(NAME, 'IO', 'IOTE'),
    REPLACE(SURNAME, 'IO', 'IOTE')
  ) as iote_name
from employees;
--query 7
update employees
set name = replace(name, 'AN', '')
where name like 'ANTO%';
--query 8
SELECT concat_ws('_', left(surname, 2), SUBSTR(SURNAME, 3)) AS SURNAME
from employees;
--query 9
SELECT (left(surname, 1)) AS FistChar,
  ASCII(LEFT(SURNAME, 1)) as SurnameASCII
from employees;
--query 10
SELECT CONCAT_WS(' ', TRIM(name), TRIM(surname)) as Fullname
from employees;
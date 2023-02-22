--2

    SELECT
    id,
    name,
    surname,
    mark
    from students
    where mark > 3.6
    order by mark desc
    ;

--16

(select min(mark) from students)
UNION
(select max(mark) from students);

--17

    SELECT
    max(mark)-min(mark) as difference 
    from students;

--18

    SELECT
    distinct S.ID,
    S.surname,
    S.name,
    count(A.college) OVER ( PARTITION BY S.id)
    from students S, applies A
    where A.stid = S.id
    group by A.college, S.id
    ORDER BY S.surname, S.name, S.ID;

--19

(SELECT
S.surname,
S.name,
S.id,
count(*)
from students S, applies A
where S.id = A.stid
group by S.id)
;
(SELECT
S.surname,
S.name,
S.id,
count(*)
from students S, applies A
where S.id = A.stid
AND S.id not in ( select applies.stid from applies)
group by S.id)
;


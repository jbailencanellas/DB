--1 
-- Explicit Inner join

select T.name,
C.name
from towns T inner join countries C
on T.country = C.id
order by C.name, T.name;

--Implicit inner join

select T.name,
C.name
from towns T join countries C
on T.country = C.id
order by C.name, T.name;

--Left outer join

select T.name,
C.name
from towns T left outer join countries C
on T.country = C.id
order by C.name, T.name;

--Right outer join

select T.name,
C.name
from towns T right outer join countries C
on T.country = C.id
order by C.name, T.name;

--2
--explicit inner join

select 
TE.name,
T.name,
C.name
from teams TE 
inner join towns T on TE.town = T.id
inner join countries C on T.country = C.id
order by T.name, TE.name;

--implicit inner join

select 
TE.name,
T.name,
C.name
from teams TE 
join towns T on TE.town = T.id
join countries C on T.country = C.id
order by T.name, TE.name;

--left outer join

select 
TE.name,
T.name,
C.name
from teams TE 
left outer join towns T on TE.town = T.id
left outer join countries C on T.country = C.id
order by T.name, TE.name;

--right outer join

select 
TE.name,
T.name,
C.name
from teams TE 
right outer join towns T on TE.town = T.id
right outer join countries C on T.country = C.id
order by T.name, TE.name;

--full outer join

select 
TE.name,
T.name,
C.name
from teams TE 
full outer join towns T on TE.town = T.id
full outer join countries C on T.country = C.id
order by T.name, TE.name;

--3
--explicit inner join

select 
T.name,
count(TE.id) as num_teams
from towns T
inner join teams TE on T.id = TE.town
group by T.name
order by T.name
;

--left outer join

select 
T.name,
count(TE.id) as num_teams
from towns T
left outer join teams TE on T.id = TE.town
group by T.name
order by T.name
;

--4
select 
T.name
from towns T
LEFT outer join teams TE on T.id = TE.town
where TE.town is null
;

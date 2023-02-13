--1

select M.name, M.rank
from movies M, movies_genres MG
where M.id = MG.movie_id
and MG.genre = 'Horror'
order by rank desc
limit 10
;

--2

select name 
from movies 
where name like '% reo %'
or name like '%reo '
or name like ' reo%'
or name like 'reo %'
or name like '% reo'
or name like ' reos%'
or name like 'reos %'
or name like '% reos'
or name like 'reo'
or name like 'reos'
order by name;

--3

select distinct M.name
from movies M, movies_genres MG
where M.id = MG.movie_id
and M.name like 'Upper% '
or M.name like 'Upper%'
and M.id not in (select movie_id from movies_genres)
order by M.name
;

--4

select M.name 
from movies M, movies_directors MD, directors D, actors A, roles R
where M.id = MD.movie_id
and MD.director_id = D.id
and M.id = R.movie_id
and R.actor_id = A.id
and D.first_name = 'Francis Ford'
and D.last_name = 'Coppola'
and A.first_name = 'Marlon'
and A.last_name = 'Brando'
order by M.name
;

--5 

select concat(A.first_name, ' ' , A.last_name) as fullname, count(M.id) as num_movies
from movies M, roles R, actors A
where M.id = R.movie_id
and R.actor_id = A.id
and A.first_name = 'Gina'
and A.last_name = 'Lollobrigida'
group by fullname
;
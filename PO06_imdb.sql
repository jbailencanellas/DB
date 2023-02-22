select 
movies.name, 
count(*) as num_genres 
from movies 
join movies_genres on movies.id = movies_genres.movie_id 
group by movies.name 
order by num_genres desc 
limit 10;

SELECT COUNT(*) OVER (
    PARTITION BY to_char(start_date, 'Month'),
    to_char(start_date, 'YYYY')
  ) As NumPerMonth,
  concat(
    to_char(start_date, 'Month'),
    ' ',
    to_char(start_date, 'YYYY')
  ) As TheMonth,
  name,
  surname
FROM employees
ORDER BY start_date;

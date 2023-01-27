--8
select E.surname
from employees E, departments D
where E.dept_num = D.num and D.name = 'SALES'
;


--9

select D.name, sum(E.salary)
from employees E, departments D
where E.dept_num = D.num and D.name = 'SALES'
group by D.name;

--10
select D.name, count(E.num) as count_employees
from employees E, departments D
where E.dept_num = D.num and E.occu_code = 'EMP'
group by D.name;

--15

select O.name
from employees E, departments D, occupations O
where D.name = 'RESEARCH' and e.dept_num = D.num;




--18 
--Esto solo funcionaría si no tocan el codigo asociado al departamento
select E.surname, O.name
from employees E, occupations O
where E.occu_code = O.code and E.dept_num = (select num from departments where name='SALES');
 
--Con esta seguiría funcionando siempre y cuando no cambien el nombre, pero seguiría funcionando aunque le cambien el codigo asociado. 
select E.surname, O.name
from employees E, occupations O, departments D
where E.occu_code = O.code and 
E.dept_num = D.num and
D.name = 'SALES';

--19
--El group by es necesario cuando metes un parametro como el count.
select O.name, count(*) as number_of_employees
from employees E, occupations O, departments D
where E.occu_code = O.code and 
E.dept_num = D.num and
D.name = 'SALES'
group by O.name;

--Esto muestra los trabajadores que hay en cada departamento, divididos por su función.
select D.name, O.name, count(*) Number_of_employees
from employees E, occupations O, departments D
where E.occu_code = O.code and
E.dept_num = D.num
group by D.name, O.name
order by D.name, O.name;
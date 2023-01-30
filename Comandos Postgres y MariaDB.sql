##Postgres

create table departments (
  num int not null,
  name text not null,
  constraint pk_departments primary key (num)
);

create table employees (  
  num int not null,  
  name text not null,
  dnum int not null, 
  constraint pk_employees primary key (num),
  constraint fk_departments FOREIGN KEY (dnum) REFERENCES DEPARTMENTS(num)  
);
CREATE INDEX idx_fk_departments ON employees (dnum);

INSERT INTO departments VALUES (10, 'Accounting and finance');

##MariaDB

create table departments (  
  num int not null,  
  name varchar(50)  not null,
  constraint pk_departments primary key (num)  
);
create table employees (  
  num int not null,  
  name varchar(150) not null,
  dnum int not null, 
  constraint pk_employees primary key (num),
  constraint fk_departments FOREIGN KEY (dnum) REFERENCES departments (num)  
);

INSERT INTO departments VALUES (10, 'Accounting and finance');
INSERT INTO departments (name, num)
    VALUES ('Marketing and sales',20);
INSERT INTO departments (num, name) VALUES
(30, 'Human resources'), 
(40, 'Customer service'),
(50, 'Research and development');

INSERT INTO employees (name, num)
    VALUES ('Juan Gomez',20);

    -------------------------------------------------------------------------------------------------------

  /*TABLAS DE LA P05*/

    create table CUSTOMERS ( 
      EMAIL varchar(50) NOT NULL,
      ADRESS varchar(50),
      DATE_OF_BIRTH DATE,
      FNAME varchar(50),
      MNAME varchar(50),
      LNAME varchar(50),
      CONSTRAINT PK_CUSTOMER primary key (EMAIL)
    );

    create table ORDERS (
      ORDER_NUMBER serial NOT NULL,
      DATE_TIME timestamp default now(), 
      CUSTOMER_EMAIL varchar(50),
      CONSTRAINT PK_ORDERS primary key (ORDER_NUMBER),
      CONSTRAINT FK_ORDERS foreign key (CUSTOMER_EMAIL) REFERENCES CUSTOMERS (EMAIL)
    );

          --Datetime funciona en MariaDB
          --Autoincrement en MariaDB se llama serial.
          --Timestamp no mete la fecha automaticamente en postgres, pero si en MariaDB.

    create table ORDER_ITEMS (
      ITEM_LINE_NUMBER int not null,
      ORDER_NUMBER int not null,
      QUANTITY int,
      PRICE numeric (7,2),
      PRODUCT_CODE int,
      CONSTRAINT PK_ORDER_ITEM primary key (ITEM_LINE_NUMBER, ORDER_NUMBER),
      CONSTRAINT FK_ORDER_ITEM foreign key (PRODUCT_CODE, ORDER_NUMBER) REFERENCES PRODUCT(CODE)
    );

    create table PRODUCTS ( 
      CODE INT NOT NULL,
      NAME VARCHAR(50),
      PRICE NUMERIC(7,2),
      CONSTRAINT PK_PRODUCT primary key (CODE)
    );

-------------------------------------------------------------------------------------------------------------------------------------------------------

-- mariadb Email de Sergi #########################

-- mariadb
create table customers (
  `e-mail` varchar(150),
  fname varchar(50) not null,
  mname varchar(50),
  lname varchar(50) not null,
  address varchar(200) unique,
  date_of_birth date default '1900-1-1',
  constraint pk_customers primary key (`e-mail`)
);
create table orders (
  num int auto_increment primary key,
  date timestamp,
  `e-mail` varchar(150),
  constraint fk_orders foreign key (`e-mail`) references customers (`e-mail`)
);
create table products ( 
code varchar(5) primary key,
name varchar(20) not null,
price decimal(7,2)
);
create table order_items (
  order_number int, 
  line_number int not null,
  product_code varchar(5),
  quantity int default 1,
  price decimal(7,2),
  constraint pk_order_items primary key (order_number,line_number),
  constraint fk_1_order_items foreign key (order_number) references orders (num),
  constraint fk_2_order_items foreign key (product_code) references products (code)
);

----------

insert into customers (`e-mail`, fname, lname, address)
values ('s@noemail.org', 'Sergi', 'G.', 'Carcas, 6');

insert into orders (`e-mail`)
values ('s@noemail.org');

insert into products ( code, name, price ) values
('PLAY5', 'Playstation 5', 449.99),
('PLAY4', 'Playstation 4', 300.99),
('PLAY1', 'Playstation 1+games', 100.99);

insert into  order_items (order_number, line_number, product_code, price) values 
 ( 1, 1, 'PLAY5', 449.99),
 ( 1, 2, 'PLAY4', 300.99),
 ( 1, 3, 'PLAY1', 100.99);
---------

alter table products 
  add column description varchar(150);

alter table products
 modify description varchar(150) not null;

ALTER TABLE order_items
 MODIFY COLUMN line_number INT auto_increment;

----------

update products set description='A classic of my 40s' where code='PLAY1';

update products set description='The new flagship' where code='PLAY5';

update products set description='The remake generation' where code='PLAY4';

update products set name='Playstation 1' where code='PLAY1';



-- postgresql Email de Segi ####################

create table customers (
  "e-mail" varchar(150),
  fname varchar(50) not null,
  mname varchar(50),
  lname varchar(50) not null,
  address varchar(200) unique,
  date_of_birth date default '1900-1-1',
  constraint pk_customers primary key ("e-mail")
);
create table orders (
  number serial primary key,
  date timestamp default now(),
  "e-mail" varchar(150),
  constraint fk_orders foreign key ("e-mail") references customers ("e-mail")
);
create table products (
  code varchar(5) primary key,
  name varchar(50) not null,
  price money
);
create table order_items (
  order_number int, 
  line_number serial,
  product_code varchar(5),
  quantity int default 1,
  price money,
  constraint pk_order_items primary key (order_number,line_number),
  constraint fk_1_order_items foreign key (order_number) references orders (number),
  constraint fk_2_order_items foreign key (product_code) references products (code)
);

insert into customers ("e-mail", fname, lname, address)
values ('s@noemail.org', 'Sergi', 'G.', 'Carcas, 6');

insert into orders ("e-mail")
values ('s@noemail.org');

insert into  order_items (order_number, product_code, price)
 values ( 1, 'PLAY5', '449,99');

 insert into  order_items (order_number, product_code, price)
 values ( 1, 'PLAY4', '300,99');

 insert into  order_items (order_number, product_code, price)
 values ( 1, 'PLAY1', '100,99');

 alter table products
 add column description varchar(150);

 --Si lo quieres hacer todo de golpe:

 insert into  order_items (order_number, product_code, price) values 
 ( 1, 'PLAY5', '449,99'),
 ( 1, 'PLAY4', '300,99'),
 ( 1, 'PLAY1', '100,99');

--Si ho vols cambiar:

update order_items 
set quantity=2 
where order_number=1 
and product_code='PLAY4';


--Borrar una fila(ejemplo): delete from orders where number=2; / Aixó borraría la fila on el atribut 'number' sigui 2.
--Si lo quieres actualizar(ejemplo): update orders set number=2 where number=3; / Aixó agafarà el que sigui number 3 y ho canviarà a 2.

GRANT select ON SQL1NORMALAUTH.OCCUPATIONS TO 'adurango2'@'%';



------------------------------------------------------------------------------------------------------------

select 'num' as f1, name from departments;

select num, name, num + 10 as numupgrade from departments;


nombre apellido salario y salario + 20%

select surname, name, salary,
salary * 1.2 as revised_salary from employees;

select * 
from employees as E, departments as D
where E.dept_num = D.num;

select E.name, E.surname, E.start_date, E.salary, D.name as dept_name
from employees as E, departments as D
where E.dept_num = D.num;

select * from teachers, students, subjects, courses
where teachers.ID = students.ID and
teachers.ID = courses.ID;


select distinct name
from employees
order by name;

select num, surname from employees order by num asc;

select name, surname from employees order by surname asc, name desc;

\i /home/juanjobc/Escriptori/PO5copy.SQL

--Ejemplo de base de datos 'samplecompany' TEMA 6

/* Esto selecciona en la tabla emplyees los apellidos que empiecen por C y que tengan nombre que termine en A */
select * from employees where surname like 'C%' and name like '%A';


/* Junta las dos cosas seguidas en una sola columna*/
select concat(name, surname ) from employees;

/* Los junta pero separandolos con un guiń entre ellos */
select concat_ws('-', name, surname) from employees;

/*Te enseña los nombres y les resta las letras con respecto al número, de izquierda a derecha */
select substr(name, 2) from departments;
select substr(name, 4) from departments;

/*Coje la primera letra de la izquierda y la ultima letra de la derecha y lo muestra en respectivas columnas */
select name, left(name,1), right(name,1) from departments;

/* La función initcap te decapitaliza, pone la primera en mayúsuclas y el resto en minúsculas */
select concat_ws (' ', initcap(E.name), initcap(E. surname)) as FullName
from employees E;

/* Pone lo seleccionado en minúsculas */
select lower(name)
from employees;

/*Pone lo seleccionado en mayúsculas */
select upper(name)
from employees;

/* Esto crea una segunda tabla con la longitud de los apellidos y los ordena de más cortos a más largos */
select surname, length(surname)
from employees order by length(surname);

/*Junta dos columnas en 1, y el espacio en blanco es para que haya una separación entre ellas */
select concat(name, ' ', surname)
from employees;

select start_date, to_char(start_date, 'YYYY') from employees;

'MONTH' enseña el mes en mayúsculas
'Month' enseña el mes con solo la primera letra en mayúsuclas
'month' enseña el mes en minúsculas
'mon' enseña solo las 3 primeras letras del mes
'MM' para que enseñe el mes con números

'desc' es para especificar que quieres que se ordene de manera descendente

/*Selecciona todo de employees donde el mes de comienzo sea igual a 2, o sea, en febrero */
select * from employees where to_char(start_date, 'MM')=2;

/*Convierte lo de dentro en número ya que to_char enseña texto, asi que cast lo convierte en número para que no de error */
select * from employees where cast(to_char(start_date, 'MM')as integer) =2;

/*Ejemplo de Alter table */
alter table hola add primary key (un);
alter table hola add constraint fk_grade_id references grades(ID);

alter table hola 
 rename COLUMN  saludo to saludito;

ALTER TABLE hola
RENAME TO holaaa;

alter table tablename 
add constraint fk_table_1 foreign key (column-name) references otratabla (suprimarykey);


/*esto seleccionará solo a los trabajadores que empezaron a trabajar entre las fechas puestas */
select * from employees where start_date between '1/1/2018' and '31/12/2018';
/* tambien se puede poner así */
select * from employees where start_date >= '1/1/2018' and start_date <= '31/12/2018';

/* Esto hará la consulta pero el limit hará que solo se muestren los primeros 4 resultados */
select name, surname from employees order by surname, name limit 4;


offset = filas que se tiene que saltar antes de empezar a contar.
limit = especificar la cantidad de resultados que quieres que se muestren en una consulta.


/*ejemplo de filtraje en un producto cartesiano ( usando la base de datos samplecompany):*/
select * from departments, towns where towns.code = departmetns.town_code;

select D.name as department, T.name as town from departments as D, towns as T where D.town_code = T.code;

select * from 
employees, departments, towns
where employees.dept_num = departments.num and 
departments.town_code = towns.code;

/* lista de todos los apellidos y nombres de los trabajadores de la empresa,
 junto con el departamentos donde trabajan y la ciudad donde está ubicado, IMPORTANTE */
select E.surname, E.name, D.name as department, T.name as town
from employees E,
 departments D,
  towns T
where E.dept_num = D.num and 
D.town_code = T.code
order by D.name;

/*ejemplo de UNION */
(select name, surname, start_date
from employees
where year(start_date) = 2004)
UNION
(select name, surname, start_date
from employees
where year(start_date) = 2010);

select name 
from departments
union select name from towns;

/*selecciona los nombres, apellidos y fecha de inicio de los empleados que empezaron en 2004 o 2010. 
SOLO EN POSTGRES aunque mariadb también se lo come*/
select name, surname, start_date from employees
where to_char(start_date, 'YYYY') = '2004'
or to_char(start_date, 'YYYY') = '2010';

/* muestra los trabajadores que empezaron a trabajar en 2010 */
select num from employees where year(start_date) = 2010

/*muestra los trabajadores que son managers, de manera unica */
select DISTINCT manager from employees;

union junta las dos tablas.
intersect solo muestra los valores que coinciden en ambas tablas.

/* solo los valores que hay en ambas*/
select num from employees where year(start_date) = 2010
intersect
select distinct manager from employees;

/* otra manera de hacer la querie de intersect */
select num from employees
where year(start_date)= 2010
and num in (
  select distinct manager
from employees
);

--Enseña sólo lo que coincide con el rango de parametros que tu le has 
--especificado después del IN--
select * from departments where num in (10,15,25);

--except sirve para hacer una consulta donde se arrojen los resultados
--de una consulta que NO estén en los resultados de la segunda consulta
---MariaDB;
select num from employees where YEAR(start_date) = 2010
EXCEPT
select distinct manager from employees;

--AVG: saca la media 
select avg (salary) from employees where dept_num = 10;

--MIN: valor minimo
--MAX: valor maximo
--SUM: suma de valores
--COUNT: numero de valores

--ejemplo de Group By en MARIADB:
select D.name, avg(E.salary)
from employees E, departments D
where E.dept_num = D.num
group by D.name;
select D.name, avg(E.salary), max(E.salary) kakota, min(E.salary) boñiga
from employees E, departments D
where E.dept_num = D.num
group by D.name;


select E.dept_num, avg(E.salary) as "average salary"
from employees E
group by E.dept_num;

--OVER crea una partición para aplicar una operación stipulada sobre un parametro
--en este caso aplica la media de salary sobre las particiones creadas con dept_num
select dept_num,
  name, surname,
  salary,
  avg(salary) OVER (PARTITION BY dept_num)
from employees;

--ejemplo de ranking
select dept_num, num, start_date, rank() over (order by salary desc) 
as ranking
from employees;


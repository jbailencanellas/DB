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
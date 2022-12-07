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

    create table CUSTOMER ( 
      EMAIL varchar(50) NOT NULL,
      ADRESS varchar(50),
      DATE_OF_BIRTH DATE,
      FNAME varchar(50),
      MNAME varchar(50),
      LNAME varchar(50),
      CONSTRAINT PK_CUSTOMER primary key (EMAIL)
    );

    create table ORDER (
      ORDER_NUMBER int NOT NULL,
      DATE_TIME DATETIME,
      CUSTOMER_E-MAIL varchar(50),
      CONSTRAINT PK_ORDER primary key (ORDER_NUMBER),
      CONSTRAINT FK_ORDER foreign key (CUSTOMER_E-MAIL)
    );

    create table ORDER_ITEM (
      ITEM_LINE_NUMBER int not null,
      ORDER_NUMBER int not null,
      QUANTITY int,
      PRICE numeric (7,2),
      PRODUCT_CODE int,
      CONSTRAINT PK_ORDER_ITEM primary key (ITEM_LINE_NUMBER, ORDER_NUMBER),
      CONSTRAINT FK_ORDER_ITEM foreign key (PRODUCT_CODE) REFERENCES PRODUCT (CODE)
    );

    create table PRODUCT ( 
      CODE INT NOT NULL,
      NAME VARCHAR(50),
      PRICE NUMERIC(7,2),
      CONSTRAINT PK_PRODUCT primary key (CODE)
    );
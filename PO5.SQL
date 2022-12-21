--MADE IN POSTGRES--

create database P05;

create table company (
ID varchar(50) primary key,
name varchar(50),
year_of_creation date default '1990-01-01',
headquarts_adress varchar(50)
);

create table boats (
ID serial primary key,
name varchar(50),
boat_type varchar(50),
company_ID varchar(50) references company (ID)
);

create table clients (
    ID serial primary key,
    name varchar(50),
    SSNN int,
    age int,
    contact varchar(50) not null,
    nationality varchar(50)
);

create table ports (
    ID varchar(10) primary key,
    name varchar(50),
    adress varchar(50)
);

create table trips (
    ID serial primary key,
    amount_of_passengers int,
    start_date date,
    end_date date,
    boat_id int references boats (ID)
);
    
create table company-trips (

)
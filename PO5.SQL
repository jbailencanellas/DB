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
    boat_ID int,
    origin_port_ID varchar(10), 
    destiny_port_ID varchar(10),
    constraint fk_1_trips foreign key (boat_ID) references boats (ID),
    constraint fk_2_trips foreign key (origin_port_ID) references ports (ID),
    constraint fk_3_trips foreign key (destiny_port_ID) references ports (ID)
);
    
create table company_trips (
trip_ID int,
company_ID varchar(50),
primary key ( trip_ID,company_ID),
constraint fk_1_company_trips foreign key (trip_ID) references trips (ID),
constraint fk_2_company_trips foreign key (company_ID) references company (ID)
);

create table clients_trips (
    clients_ID int,
    trip_ID int,
    primary key (clients_ID,trip_ID),
    constraint fk_1_clients_trips foreign key (clients_ID) references clients (ID),
    constraint fk_2_clients_trips foreign key (trip_ID) references trips (ID)
);


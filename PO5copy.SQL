--MADE IN POSTGRES--
drop if exist 'po5prueba3';

create database 'po5prueba3';

create table company (
ID varchar(50) primary key default 'Unknown Company',
name varchar(50),
year_of_creation date default '1990-01-01',
headquarters_adress varchar(50)
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
    ID varchar(10) unique primary key,
    name varchar(50),
    adress varchar(50)
);

create table trips (
    ID serial primary key,
    amount_of_passengers int,
    start_date date,
    end_date date check (end_date > start_date),
    boat_ID int,
    origin_port_ID varchar(10), 
    destiny_port_ID varchar(10),
    constraint fk_1_trips foreign key (boat_ID) references boats (ID),
    constraint fk_2_trips foreign key (origin_port_ID) references ports  (ID) on delete cascade,
    constraint fk_3_trips foreign key (destiny_port_ID) references ports (ID) on delete cascade
);
    
create table company_trips (
trip_ID int,
company_ID varchar(50),
primary key ( trip_ID,company_ID),
constraint fk_1_company_trips foreign key (trip_ID) references trips (ID),
constraint fk_2_company_trips foreign key (company_ID) references company (ID) on delete set default
);

create table clients_trips (
    clients_ID int,
    trip_ID int,
    primary key (clients_ID,trip_ID),
    constraint fk_1_clients_trips foreign key (clients_ID) references clients (ID) on delete set null,
    constraint fk_2_clients_trips foreign key (trip_ID) references trips (ID)
);

---------------------------------------

insert into Company (ID, name, year_of_creation, headquarters_adress) values 
('A01', 'Balearic Paradise','1994-03-14','Calle José Ortega y Gasset, 40'),
('B02', 'Boat and go','2003-02-10','Calle La Loma, 02.'),
('C03', 'Barcos Ramón','1980-02-14','calle Vitoshko Lale 16'),
('D04', 'Vayana trips','1940-09-20', 'Calle Serrano Galvache, 56');

insert into Company (ID, name, headquarters_adress) values 
('E05', 'Bahiá Bikini','Calle Mallorca 236');

insert into boats (ID, name, boat_type, company_ID) values
('001', 'Don Camarón', 'Velero','A01'),
('002', 'El Emperador del Mar', 'Crucero','C03'),
('003', 'Subnautica','Barco','E05'),
('004','Below Zero','Lancha','A01'),
('005','El Holandés Errante','Barco Mercante','B02');

insert into boats (ID, name, boat_type) values
('006','Barco Tio Jinés','Barca de pesca');

insert into clients (name, SSNN, age, contact, nationality) values
('Sergi','555501234','24','sergiaa@gmail.com','estadounidense'),
('Pedro','396120465','41','pedroponi@gmail.com','suizo'),
('Paola','14802650','21','paolasuperestar@outlook.es','holandesa'),
('Rebeca','38110092','32','rebecarabbit@hotmail.com','canadiense'),
('Ramón','21545120','38','ramonelruedas@gmail.com','mexicano');

insert into ports (ID, name, adress) values
('PMI', 'Palma de Mallorca','07015 Palma'),
('BCN','Barcelona','Moll de Barcelona 08039 '),
('VLC','Valencia','AV, Mlle. del Turia, S/N, 46024'),
('IBZ','Ibiza','Avinguda de Santa Eulària des Riu, 17, 07800'),
('MLG','Málaga','Muelle de Cánovas s/n 29001 Málaga');

insert into trips (amount_of_passengers, start_date, end_date, boat_ID, origin_port_ID, destiny_port_ID) values
('3','2022/01/10','2022/01/13','001','PMI','IBZ'),
('2','2022/03/01','2022/03/08','002','IBZ','MLG'),
('1','2021/10/27','2021/11/04','003','BCN','VLC'),
('4','2023/01/03','2023/01/07','005','VLC','PMI'),
('4','2019/08/17','2019/08/18','003','PMI','PMI'),
('7','2020/01/17','2020/02/17','006','IBZ','PMI');

insert into company_trips (trip_ID, company_ID) values
('3','A01'),
('4','A01'),
('5','B02'),
('6','E05'),
('7','D04');
insert into clients_trips (clients_ID, trip_ID) values
('1','5'),
('2','7'),
('3','3'),
('4','6'),
('5','4');


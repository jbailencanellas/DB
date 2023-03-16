DROP DATABASE IF EXIST `classroom`;

create database `classroom`;

use classroom;

create table `teachers` (
    ID varchar(50) primary key,
    name varchar(50),
    email varchar(50)
);

create table `students` (
    ID int auto_increment primary key,
    name varchar(50) not null,
    contact varchar(50)
);

create table `subjects` (
    ID varchar(15) primary key,
    name varchar(20),
    start_date date
);

insert into `teachers` ( `ID`, `name`, `email`) values
(001,'Pedro','pedro@gmail.com'),
(002,'Raúl','raulsanchez@gmail.com'),
(003,'María','mariaperez@gmail.com')
;

insert into `students` (`name`,`contact`) values
('Juan','juanelgalan@gmail.com'),
('Gabriel','gabrielelmarques@gmail.com'),
('Lucia','lucialaalegria@gmail.com')
;

insert into `subjects` (`ID`, `name`, `start_date`) values
('PRG','Progamació','2022/09/27'),
('SMI','Sistemes informátics','2022/09/27'),
('DB','Databases','2022/09/27')
;


create table courses (
  ID int auto_increment primary key,
  teacher_ID varchar(50),
  subject_ID varchar(50),
  constraint fk_courses_1 foreign key (teacher_ID) references teachers (ID),
  constraint fk_courses_2 foreign key (subject_ID) references subjects (ID)

);
insert into courses (teacher_ID, subject_ID) values 
('1','DB'),
('3','PRG');



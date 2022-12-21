create table  Teams (
    ID int auto_increment primary key,
    nickname varchar(50)
);

create table Tournaments (
    ID int auto_increment primary key,
    `start-date` date,
    `end-date` date,
    place varchar(20)
);

create table Matches (
   ID int auto_increment primary key,
   Team_local int,
   Team_visitor int, 
   Tournament_ID int,
   Local_goals int,
   Visitor_goals int,
   constraint fk_1_Teams foreign key (Team_local) references Teams (ID),
   constraint fk_2_Teams foreign key (Team_visitor) references Teams (ID),
   constraint fk_Tournaments foreign key (Tournament_ID) references Tournaments (ID) 
);

insert into Teams (nickname) values
('Rayo Vallecano'),
('FC Barcelona'),
('Real Madrid'),
('Valencia'),
('Malaga'),
('Betis');

insert into Tournaments (`start-date`, `end-date`,place) values 
("2022-01-12","2022-01-17","Casa de Pedro");
("2022-02-03","2022,02-13", "Casa de Jose"),
("2022-04-12","2022-05-01", "Bar Papas Pablos"),
("2022-06-12","2022-08-18", "Sede Futbol Mallorca"),
("2022-09-10","2022-11-04", "Casa de Javi");

insert into Matches (Team_local,Team_visitor,Tournament_ID,Local_goals,Visitor_goals) values
(1,2,1,5,2),
(3,4,1,2,8),
(5,6,1,3,2)
;
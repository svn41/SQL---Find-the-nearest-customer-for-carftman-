CREATE DATABASE store;

USE store;

drop table if exists teams;

create table teams(
TeamID int primary key not null,
AvailableFrom date,
AvailableTill date,
SkillLevel int);

insert into teams(TeamID,AvailableFrom,AvailableTill,SkillLevel)
values
(1,'2022-10-01','2022-10-29',3),
(2,'2022-10-25','2022-12-31',2),
(3,'2022-10-20','2022-12-29',1),
(4,'2022-10-01','2022-11-02',2),
(5,'2022-12-01','2022-12-31',3);


drop table if exists base;

create table base(
TeamID  INT not null,
latitude FLOAT,
longitude FLOAT,
foreign key (TeamID) references teams(TeamID)
);

insert into base(TeamID,latitude,longitude)
values 
(1,49.908972,10.189604),
(2,49.908972,10.189604),
(3,52.387530, 10.867917),
(4,50.723989,7.002261),
(5,50.723989,7.002261);


drop table if exists customers;

create table customers(
CustomerID int primary key not null,
latitude float,
longitude float,
NoPanels int,
Startdate date);

insert into customers(CustomerID,latitude,longitude,NoPanels,Startdate)
values
(1,52.727484,13.672054,22,'2022-10-01'),
(2,50.734202,6.684749,100,'2022-11-26'),
(3,52.265979,13.023860,15,'2022-11-20'),
(4,52.619445,10.143895,20,'2022-10-15'),
(5,51.209791,12.297156,18,'2022-11-23'),
(6,49.874297,8.545643,15,'2022-12-09'),
(7,50.2476025,13.235739,6,'2022-10-05'),
(8,53.082853,11.104894,70,'2022-11-18'),
(9,49.737278,9.200438,50,'2022-10-24'),
(10,52.292667,7.982300,12,'2022-10-21'),
(11,51.090618,11.028871,14,'2022-11-01'),
(12,54.131825,12.354968,22,'2022-11-15'),
(13,51.195072,14.383039,27,'2022-12-13'),
(14,51.541828,9.890459,8,'2022-10-28'),
(15,53.153025,13.328851,25,'2022-11-26');


drop view if exists teamBase;

create view teamBase as
select t.TeamID, t.AvailableFrom, t.AvailableTill, T.SkillLevel, b.latitude, b.longitude
from teams as t
left join base as b 
on (t.TeamID = b.TeamID);

drop view if exists tempCust;

create view tempCust as
select CustomerID,latitude,longitude, Startdate, case when NoPanels <= 21 then 3 when NoPanels = 22 then 2 when NoPanels > 22 then 1 end as SkillCLass
from customers;


with rankTable as(
    select tb.teamid, tc.CustomerID,
    rank() over (partition by tb.teamid order by sqrt(SQUARE(tb.latitude - tc.latitude)+SQUARE(tb.longitude - tc.longitude)) asc) as rankDistance
    from teamBase tb, tempCust tc
    where tb.AvailableFrom <=tc.Startdate and tc.Startdate <= tb.AvailableTill and tb.SkillLevel = tc.SkillCLass
)
select teamid as Team, customerid as Customer
from rankTable 
where rankDistance = 1;





--select tb.TeamID As Team, (select top 1 tc.CustomerID
--						from tempCust tc
--					where tb.AvailableFrom <=tc.Startdate and tc.Startdate <= tb.AvailableTill and tb.SkillLevel = tc.SkillCLass
--					order by sqrt(SQUARE(tb.latitude - tc.latitude)+SQUARE(tb.longitude - tc.longitude)) asc ) as Customer
--from teamBase tb;

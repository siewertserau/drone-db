create database dronetracking;
use dronetracking;


create table ADSBlog (eventid BIGINT unsigned not null AUTO_INCREMENT, ICAO bit(24) not null, type char(3), latitude double, longitude double, altitude double, heading double, horizontal_velocity double, verticle_velocity double, callsign char(6), time_since_last_contact int(6) unsigned, PRIMARY KEY (eventid));

create table HobbyRegistration (certnumber char(10) not null, issue_date DATE, expiration_date DATE, owner BIGINT references CertifiedOwner (ownerid), PRIMARY KEY (certnumber));

create table HobbyDrone (serialnumber varchar(30) not null, make varchar(30), model varchar(30), certnumber char(10) references HobbyRegistration (certnumber), PRIMARY KEY (serialnumber)); 

create table CertifiedOwner (ownerid BIGINT unsigned not null AUTO_INCREMENT, firsname varchar(30), lastname varchar(30), PRIMARY KEY (ownerid));

create table OwnerAddress (locationid BIGINT unsigned not null AUTO_INCREMENT, owner BIGINT not null references CertifiedOwner (ownerid), street varchar(30), city varchar(30), state char(2), zipcode int(5), PRIMARY KEY (locationid));

show tables;

describe ADSBlog;
describe HobbyRegistration;
describe HobbyDrone;
describe CertifiedOwner;
describe OwnerAddress;


/*
Owner information:
null for autoincrement
firstname
lastname
*/
insert into CertifiedOwner VALUES(null, 'Sam', 'Siewert');
insert into CertifiedOwner VALUES(null, 'Rumple', 'Stiltskin');
insert into CertifiedOwner VALUES(null, 'Johnny', 'Flyboy');

select * from CertifiedOwner;


/*
Owner location:
ownerid
street address
city or town
state
zipcode
*/
insert into OwnerAddress VALUES(null, 3, '123 somestreet', 'somecityusa', 'AZ', '86301');
insert into OwnerAddress VALUES(null, 1, '456 someotherstreet', 'anothercityusa', 'AZ', '86302');
insert into OwnerAddress VALUES(null, 2, '789 anystreet', 'somecityusa', 'AZ', '86303');

select * from OwnerAddress;


/*
Registration records:
certificate number is 10 characters long
issue date in YYYY-MM-DD format
expiration date in YYYY-MM-DD format
ownerid
*/
insert into HobbyRegistration VALUES('FA39XMPHAA', '2017-11-04', '2020-11-04', 1);
insert into HobbyRegistration VALUES('FA3A4EEL74', '2017-11-06', '2020-11-06', 1);
insert into HobbyRegistration VALUES('ABCD123456', '2017-01-01', '2020-01-01', 2);
insert into HobbyRegistration VALUES('FEEDME1234', '2017-12-25', '2020-12-25', 3);

select * from HobbyRegistration;


/*
serialnumber
make
model
hobby registration certificate number from HobbyRegistration table
*/
insert into HobbyDrone VALUES('serial123abc', 'DJI', 'Mavic', 'FA39XMPHAA');
insert into HobbyDrone VALUES('serial456def', 'DJI', 'Inspire', 'FA3A4EEL74');
insert into HobbyDrone VALUES('serial123xyz', 'DJI', 'Spark', 'ABCD123456');
insert into HobbyDrone VALUES('serial456zzz', 'DJI', 'Phantom', 'FEEDME1234');

select * from HobbyDrone;


/*
Tracking update:
null for autoincrement
Hex literal for the 24-bit ICAO
Type is ADB
latitude (degrees)
longitude (degrees)
altitude (feet)
heading (degrees), zero is North, 90.0 East, 180.0 is South, 270.0 West
velocity parallel to ground (feet/second)
velocity down (feet/second)
callsign
seconds since last update
*/
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5196.9, 0.0, 22.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5191.9, 0.0, 18.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5186.9, 0.0, 16.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5181.9, 0.0, 12.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5176.9, 0.0, 10.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5171.9, 0.0, 8.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5166.9, 0.0, 7.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5161.9, 0.0, 6.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5156.9, 0.0, 5.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5151.9, 0.0, 2.0, -1.0, 'FA39XMPHAA', 1);
insert into ADSBlog VALUES(null, X'012ABC', 'ADB', 34.620919, 112.452880, 5146.9, 0.0, 0.0, -1.0, 'FA39XMPHAA', 1);

select * from ADSBlog;

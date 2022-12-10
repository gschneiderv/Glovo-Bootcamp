--Create of the schema:
create schema vehicles_KC authorization gaby;

--First I create the references tables for Vehicule table:
--1) Create color table and its PK:

create table vehicles_kc.color(
	id_color varchar(10) not null, --PK
	name varchar(20) not null 
);

alter table vehicles_kc.color
add constraint color_PK primary key(id_color);


--2) create car_Insurance table ande its PK:

create table vehicles_kc.car_insurance(
	id_insurance varchar(30) not null, --PK,FK
	name varchar(50) not null, 
	description varchar(100) null
);


alter table vehicles_kc.car_insurance
add constraint car_insurance_PK primary key(id_insurance);

--)3)create currency table and its PK:

create table vehicles_kc.currency(
	id_currency varchar(10)not null, --PK
	name varchar(30) not null,
	description varchar(200) null
);

alter table vehicles_kc.currency
add constraint currency_PK primary key(id_currency);


--4) Create business group table and its PK:

create table vehicles_kc.business_group(
	id_group varchar(50) not null, --PK
	name varchar(50) not null
);

alter table vehicles_kc.business_group
add constraint business_group_PK primary key(id_group);

--5)Create trademark table and its PK and FK:

create table vehicles_kc.trademark(
	id_trademark varchar (20) not null, --PK, 
	name varchar(50) not null, 
	id_group varchar(50) not null --FK-->business_group
	);

alter table vehicles_kc.trademark
add constraint trademark_PK primary key(id_trademark);

alter table vehicles_kc.trademark
add constraint trademark_business_group_FK foreign key(id_group)
references vehicles_kc.business_group(id_group);


--6) Create car_model table and its PK and FK:

create table vehicles_kc.car_model(
	id_model varchar (20) not null, --PK
	name varchar(20) not null, 
	id_trademark varchar(20) not null, --FK
	year_model varchar(10) null
);

alter table vehicles_kc.car_model
add constraint car_model_PK primary key(id_model);

alter table vehicles_kc.car_model
add constraint car_model_trademark_FK foreign key (id_trademark)
references vehicles_kc.trademark(id_trademark);



--7) create vehicles table and its PK and FK:

create table vehicles_kc.vehicle(
	id_vehicle varchar(50) not null, --PK
	id_model varchar (20) not null, --FK1
	registration_plate varchar (20) not null,
	id_color varchar(10) not null, --FK2
	id_insurance varchar(30) not null,--FK3
	num_insurance varchar(30) not null,
	km_tot varchar(512) not null, 
	dt_purchase date not null
);


alter table vehicles_kc.vehicle
add constraint vehicle_PK primary key(id_vehicle);

alter table vehicles_kc.vehicle
add constraint vehicle_model_FK1 foreign key (id_model)
references vehicles_kc.car_model(id_model);

alter table vehicles_kc.vehicle
add constraint vehicle_color_FK2 foreign key (id_color)
references vehicles_kc.color(id_color);

alter table vehicles_kc.vehicle
add constraint vehicle_insurance_FK3 foreign key (id_insurance)
references vehicles_kc.car_insurance(id_insurance);

--8)create revision table and itsPK and FK:

create table vehicles_kc.revision(
	id_revision varchar(20) not null, --PK
	km_revision varchar(512) not null,
	dt_revision date not null,
	cost_revision varchar(512) not null,
	id_currency varchar(10) not null, --FK	
	id_vehicle varchar(50) not null,--FK
	num_revision integer null
);


alter table vehicles_kc.revision 
add constraint revision_PK primary key(id_revision);

alter table vehicles_kc.revision 
add constraint revision_vehicle_FK foreign key(id_vehicle)
references vehicles_kc.vehicle(id_vehicle);

alter table vehicles_kc.revision 
add constraint currency_vehicle_FK foreign key(id_currency)
references vehicles_kc.currency(id_currency);
-----------------------------------------------------------------
-----------------------------------------------------------------

--Load of data 

--1) Table color:

insert into vehicles_kc.color (id_color, "name")values('01', 'White');
insert into vehicles_kc.color (id_color, "name")values('02', 'Grey');
insert into vehicles_kc.color (id_color, "name")values('03', 'Yellow');
insert into vehicles_kc.color (id_color, "name")values('04', 'Green');
insert into vehicles_kc.color (id_color, "name")values('05', 'Blue');
insert into vehicles_kc.color (id_color, "name")values('06', 'Black');
insert into vehicles_kc.color (id_color, "name")values('07', 'Brown');
insert into vehicles_kc.color (id_color, "name")values('08', 'Beige');
insert into vehicles_kc.color (id_color, "name")values('09', 'Red');
insert into vehicles_kc.color (id_color, "name")values('10', 'Orange');
insert into vehicles_kc.color (id_color, "name")values('11', 'Purple');


--command to check the state:  select * from vehicles_kc.color;


--2) Table of Car_Insurance

insert into vehicles_kc.car_insurance (id_insurance, "name", description) values('A', 'Mapfre', '');
insert into vehicles_kc.car_insurance (id_insurance, "name", description) values('B', 'MMT', '');
insert into vehicles_kc.car_insurance (id_insurance, "name", description) values('C', 'AXA', '');
insert into vehicles_kc.car_insurance (id_insurance, "name", description) values('D', 'BBVA', '');

--to check: select * from vehicles_kc.car_insurance ci ;

--3) Table of currency:


insert into vehicles_kc.currency(id_currency, "name",description)values('01', 'Dolar', '');
insert into vehicles_kc.currency(id_currency, "name",description)values('02', 'Euro', '');
insert into vehicles_kc.currency(id_currency, "name",description)values('03', 'Pesos Argentinos', '');
insert into vehicles_kc.currency(id_currency, "name",description)values('04', 'Pound', '');

--to check: select * from vehicles_kc.currency c  ;




--4)Table of  business_group

insert into vehicles_kc.business_group (id_group, "name") values('G1', 'VAN');--VW, SEAT, Audi
insert into vehicles_kc.business_group (id_group, "name") values('G2', 'TAM');--toyota , alfa , mercedes--
insert into vehicles_kc.business_group (id_group, "name") values('G3', 'FKR');--Ford, KIA, Renault

--to check:  select * from vehicles_kc.business_group bg ;


--5)Table of Trademark:


insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M1', 'VW','G1');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M2', 'SEAT','G1');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M3', 'Audi','G1');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M4', 'Toyota','G2');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M5', 'Alfa','G2');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M6', 'Mercedes','G2');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M7', 'Ford','G3');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M8', 'KIA','G3');
insert into vehicles_kc.trademark (id_trademark, "name", id_group) values('M9', 'Renault','G3');


--to check: select * from vehicles_kc.trademark t ;

--6) Table of model


insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo1', 'Fiesta','M7', 2016);
insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo2', 'Focus','M7', 2016);
insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo3', 'Corolla','M4', 2019);
insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo4', 'Soul','M8', 2020);
insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo5', 'Clio','M9', 2018);
insert into vehicles_kc.car_model (id_model, "name", id_trademark, year_model) values('Mo6', 'Gol','M1', 2019);


--to check:   select * from vehicles_kc.car_model cm ;

--7) table of vehicle: vehicles_kc.vehicle

insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V01', 'Mo1','MHJ456', '02','A','354A', 49000, '2014-12-03');
insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V02', 'Mo2','MIL865', '08','B','122B', 38500, '2015-05-22');
insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V03', 'Mo5','NJJ356', '01','A','355A', 35567, '2016-07-05');
insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V04', 'Mo3','GFL785', '04','B','123B', 36704, '2017-05-12');
insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V05', 'Mo6','MGH456', '03','C','087C', 26780, '2017-12-21');
insert into vehicles_kc.vehicle 
(id_vehicle, id_model , registration_plate , id_color, id_insurance, num_insurance, km_tot, dt_purchase) 
values('V06', 'Mo4','MIL865', '02','B','122B', 23094, '2018-01-04');


--8)Table of revision


insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('01', '10000', '2016-02-10',100,'02','V01',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('02', '20000', '2018-06-10',250,'02','V01',2);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('03', '30000', '2020-10-10',500,'02','V01',3);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('04', '40000', '2022-05-04',600,'02','V01',4);
--
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('05', '10000', '2016-06-13',100,'01','V02',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('06', '20000', '2019-03-15',200,'01','V02',2);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('07', '30000', '2021-01-22',400,'01','V02',3);
--
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('08', '10000', '2018-06-12',2500,'03','V03',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('09', '20000', '2020-03-15',6000,'03','V03',2);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('10', '30000', '2021-12-10',10000,'03','V03',3);
--
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('11', '10000', '2019-04-19',150,'01','V04',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('12', '20000', '2019-03-15',300,'01','V04',2);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('13', '30000', '2021-01-22',500,'01','V04',3);
--
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('14', '10000', '2020-04-14',150,'01','V05',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('15', '20000', '2022-03-15',300,'01','V05',2);
--
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('16', '10000', '2020-06-13',100,'01','V06',1);
insert into vehicles_kc.revision (id_revision,km_revision ,dt_revision,cost_revision,id_currency, id_vehicle, num_revision)
values('17', '20000', '2022-10-15',150,'01','V06',2);

select * from vehicles_kc.revision r ;


--to check:  select * from vehicles_kc.vehicle v ;





create database perros_poo;
use perros_poo;
create table perro(
	nombre nvarchar(50) not null,
    raza nvarchar(50) not null,
    edad int not null,
    genero nvarchar(10) not null
);
delete from perro;
insert into perro values('Pancho','Pug',1,'Macho');
insert into perro values('Panchito','Pug',2,'Hembra');
insert into perro values('Poncho','Pug',3,'Macho');
insert into perro values('Panchito','Pug',4,'Hembra');
insert into perro values('Firulais','Pug',5,'Macho');
select * from perro;
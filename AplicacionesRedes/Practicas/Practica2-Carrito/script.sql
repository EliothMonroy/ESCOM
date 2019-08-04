create database redes2;
use redes2;
drop table producto;
create table producto(
	id int primary key auto_increment,
	nombre varchar(30),
	precio float,
	existencia int,
	imagen varchar(20)
);
select * from producto;
insert into producto values(default, 'Gansito', 8, 3,'images/gansito.jpg');
insert into producto values(default, 'Payaso', 10, 4,'images/payaso.jpg');
insert into producto values(default, 'Sabritas', 11, 10,'images/sabritas.png');

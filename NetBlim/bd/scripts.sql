drop database netblim;
use NetBlim;
select * from usuario;

#A darle con los procedures:

desc cliente;
delimiter $
#Procedure para dar de alta un usuario:
create procedure Alta_Usuario(in email varchar(50), in contra varchar(45))
begin
	declare existe int;
    set existe=(select count(*) from usuario where usuario.email=email);
    if existe=0 then
		insert into usuario values(default,email,1,current_date(),contra);
        select usuario.idUsuario as msj from usuario order by idUsuario desc limit 1;
	else
		select 0 as msj;
	end if;
end $

#procedure para dar de alta un trabajador
create procedure Alta_Trabajador(in idUsuario int,in nombre varchar(80), in tipo int)
begin
	insert into Trabajador values(idUsuario,nombre,tipo);
    select 1 as msj;
end $

#procedure para hacer inserciones al plan, hay que controlar los costos y numero de dispositivos cuando programemos
create procedure Alta_Plan(in max_dispo int, in costo float, in metodo_pago varchar(45))
begin 
		insert into plan values(default, max_dispo,costo,metodo_pago); 
        select 1 as msj;
end $


#procedure para dar de alta un cliente
create procedure Alta_Cliente(in idUsuario int, in saldo float, in Plan_idPlan int)
begin
	insert into cliente values (idUsuario,saldo,0,Plan_idPlan);
    select 1 as msj;
end $

#procedure para iniciar sesion, hay que checar que el max_dispositivos
create procedure Iniciar_Sesion(in email varchar(50), in contra varchar (45))
begin
	declare existe int;
    declare id int;
    declare max_plan int;
    declare activos int;
    set existe=(select count(*) from usuario where usuario.email=email and usuario.contra=contra and usuario.estado=1);
    #El usuario existe, procedemos a ver en cuantos dispositivos se encuentra activo
    if existe=1 then
        select usuario.idUsuario into id from usuario where usuario.email=email and usuario.contra=contra;
        select plan.max_dispo into max_plan from plan, cliente where cliente.Usuario_idUsuario=id and cliente.plan_idPlan=plan.idPlan;
        select cliente.activos into activos from cliente where cliente.Usuario_idUsuario=id;
        if activos=max_plan then
			#Se alcanzo el máximo de usuarios
			select -1 as msj;
		else
			#Aumentamos en 1 el número de dispositivos conectados y devolvemos el id del usuario
			update cliente set cliente.activos=cliente.activos+1 where cliente.Usuario_idUsuario=id;
            select id as msj;
		end if;
	else 
		#El usuario no existe
		select 0 as msj;
	end if;
end $



#procedure para insertar directores o actores
create procedure Alta_Dire_Actor(in nombre varchar(100), in tipo int)
begin
	insert into Dire_Actor values (default, nombre, tipo);
    select 1 as msj;
end $


#Procedure para saber si es el Primer Perfil en la cuenta de un cliente
#create procedure Es_PrimerPerfil(in Cliente_idCliente int)
#begin 
#declare existe int;
#    set existe=(select count(*) from Perfil where Cliente_Usuario_idUsuario=Cliente_idCliente);
#    if existe=0 then
#		select 1 as msj;
#	else
#		select 0 as msj;
#	end if;
#end $


#Procedure para saber si es el Primer Perfil en la cuenta de un cliente (buscando por email)
create procedure Es_PrimerPerfil(in email varchar(50))
begin 
declare existe int;
    set existe=(select count(*) from Perfil,cliente,usuario where idUsuario=Usuario_idUsuario and Usuario_idUsuario=Cliente_Usuario_idUsuario and Usuario.email=email);
    if existe=0 then
		select 1 as msj;
	else
		select 0 as msj;
	end if;
end $


#procedure para crear un perfil
create procedure Alta_Perfil(in Cliente_idCliente int, in url_imagen varchar(120), in nombre varchar(80), in ctr_parental tinyint)
begin
	insert into Perfil values (default,url_imagen,nombre,ctr_parental,Cliente_idCliente);
    select 1 as msj;
end $
#procedures alta_genero
  create procedure alta_genero(in nombre varchar(45))
  begin
   insert into genero values(default, nombre);
   select 1 as msj;
  end $
#procedure alta Clasificacion
create procedure Alta_Clasificacion(in ctr_parental int, in nombre varchar(45))
begin
     insert into clasificación values(default,ctr_parental,nombre);
      Select 1 as msj;
end$
   

#procedure para catalogo Peli_Serie
create procedure Alta_Peli_serie(in nombre varchar(60), in anio varchar(4), in url_imagen varchar(120), in Descripcion varchar(500), in Genero_idGenero int, in Clasificacion_idClasificacion int, in Trabajador_idTrabajador int)
begin
	#El usuario no subio imagen
    if url_imagen='' then
		insert into Peli_serie values (default, default, nombre, current_date(), 1, anio, 'La de default', Descripcion, Genero_idGenero, Clasificación_idClasificación, Trabajador_idTrabajador);
    else
		insert into Peli_serie values (default, default, nombre, current_date(), 1, anio, url_imagen, Descripcion, Genero_idGenero, Clasificación_idClasificación, Trabajador_idTrabajador);
	end if;
    select 1 as msj;
end $

create procedure existeUsuario(in email varchar(45))
begin 
	declare existe int;
    select count(*) into existe from usuario where usuario.email=email;
    if existe=1 then
		select 1 as msj;
	else
		select 0 as msj;
	end if;
end $

#Dar de baja una peli_serie=trabajador
create procedure Baja_PeliSerie(in idPS int)
begin
  update Peli_serie set estado=0 where idPeli_serie=idPS;
  select 1 as msj;
end $


#Modificar campo de una peli_serie, **checar genero_idGenero y clasificacion y trabajador
create procedure Modificar_PeliSerie(in idPS int, in valo float, in nom varchar(60), in fec_reg date, in edo boolean, in ano varchar(4), in url varchar(120), in descripcion varchar (500) )
begin
  update Peli_serie set valoracion=valo and nombre=nom and fecha_registro=fec_reg and   estado=edo and anio=ano and url_imagen=url and descripcion=descripcion where idPeli_serie=idPS;
  select 1 as msj;
end $

#Buscar peli_serie por nombre=cliente
create procedure Buscar_PeliSerie_nombreC( in nom varchar(60))
begin
select valoracion, Peli_serie.nombre, fecha_registro, estado, anio, url_imagen, descripcion  from Peli_serie where nombre like concat('%',nom,'%'); 
end $

#Buscar peli_serie por nombre=trabajador
create procedure Buscar_PeliSerie_nombreT( in nom varchar(60))
begin
select *  from Peli_serie where nombre like concat('%',nom,'%'); 
end $


#Buscar peli_serie por genero= trabajador
create procedure Buscar_PeliSerie_generoT( in nomGen varchar(60))
begin
select Peli_serie.* from Peli_serie, Genero where idGenero=Genero_idGenero ; 
end $


#Buscar peli_serie por genero= cliente
create procedure Buscar_PeliSerie_generoC( in nomGen varchar(60))
begin
select valoracion, Peli_serie.nombre, fecha_registro, estado, anio, url_imagen, descripcion from Peli_serie, Genero where idGenero=Genero_idGenero ; 
end $


#Buscar peli_serie por direactor = cliente
create procedure Buscar_PeliSerie_direactorC( in nomdireactor varchar(100))
begin
select valoracion, Peli_serie.nombre, fecha_registro, estado, anio, url_imagen, descripcion from Peli_serie, Dire_actor, Dire_actor_has_Peli_serie where idDire_actor=Dire_actor_idDire_actor and idPeli_serie=Peli-serie_idPeli-serie and Dire_actor.nombre like concat('%',nomdireactor,'%'); 
end $


#Buscar peli_serie por direactor = trabajador
create procedure Buscar_PeliSerie_direactorT( in nomdireactor varchar(100))
begin
select valoracion, Peli_serie.nombre, fecha_registro, estado, anio, url_imagen, descripcion from Peli_serie, Dire_actor, Dire_actor_has_Peli_serie where idDire_actor=Dire_actor_idDire_actor and idPeli_serie=Peli-serie_idPeli-serie and Dire_actor.nombre like concat('%',nomdireactor,'%');
end $


#Agregar idioma=trabajador
create procedure Alta_Idioma(in nom_idiom varchar(45))
begin
declare existe int;
set existe=(select count(*) from Idioma where idioma.nomre=nom_idiom);
if existe=0 then
insert into idioma values (default, nom_idiom);
select idioma.nombre as msj from idioma order by idIdioma desc limit 1;
else
	select 0 as msj;
end if;
end $


#Agregar subtitulo=trabajador
create procedure Alta_subtitulo(in nom_subt varchar(45))
begin
declare existe int;
set existe=(select count(*) from Subtitulo where subtitulo.nombre=nom_subt);
if existe=0 then
	insert into Subtitulo values (default,nom_subt);
select subtitulo.nombre as msj from subtitulo order by idSubtitulo desc limit 1;
else 
	select 0 as msj;
end if;
end $




#Agrega una PeliSerie de tipo pelicula
create procedure Alta_Peliserie_Pelicula (in idPeli_serie int, in dur int)
begin
insert into Pelicula values (idPeli_serie, dur);
select 1 as msj;
end $


#Agregar una PeliSerie de tipo serie
create procedure Alta_Peliserie_Serie(in idPeli_serie int)
begin
insert into Serie values(idPeli_Serie);
select 1 as msj;
end $


#Agregar una Temporada a serie Falta poner autoincrement a id de Temporada
create procedure Alta_Temporada_Serie(in numero int, in Serie_Peli_serie_idPeli_serie int)
begin 
insert into Temporada values (default, numero, Serie_Peli_serie_idPeli_serie);
end $

#Procedure que devuelve cual será el id siguiente de un perfil
create procedure proximoIdPerfil()
begin
	declare existe int;
    select count(*) into existe from perfil;
    if existe=0 then
		select 1 as msj;
	else
		select idPerfil+1 as msj from perfil order by idPerfil desc limit 1;
	end if;
end $

#Procedure que devuelve todos los perfiles que le pertenecen a un usuario
create procedure perfilesUsuario (in idUsuario int)
begin 
	select * from perfil where perfil.Cliente_Usuario_idUsuario=idUsuario;
end $

# Procedure que devuelve toda la información sobre un perfil en especifico
create procedure infoPerfil(in idPerfil int)
begin
	select perfil.url_imagen as imagen,perfil.nombre as nombre,perfil.ctr_parental as control from perfil where perfil.idPerfil=idPerfil;
end $

#Procedure que actualiza un perfil
create procedure Actualizar_Perfil(in url varchar(140), in id int, in nombre varchar(100), in control varchar(140))
begin
	if url='' then
		update perfil set perfil.nombre=nombre, perfil.ctr_parental=control where perfil.idPerfil=id;
        select url_imagen as msj from perfil where perfil.idPerfil=id;
	else
		update perfil set perfil.url_imagen=url, perfil.nombre=nombre, perfil.ctr_parental=control where perfil.idPerfil=id;
        select 1 as msj;
	end if;
end $
#Agregar un capítulo a una temporada
#create procedure Alta_Capitulo_Temporada(in dura int, in sinop varchar(500), id Temporada_idTemporada int )
#begin 
#	insert into capitulo values(default,dura, 

delimiter ;
drop procedure Actualizar_Perfil;
call proximoIdPerfil;

drop procedure Alta_PeliSerie;
desc Trabajador;
desc Cliente;
desc Plan;
desc Usuario;
desc dire_actor;
desc perfil;
desc peli_serie;

use netblim;
select * from perfil;
delete from usuario;
delete from cliente;
delete from perfil;
select * from cliente;
select * from perfil;
drop procedure Alta_Trabajador;
drop procedure Alta_Usuario;
drop procedure existeUsuario;
drop procedure Alta_Cliente;
drop procedure Iniciar_Sesion;
drop procedure Alta_Clasificacion;
drop procedure Alta_Peli_serie;

desc cliente;
#Alta Usuario----------------------------
call Alta_Usuario('ionsito@gmail.com','gatitos');
call Alta_Usuario('are@gmail.com','123');
call Alta_Usuario('giss@gmail.com','escom');
call Alta_Usuario('sam@gmail.com','ipn');
call Alta_Usuario('elioth@gmail.com','bases');
#Alta Trabajador-------------------
call Alta_Trabajador(2,'Arheli Cortes',1);
call Alta_Trabajador(3,'Giselle Flores',1);
call Alta_Trabajador(4,'Samuel Arteaga',1);
call Alta_Trabajador(5,'Elioth Monroy',0);
#--------------			
call existeUsuario('ionsito@gmail.com');
call Alta_Plan(4,98,'Tarjeta de Regalo');
call Alta_Cliente(3,4,1);
call Iniciar_Sesion('ionsito@gmail.com','gatitos');
call Alta_Dire_Actor('Brad Pitt', 1);
call Alta_Perfil(3,"sin direccion","Ianoncio",0);
#--------------------------------------------				    
call alta_genero('ciencia ficcion');
call alta_genero('Aventura');
call alta_genero('Romanticas');
call alta_genero('Comedia');
call alta_genero('Terror');
call alta_genero('Clásicas');
call alta_genero('Accion');
call Alta_Clasificacion(0,'AA (Destinada a niños pequeños');
call Alta_Clasificacion(0,'A (Todo espectador)');
call Alta_Clasificacion(0,'B (menores de 14 años)');
call Alta_Clasificacion(1,'B15 (menores de 18 años)');
call Alta_Clasificacion(1,'C (restringido)');
call Alta_Clasificacion(1,'D (mayores de 18 años)');
#Registro Catalogo Peli_serie
#------Genero Ciencia Ficcion
call Alta_Peli_serie('Al filo del manana',2014,'','Del Director el caso Borune con Tom Cruise y Emilly Blunt, aventura, ciencia ficcion',1,4,2);

insert into Peli_serie values (default, default, 'sdfghj', current_date(), 1, '200', 'La de default', 'Descripcion', 1, 4, 2);


call Alta_Peli_serie('Avatar',2010,'cf-avatar.jpg','Del Director James Cameron',1,4,2);
call Alta_Peli_serie('Guardianes de la Galaxia',2009,'cf-guardianes.PNG','De los creadores de Marvel, los nuevos superheroes ',1,3,2);
call Alta_Peli_serie('El incidente',2008,'cf-incidente.jpg','Del Guionista y Director del Sexto sentido y señales, Uno nunca sabe que puede pasar ',1,4,2);
call Alta_Peli_serie('Matrix',2006,'cf-matrix.jpg','Con Kenu Rivers y Laurence Fishburne, los mejores exitos de ciencia ficcion cuando la maquinas se apoderan del mundo',1,4,2);
call Alta_Peli_serie('Prometheus',2012,'cf-prometheus.jpg','Del director de Alien y Gladiador, la busqueda de nuestros origenes puede ser nuestro final',1,4,2);
call Alta_Peli_serie('El padresito',1978,'cl-elpadresito','Cantinflas con Angel Garasa y Jose Luis Moreno, comedia,clasicos',7,3,2);
call Alta_Peli_serie('Mi novia Polly',2008,'cm-noviapolly','Los directores de Locos por Mary y como una mezcla de friends, con Ben Stiller y Jeniffer Amison',5,4,2);

				    
select * from plan;
#Planes
delete from plan;
drop table plan;
call Alta_Plan(2,99.9,'Credito');
call Alta_Plan(2,99.9,'Debito');
call Alta_Plan(2,99.9,'Regalo');
call Alta_Plan(3,110,'Credito');
call Alta_Plan(3,110,'Debito');
call Alta_Plan(3,110,'Regalo');
call Alta_Plan(5,120,'Credito');
call Alta_Plan(5,120,'Debito');
call Alta_Plan(5,120,'Regalo');
delete from cliente;
delete from usuario;

select * from usuario;
select * from cliente;
select * from perfil;
desc perfil;
insert into perfil values(default, 'img/avatar.png', 'Perfil falso', 0, 5);

desc perfil;
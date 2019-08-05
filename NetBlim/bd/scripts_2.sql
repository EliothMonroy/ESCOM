drop database netblim;
create database NetBlim;
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
   create procedure Alta_Clasificacion(in ctr_parental binary, in nombre varchar(45))
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


#Agregar un capítulo a una temporada
#create procedure Alta_Capitulo_Temporada(in dura int, in sinop varchar(500), id Temporada_idTemporada int )
#begin 
#	insert into capitulo values(default,dura, 

delimiter ;


drop procedure Alta_PeliSerie;
desc Trabajador;
desc Cliente;
desc Plan;
desc Usuario;
desc dire_actor;
desc perfil;
desc peli_serie;


select * from usuario;
delete from usuario;
select * from cliente;
drop procedure Alta_Trabajador;
drop procedure Alta_Usuario;
drop procedure existeUsuario;
drop procedure Alta_Cliente;
drop procedure Iniciar_Sesion;
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
select * from trabajador;
#--------------
			
call existeUsuario('ionsito@gmail.com');
select * from usuario;
call Alta_Plan(4,98,'Tarjeta de Regalo');
call Alta_Cliente(1,4,1);
call Iniciar_Sesion('ionsito@gmail.com','gatitos');
call Alta_Dire_Actor('Brad Pitt', 1);
call Alta_Perfil(1,"sin direccion","Ianoncio",0);
#--------------------------------------------				    
call alta_genero('ciencia ficcion');
call alta_genero('Animada');
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
call Alta_Peli_serie('Avatar',2010,'cf-avatar.jpg','Del Director James Cameron',1,4,2);
call Alta_Peli_serie('Guardianes de la Galaxia',2009,'cf-guardianes.PNG','De los creadores de Marvel, los nuevos superheroes ',1,3,2);
call Alta_Peli_serie('El incidente',2008,'cf-incidente.jpg','Del Guionista y Director del Sexto sentido y señales, Uno nunca sabe que puede pasar ',1,4,2);
call Alta_Peli_serie('Matrix',2006,'cf-matrix.jpg','Con Kenu Rivers y Laurence Fishburne, los mejores exitos de ciencia ficcion cuando la maquinas se apoderan del mundo',1,4,2);
call Alta_Peli_serie('Prometheus',2012,'cf-prometheus.jpg','Del director de Alien y Gladiador, la busqueda de nuestros origenes puede ser nuestro final',1,4,2);
call Alta_Peli_serie('El padresito',1978,'cl-elpadresito','Cantinflas con Angel Garasa y Jose Luis Moreno, comedia,clasicos',7,3,2);
call Alta_Peli_serie('Mi novia Polly',2008,'cm-noviapolly','Los directores de Locos por Mary y como una mezcla de friends, con Ben Stiller y Jeniffer Amison',5,4,2);
#---Genero accion
call Alta_Peli_serie('The bourne supremacy',2015,'ac-bourne.jpg','Matt Damon como Jason Bourne, Ellos debieron dejarlo solo, Historia de un asesino que pierde la memoria, pero a causa de los enegimos, ellos tratan de matarlo',8,6,2);
call Alta_Peli_serie('Casino Royal',2013,'ac-casiono.jpg','Con Jame Hans y Alyson Morgan, historia de estafadores que intentan salvar la vida de uno de sus amigos',8,6,2);
call Alta_Peli_serie('El cazador reina de hielo',2014,'ac-cazador.jpg','Del productor de Malefica, con Chris Zack, historia de un reino conquistado por una bruja, donde la princesa intenta recuperar su reino despues de haber perdido a su familia',8,4,2);
call Alta_Peli_serie('La fría luz del día',2012,'ac-frialuz.jpg','Con Bruce Willis y Sigourney Historia de de un militar y exmilitar que intentan asesinar a un terrorista ',8,6,2);
call Alta_Peli_serie('Mision imposible, protocolo fantasma',2013,'ac-ghost.jpg','Historia de agentes especiales, que tienen un misión más dificil que las anteriores, ya que esta vez tiene dos enemigos el gobierno de E.U.A y el terrorista',8,6,2);
call Alta_Peli_serie('Ghost Protocol parte two',2015,'ac-ghostprotocol.jpg','La historia continua ante la mision de salvar el mundo ante una bomba nuclear',8,6,2);
call Alta_Peli_serie('Infierno blanco',2014,'ac-infierno.jpg','Un ex-militar vive en las lejanas montañas de California, pero es atacado por misterioros hombres que atacan a su esposa',8,6,2);
call Alta_Peli_serie('Point Break sin Limites',2015,'ac-point.jpg','Donde encuentras tu màximo limites, historia de asesinos que tienen la mision de matar a otros asesionos',8,6,2);
call Alta_Peli_serie('Police Story',2013,'ac-police.jpg','Historia de un policia que vive tranquilo en la ciudad, hsta atacan a una amiga inocente',8,6,2);
call Alta_Peli_serie('San Andres',2014,'ac-sanandres.jpg','San Andres sufre uno de los terribles fenomenos naturales, es donde la humanidad se vuelve solidaria para ayudar a otros',8,5,2);
#--- Genero clasicas
call Alta_Peli_serie('El padresito',1978,'cl-elpadresito.jpg','Cantinflas con Angel Garasa y Jose Luis Moreno, comedia,clasicos',7,4,2);
call Alta_Peli_serie('La vida de un perro',1974,'cl-adogslife.jpg','Una nueva historia protaginisada y dirigida por Charles Chaplin, la historia de un mendigo que encuentra un fiel compañero',7,2,2);
call Alta_Peli_serie('El dictador',1964,'cl-charliedictador.jpg','Charles Chaplin se encuentra entre sus nuevas aventuras, tomando el puesto de disctador por salvar al jefe militar',7,3,2);
call Alta_Peli_serie('Charlot, tiempos modernos',1976,'cl-charlot.jpg','Historia clàsica de la vida de Charlot',7,2,2);
call Alta_Peli_serie('Dracula de Bran Stoker',1963,'cl-dracula.jpg','Novela clasica de Broun Stoker, la vida de un exsoldado condenado a vivir como una bestia chupa sangre',7,6,2);
call Alta_Peli_serie('Young Frankestein',1968,'cl-franki.jpg','Pelicula basada en la novela de Mary Mei, la continuacion del monstruo creado por un cientifico',7,2,2);
call Alta_Peli_serie('Los tres Huastecos',1974,'cl-lostreshuastecos.jpg','Con Predo Infante, Sarita Montiel y Pedro Soto, historia de tres trillisos',7,4,2);
call Alta_Peli_serie('Nosotros los pobres',1972,'cl-nostroslospobres.jpg','Una nueva historia protaginisada y dirigida por Charles Chaplin, la historia de un mendigo que encuentra un fiel compañero',7,2,2);
call Alta_Peli_serie('Uno de los nuestros',1994,'cl-nuestros.jpg','Una pelicula de Martin Scosense, tres décadas de vida en la mafia, historia de un ladron que descubre el secreto de su mejor amigo',7,5,2);
call Alta_Peli_serie('Ladron de bicicletas',1991,'cl-ladron.jpg','Una bella historia de un pequeño que cambia la vida de un hombre que vende refraccionaria de bicicletas',7,3,2);
#---Genero comedia
call Alta_Peli_serie('Mi novia Polly',2008,'cm-minoviapolly.JPG','Los directores de Locos por Mary y como una mezcla de friends, con Ben Stiller y Jeniffer Amison',5,4,2);
call Alta_Peli_serie('Hazme reir',2013,'cm-hazmereir.jpg','La nueva pelicula del director virgen a los 40 y lo embarazoso',5,4,2);
call Alta_Peli_serie('Mi abuelo es un peligro',2011,'cm-miabuelo.jpg','Con los actores Robert DeNiro y Zack Efron',5,4,2);
call Alta_Peli_serie('Guerra de Novias',2014,'cm-novias.jpg','Ni las mejores amigas pueden compartir la fecha de su boda, con Ana Hathaway y kate Hudson',5,3,2);
call Alta_Peli_serie('Locura de Amor en las Vegas',2005,'cm-suertudos.jpg','Cameron Dias y James Anston se conoces en las vegas por una suerte de apuesta, pero despues de eso se vuelve un caos',5,4,2);
call Alta_Peli_serie('Todo un parto',2014,'cm-todounparto.jpg','Del director que pasò ayer, con Rober Downe JR y Zack Galifianakis',5,4,2);
call Alta_Peli_serie('Chiquito pero peligroso',2011,'cm-chiquito.jpg','Para huir de la ley este pequeño criminal tiene que actuar como un bebé',5,6,2);
#Genero Romance
call Alta_Peli_serie('Un paseo para recordar',2009,'rm-unpaseopararecordar.jpg','Mandy More y Shame West, una historia de amor de dos jovenes que se conocen en la escuela pero Polly descubre que Mark es un principe',4,4,2);
call Alta_Peli_serie('Lo mejor de mi',2009,'rm-bestofme.jpg	','Nuca olvidas tu primer amor, historia de amor y trama de dos jovenes',4,4,2);
call Alta_Peli_serie('El diario de Noa',2008,'rm-diarionoa.jpg','Una historia de dos jovenes que se conocen en las vacaciones de verano pero son separados por cuestiones de los padres de Rose',4,5,2);
call Alta_Peli_serie('Now is Good',2014,'rm-nowisgood.jpg','Con el amor nada es imposible',4,4,2);
call Alta_Peli_serie('Sonrie',2009,'rm-smashed.jpg','Historia de un hombre que cambia su vida por completo al conocer una loca y misteriosa mujer',4,6,2);
call Alta_Peli_serie('Un beso un deseo',2013,'rm-thevow.jpg','Historia de dos jovenes que cambian sus vidas al conocerse',4,5,2);
call Alta_Peli_serie('Un lugar donde refugiarse',2015,'rm-unlugardonderefugiarse.jpg','Una chica se enfrenta ante una polemica por la empresa de su padre, pero un misterioso hombre dona un fondo para salvar la vida de su padre	',4,5,2);
#Genero Aventura
call Alta_Peli_serie('Còdigo pirata',2011,'av-codigopirata.jpg','Unete a la aventura de Tred y los piratas',3,3,2);
call Alta_Peli_serie('Despuès de la Tierra',2015,'av-despuestierra.jpg','El peligro es real el miedo es una eleccion',3,5,2);
call Alta_Peli_serie('Indiana Jones',2007,'av-indiana.jpg','El profesor Jhones se encuentra ante una nueva aventura para vencer a los ladrones misteriosos en el Sahara	',3,5,2);
call Alta_Peli_serie('La isla del tesoro',2013,'av-islatesoro.png','Robert Lous Stevson, Drologo de Agustìn Sanchez Vidra',3,5,2);
call Alta_Peli_serie('Jack el Caza Gigantes',2014,'av-jack.jpg','Cuando el mundo no es lo que se creiste, la avetura de un chico que se encuentra con frijoles magicos lo llevan a un mundo completamente diferente',3,3,2);
call Alta_Peli_serie('Narnia',2009,'av-narnia.jpg','Un nuevo mundo a travez del armario, una aventura entre cuatro hermanos que se alojan en la casa de su ser querido màs cercano a causa de la guerra	',3,3,2);
call Alta_Peli_serie('Persi Jackson',2012,'av-persi.jpg','La aventura de un chico qe descubre ser un semidios, lucha contra la ira de los Dioses griegos',3,3,2);
call Alta_Peli_serie('Piratas del Caribe y el perla negra',2011,'av-piratas.jpg','Jack un pirata poco reconocido, se mete ante un problema al rescatar a la duquesa Romina, sus objetivos abarisos lo hacen conquistar el barco de los muertos',3,4,2);
call Alta_Peli_serie('La vida de pi',2014,'av-vidadepi.jpg','Un chico que es criado duramente por su padre, tiene un acciodente quedandose atrapado solo en un boto y con un leon, su reto es sobrevivir',3,3,2);
call Alta_Peli_serie('Your Higness ',2012,'av-your.jpg','La aventura de tres bandalos',3,4,2);
#Genero Terror
call Alta_Peli_serie('Con el diablo adentro ',2013,'tr-coneladentro.jpg','Esta es la pelicula que el vaticano no quiere que veas',6,6,2);
call Alta_Peli_serie('El exorcista ',1999,'tr-exorcista.jpg','Ana vive con su madre, acostumbrada a estar sola, conoce un juego que le hace abrir puertas al mal',6,6,2);
call Alta_Peli_serie('La persecuasion de Helena',1996,'tr-helena.jpg','Una misteriosa aldea, vive bajo las sombras,Helena una niña que nacio en esa aldea es sacrificada para llevar a cabo una mision bajo el mundo de los muertos',6,6,2);
call Alta_Peli_serie('Hermanas',2010,'tr-hermanas.jpg','Dos hermanas que viven en una situaciòn dificil con su familia, sufren de una terrible muerte, lo peor de todo fue separarlas',6,6,2);
call Alta_Peli_serie('La Hacienda',1978,'tr-lahacienda.jpg','Una haciendo convertida en un cementerio, misteriosamente es encontrado por un heredero, lo peor es cuando descubre los espiritus enterrados en ese lugar',6,6,2);
call Alta_Peli_serie('La noche del demonio',2013,'tr-nochedem.jpg','Un niño que tiene vijas astrales es atrapado por un espiritu maligno, la mision de los padres es recuperar a su hijo',6,6,2);
call Alta_Peli_serie('No tengas miedo a la oscuridad',2012,'tr-notengasmiedo.jpg','Unas extrañas criaturas viven por años en lo profundo de un sotano, si no las alimentas saldran y te mataran',6,6,2);
call Alta_Peli_serie('Stitch',2011,'tr-stitch.jpg','La extraña muerte de una mujer, quiere vengarse y hacer justicia torturando a los herederos del culpable',6,6,2);
call Alta_Peli_serie('Sueño sin retorno',2013,'tr-sueñosinretorno.jpg','No te quedes atrapados en tus sueños, una niña tiene una unica habilidad que le permite estar en la dimension de lo muertos, pero engañada no logra escapar de su destiono	',6,6,2);
call Alta_Peli_serie('Terror en Amitiville',2015,'tr-terrorenam.jpg','Un doctor maniaco hace extraños experimentos a los prisioneros màs temibles, mueren al ser expuestos, pero sus espiritus inundan en la mansion',6,6,2);
call Alta_Peli_serie('Terror en la niebla ',2012,'tr-terrorenlaniebla.jpg','Humanos atrapados en lo profundo de una cueva, mutan convirtiendose en canivales, atacan a unos expdicionistas en lo profundo del bosque',6,6,2);
# fIN Registro peliculas
call Alta_Peli_serie('Mom',2013,'mom-serie.jpg','Christy (Anna Faris) es una madre soltera que, después de lidiar contra el alcoholismo y la adicción a las drogas, decide reiniciar su vida trabajando como camarera.',5,6,2);
call Alta_Peli_serie('The bing bang Theori ',2010,'sr-bigbang.jpg','After Sheldon’s mother and Leonards father share an evening together.',5,5,2);
call Alta_Peli_serie('The bing bang Theori 2',2011,'sr-bigbang2.jpg','Leonard y Sheldon son estudiantes destacados en Caltech , amigos a su vez de Howard y Raj.',5,5,2);
call Alta_Peli_serie('Breaking bad',2008,'sr-breaking','Walter White (Bryan Cranston) es un frustrado profesor de química en un instituto, padre de un joven discapacitado ',5,6,2);
call Alta_Peli_serie('Dragon ball Z',1996,'sr-dragonball','Freezer es un ser que conquista planetas para venderlos después a través de una organizaciónNota 1 a la que pertenecen criaturas de distintas razas',2,2,2);
call Alta_Peli_serie('Flash',2014,'sr-flash.jpg','Cuando Barry Allen solo tenía 11 años, su madre fue asesinada en un extraño y terrorífico incidente y donde estuvo involucrado un hombre en un traje amarillo ',6,6,2);
call Alta_Peli_serie('Friends',1994,'sr-friends.jpg','rata sobre la vida de un grupo de amigos —Rachel Green, Monica Geller, Phoebe Buffay, Joey Tribbiani, Chandler Bing y Ross Geller— que residen en Manhattan, Nueva York.',5,6,2);
call Alta_Peli_serie('Dr House',2004,'sr-house.jpg',' El personaje central es el Dr. Gregory House (Hugh Laurie), un genio médico, irónico, satírico y poco convencional e inconformistay (Lisa Edelstein), y a su equipo',5,4,2);
call Alta_Peli_serie('La ley y el orden UVE',1986,'sr-ley.jpg','una serie de televisión estadounidense grabada en Nueva York donde es también principalmente producida. Con el estilo de la original Law & Order .',6,6,2);
call Alta_Peli_serie('How to get away with murder',2014,'sr-murder.jpg','La serie se centra en Annalise Keating, una brillante, carismática y seductora profesora de Derecho penal',6,6,2);
call Alta_Peli_serie('Two and Half men',2004,'sr-twoandhalf.jpg','Charlie Harper es un soltero alcohólico y mujeriego que vive una vida de lujo ',6,6,2);



Select * from peli_serie,pelicula where idPeli_serie=Peli_serie_idPeli_serie;
select * from peli_serie,serie where idPeli_serie=Peli_serie_idPeli_serie;

desc serie;
desc pelicula;
select * from pelicula;
select * from peli_serie;

drop table dire_actor;
#LLenamos registros en pelicula
Insert into pelicula values(5,250);
Insert into pelicula values(6,120);
Insert into pelicula values(7,110);
Insert into pelicula values(8,115);
Insert into pelicula values(9,230);
Insert into pelicula values(10,150);
Insert into pelicula values(11,140);
Insert into pelicula values(12,130);
Insert into pelicula values(13,260);
Insert into pelicula values(14,140);
Insert into pelicula values(15,130);
Insert into pelicula values(16,230);
Insert into pelicula values(17,305);
Insert into pelicula values(18,420);
Insert into pelicula values(19,220);
Insert into pelicula values(20,110);
Insert into pelicula values(21,100);
Insert into pelicula values(22,130);

Insert into pelicula values(58,130);
Insert into pelicula values(59,130);
Insert into pelicula values(60,130);
Insert into pelicula values(61,130);
Insert into pelicula values(62,130);
Insert into pelicula values(63,130);
Insert into pelicula values(64,130);
Insert into pelicula values(3,130);

Insert into pelicula values(23,120);
Insert into pelicula values(24,260);
Insert into pelicula values(25,140);
Insert into pelicula values(26,115);
Insert into pelicula values(27,230);
Insert into pelicula values(28,120);
Insert into pelicula values(29,110);
Insert into pelicula values(30,123);
Insert into pelicula values(31,230);
Insert into pelicula values(32,140);
#-----Llenamos registros de Series
insert into serie values(65);
insert into serie values(66);
insert into serie values(67);
insert into serie values(68);
insert into serie values(69);
insert into serie values(70);
insert into serie values(71);
insert into serie values(72);
insert into serie values(73);
insert into serie values(74);
insert into serie values(75);




call Alta_Plan(2,99.9,'Credito');
call Alta_Plan(2,99.9,'Debito');
call Alta_Plan(2,99.9,'Regalo');
call Alta_Plan(3,110,'Credito');
call Alta_Plan(3,110,'Debito');
call Alta_Plan(3,110,'Regalo');
call Alta_Plan(5,120,'Credito');
call Alta_Plan(5,120,'Debito');
call Alta_Plan(5,120,'Regalo');

select count(*) from pelicula;
select COUNT(*) from Peli_serie;
#---Genero romance
Update Peli_serie
set url_imagen ='cm-minoviapolly.JPG'
where idPeli_serie=8;
show tables;
desc pelicula;
select * from plan;
select * from Peli_serie;
select * from genero;
select * from clasificación;
#Planes
desc dire_actor_has_peli serie;
desc dire_actor_has_peli_serie;
select * from dire_actor_has_peli_serie;
select * from peli_serie,dire_actor_has_peli_serie,dire_actor where dire_actor_has_peli_serie.Dire_actor_idDire_actor=dire_actor.idDire_actor and dire_actor_has_peli_serie.Peli_serie_idPeli_serie=peli_serie.idPeli_serie and dire_actor.nombre like 'B%';
show create table dire_actor_has_peli-serie; 
Delete  from Peli_serie where idPeli_serie=9;
Select * from Peli_serie,Clasificación where Clasificación_idClasificación=idClasificación and Clasificación.Nombre like 'A%';
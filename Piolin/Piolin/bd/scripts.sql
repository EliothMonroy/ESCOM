create database piolin;
#drop database piolin;
use piolin;
#Tabla usuario
create table usuario(
	#Id del usuario generado por nosotros
    idUsuario int primary key auto_increment,
    #Nombre del usuario que se puede poner él mismo pero no se pueden repetir
    nombreUsuario nvarchar(20) not null unique,
    #Email del usuario
    email nvarchar(100) not null unique,
    #Contraseña del usuario, sql no acepta ñ
    contra nvarchar(20) not null,
    #Nombre del usuario, en realidad we don't care about this
    nombre nvarchar(20) not null default 'Holi, soy nuevo',
    #URL de donde se encuentra la foto del perfil
    fotoPerfil nvarchar(100) not null default '\imagenes\mecha.jpg',
    #Fecha en la que el usuario se registro
    fechaRegistro datetime not null default current_timestamp,
    #Estado nos indica si un usuario esta en activo o no, 1-> esta activo, 0-> no esta activo
    estado bool not null default 1    
);
#Tabla que relaciona a un usuario con otro que el sigue
create table usuario_sigue_usuario(
    #Id de un usuario
    idUsuario int not null,
    #Id del usuario que es seguidor del usuario de arriba
    idUsuario_seguidor int not null,
    #Claves foraneas
    foreign key (idUsuario) references usuario(idUsuario),
    foreign key (idUsuario_seguidor) references usuario(idUsuario),
    primary key (idUsuario, idUsuario_seguidor)
);
#Tabla que contiene la información de los tweets
create table tweet(
	#Identificador unico de cada tweet
    idTweet int primary key auto_increment,
    #Id del usuario que hizo el tweet
    idUsuario int not null,
    #140 caracteres para desahogarte 
    contenido nvarchar(140) not null,
    #Fecha en la que el tweet fue creado
    fechaCreacion datetime not null default current_timestamp,
    #Claves foraneas
    foreign key (idUsuario) references usuario(idUsuario)
);
#Tabla que almacena los reetweets, pero en realidad los retweets son tweets normales
create table retweet(
    #idTweet es el id del tweet al que se le hizo el retweet
    idTweet int not null,
    #Nuevo tweet hecho a partir del retweet
	idRetweet int not null,
    foreign key (idTweet) references tweet(idTweet),
    foreign key (idRetweet) references tweet(idTweet),
    primary key (idTweet, idRetweet)
);
#Tabla que almacena las relaciones entre tweets y respuestas
create table tweet_respuesta(
	#Tweet al que se respondio
    idTweet int not null,
    #Tweet con el que se respondio
    idTweetRespuesta int not null,
    foreign key (idTweet) references tweet(idTweet),
    foreign key (idTweetRespuesta) references tweet(idTweet)
);
#Tabla que almacena la información de los hashtags
create table hashtag(
	#Clave que nos ayuda a llevar un control en los hashtags
	idHashtag int primary key auto_increment,
    #El hashtag, por ejemplo, aquí se almacenaria hola del hasthag #hola
    hashtag nvarchar(139) not null unique
);
#Tabla que guarda la relación entre hashtags y tweets
create table tweet_hashtag(
	#Id del tweet que uso el hashtag
    idTweet int not null,
    #Id del hashtag usado
    idHashtag int not null,
    #Claves foraneas
    foreign key (idTweet) references tweet(idTweet),
    foreign key (idHashtag) references hashtag(idHashtag)
);
#Tabla que nos ayuda a manejar los archivos multimedia en un tweet
create table multimedia(
	#id del tweet que esta usuando contenido multimedia
    idTweet int not null,
    #Link a donde subimos la imagen
    url nvarchar(100) not null,
    foreign key (idTweet) references tweet(idTweet)
);
desc usuario;

#Procedures HAY QUE CORREGIRLOS !!

delimiter $

#Proedure para cambiar imagen
create procedure cambiarImagen(in idUsuario int(11), in imagenNombre varchar(100))
begin
	declare existe int;
SELECT 
    COUNT(*)
INTO existe FROM
    usuario
WHERE
    usuario.idUsuario = idUsuario;
    if existe=1 then
		UPDATE  usuario  SET fotoperfil=imagenNombre  WHERE usuario.idUsuario=idUsuario;
SELECT 1 AS msj;
	else
		select 0 as msj;
	end if;
end $

#Procedure para cambiar el nombre de usuario
create procedure cambiarNombre (in idUsuario int(11), in nuevoNombre varchar(20))
begin
	declare existe int;
    select count(*) into existe from usuario where usuario.idUsuario=idUsuario;
    if existe=1 then
		UPDATE  usuario  SET nombre=nuevoNombre  WHERE usuario.idUsuario=idUsuario;
        select 1 as msj;
	else
		select 0 as msj;
	end if;
end $

#Procedur para obtenersoloelcorreo
create procedure obtenerCorreo(in idUsuario int (11))
begin
	select email as msj from usuario where usuario.idUsuario=idUsuario;
end $
#Procedure para registrar usuario
create procedure Login(in email varchar(100), in contra varchar(20)) 
begin 
	declare existe int;
    select count(*) into existe from usuario where usuario.email=email and usuario.contra=contra;
    if existe=1 then
		select idUsuario as msj from usuario where usuario.email=email and usuario.contra=contra;
	else
		select 0 as msj;
	end if;
end $


#Procedure que obtiene la infromación de perfil de un usuario
create procedure Perfil(in idUsuario int(11))
begin
	declare nombreUsuario varchar(20);
    declare nombre varchar(20);
    declare foto varchar(100);
    declare tweets int;
    declare seguidores int;
    declare seguidos int;
    
    select usuario.nombreUsuario,usuario.nombre,fotoPerfil into nombreUsuario,nombre,foto from usuario where usuario.idUsuario=idUsuario;
    select count(*) into tweets from tweet where tweet.idUsuario=idUsuario;
    select (count(*)-1) into seguidores from usuario_sigue_usuario where usuario_sigue_usuario.idUsuario=idUsuario;
    select (count(*)-1) into seguidos from usuario_sigue_usuario where usuario_sigue_usuario.idUsuario_seguidor=idUsuario;
    select nombreUsuario as 'nombreUsuario', nombre as 'nombre', foto as 'fotoPerfil', tweets as 'tweets', seguidores as 'seguidores', seguidos as 'seguidos';
end $

#Procedure que obtiene los tweets que ha hecho un usuario
create procedure ObtenerTweetsUsuario(in idUsuario int)
begin
	select tweet.idTweet, tweet.contenido, timestampdiff(MINUTE,fechaCreacion,current_timestamp()) as 'fechaCreacion' from tweet where tweet.idUsuario=idUsuario order by fechaCreacion ;
end $

#Procedure para registrar usuario
create procedure RegistrarUsuario(in nombreUsuario varchar(20), in email varchar(100), in contra varchar(20), in nombre varchar(20), in fotoPerfil varchar(100))
begin
	declare existe int;
    declare id int;
    select count(*) into existe from usuario where usuario.nombreUsuario=nombreUsuario or usuario.email=email;
    if existe=0 then
		insert into usuario values(default, nombreUsuario, email, contra, nombre, fotoPerfil, default, default);
        select usuario.idUsuario into id from usuario where usuario.email=email;
        insert into usuario_sigue_usuario values(id,id);
		select 1 as msj;
	else
		#El nombre de usuario o email ya esta en uso
        select 0 as msj;
	end if;
end $

#Procedure para mostrar a los usuarios que siguen a un usuario
create procedure MostrarSeguidores(in idUsuario int)
begin
	select usuario.idUsuario, usuario.nombreUsuario, usuario.nombre,usuario.fotoPerfil from usuario, usuario_sigue_usuario where usuario_sigue_usuario.idUsuario=idUsuario and usuario.idUsuario=usuario_sigue_usuario.idUsuario_seguidor;
end $

#Procedure para mostrar a que usuarios sigue un usuario
create procedure MostrarSeguidos(in idUsuario int)
begin
	select usuario.idUsuario, usuario.nombreUsuario, usuario.nombre,usuario.fotoPerfil from usuario, usuario_sigue_usuario where usuario_sigue_usuario.idUsuario=usuario.idUsuario and usuario_sigue_usuario.idUsuario_seguidor=idUsuario;
end $

#Procedure para mostrar los tweets que se le deben mostrar a un usuario
create procedure MostrarTweets(in idUsuario int)
begin
	create temporary table IF NOT EXISTS usuarios_ids
		select usuario.idUsuario from usuario, usuario_sigue_usuario where usuario.idUsuario=usuario_sigue_usuario.idUsuario and usuario_sigue_usuario.idUsuario_seguidor=idUsuario;
	create temporary table IF NOT EXISTS usuarios_tweets
		select tweet.idTweet, tweet.idUsuario, tweet.contenido, timestampdiff(MINUTE,tweet.fechaCreacion,current_timestamp()) as 'fechaCreacion' from tweet, usuarios_ids where tweet.idUsuario=usuarios_ids.idUsuario;
	select * from usuarios_tweets order by fechaCreacion limit 50;
    drop temporary table usuarios_ids;
    drop temporary table usuarios_tweets;
end $

create procedure crearTweet(in idUsuario int, in contenido varchar(140))
begin
	insert into tweet values(default, idUsuario, contenido, default);
	select idTweet from tweet order by fechaCreacion desc limit 1;
end $
create procedure buscar(in NombreUs varchar(30))
begin
	select idUsuario,nombreUsuario,nombre,fotoperfil from usuario where nombreUsuario like  concat('%',NombreUs,'%');
end $

create procedure obtenerNom(in id int)
begin
select nombre  as nom , fotoPerfil from usuario where idUsuario=id;
end $

create procedure verSeg(in idpropio int,in idseguidor int)
begin
	select 1 as msj from usuario_sigue_usuario where idUsuario=idpropio and idUsuario_seguidor=idseguidor;
end $

#Procedure para seguir usuarios
create procedure seguirUsuario(in idUsuario int, in idOtro int)
begin
	insert into usuario_sigue_usuario values(idOtro, idUsuario);
    select 1 as msj;

end$

#procedures en prueba XD
create procedure crearReTweet(in idTweet int,in idRetweet int)
begin
	insert into retweet values(idTweet,idRetweet);
    select 1 as msj;
end $

create procedure ObtenerTweet(in idTw int)
begin
	select idUsuario, contenido from tweet where idTweet=idTw;
end $

#Procedure que guarda los hashtags
create procedure guardarHashtag(in hashtag varchar(140), in idTweet int)
begin
	declare existe int;
    declare idHash int;
    #Primero contamos cuantas veces esta el hashtag en la tabla hashtag
    select count(*) into existe from hashtag where hashtag.hashtag=hashtag;
    #En caso de no existir, lo guardamos en la tabla hashtag y posteriormente en la tabla de tweet_hashtag
    if existe=0 then
		insert into hashtag values(default, hashtag);
        #Obtenemos el id del hashtag que acabamos de guardar
        select idHashtag into idHash from hashtag where hashtag.hashtag=hashtag; 
        insert into tweet_hashtag values(idTweet, idHash);
        select 1 as msj;
	else
		#Signigica que el hashtag ya existe, entonces solo guardamos en la tabla tweet_hashtag
        select idHashtag into idHash from hashtag where hashtag.hashtag=hashtag; 
        insert into tweet_hashtag values(idTweet, idHash);
        select 1 as msj;
    end if;
end $

#borra un tweet en especifico
create procedure borrarTweet(in idTw int)
begin
	delete from tweet_hashtag where idTweet=idTw;
    delete from tweet where idTweet=idTw;
    select 1 as msj;
end $

#Procedure que obtiene los trending topics
create procedure obtenerTT()
begin
	select count(*) as total,tweet_hashtag.idHashtag,hashtag.hashtag from tweet_hashtag, hashtag where hashtag.idHashtag=tweet_hashtag.idHashtag group by idHashtag order by total desc limit 10;
end $

#Procedure que almacena la respuesta a un tweet
create procedure respuesta(in idTweet int, in idUsuario int, in contenido varchar(140))
begin
	declare id int;
	insert into tweet values(default,idUsuario, contenido, default);
    select idTweet into id from tweet order by fechaCreacion desc limit 1;
    insert into tweet_respuesta values(idTweet,id);
    select 1 as msj;
end $

delimiter ;
desc tweet;
desc usuario;
desc usuario_sigue_usuario;
select * from usuario_sigue_usuario;
select * from usuario;
select * from tweet;
select * from usuarios_ids;
select * from hashtag;
select * from tweet_hashtag;
select idUsuario, contenido from tweet where idTweet=4;

#llamadas a procedimientos
call Ultimo();
call ObtenerTweet(4);
call crearReTweet(1,2);
call Login('dany@yahoo.com','Perritos');
call Perfil(3);
call obtenerTweetsUsuario(1);
call RegistrarUsuario('Ioncito7', 'ioncito7@gmail.com', 'Gatitos', 'Ian Mendoza', 'Url de foto de su perro');
call MostrarSeguidores(1);
call MostrarSeguidos(2);
call MostrarTweets(2);
call MostrarTweets(1);
call crearTweet(2, 'Soy chida ahorita');
call cambiarNombre(2,'La Ame flow');
call obtenerCorreo(6);
call obtenerNom(1);
call buscar('lioth');
call verSeg(1,2);
call obtenerTT();
#Drops de procedures
drop procedure Login;
drop procedure obtenerTweetsUsuario;
drop procedure MostrarTweets;
drop procedure RegistrarUsuario;
#Drop de tablas
drop temporary table usuarios_ids;
drop temporary table usuarios_tweets;

##Inserts varios
select * from tweet order by fechaCreacion desc;
select count(*) as total,tweet_hashtag.idHashtag,hashtag.hashtag from tweet_hashtag, hashtag where hashtag.idHashtag=tweet_hashtag.idHashtag group by idHashtag order by total desc limit 10;
select idUsuario from usuario where usuario.nombreUsuario like '%#i%';
insert into usuario values(default,'El Dany', 'dany@yahoo.com','Perritos', 'Dany Herrera',default);
insert into tweet values(default,4,'Soy bien chido',default);
insert into usuario_sigue_usuario values(4,2);
##Deletes
delete from usuario where idUsuario=7;
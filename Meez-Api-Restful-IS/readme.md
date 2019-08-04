# Instalar el servidor:
* Necesitas python 3.x
* Descargar el repo con git clone
* Desde la carpeta en donde se haya descargado ejecutar: pip install -r requirements.txt
* Ahora solo ejecutar: python hello.py
* Ahora solo necesitas la ip de tu computadora

# Meez Api-Restful

* url general del proyecto: http://vast-headland-44785.herokuapp.com

## Módulo Sincronizar

### Obtener contenido de un usuario

* Petición get con el siguiente campo: id.
* Si se encuentra el id se regresa un json con el contenido de lo que el usuario ha creado.
* En caso contrario se retorna un Success=False.
* url: /sincronizar/&#60;id&#62;

### Guardar Contenido

* Petición post con los siguientes campos: correo, contenido.
* Simpre se retorna Success=True.
* url: /sincronizar

## Módulo Usuarios:

### Registro de Usuario:

* Petición POST con los siguiente campos: 'correo', 'nombre', 'apellidos','contra'.
* El Servidor retorna un json si pudo ser registrado o no (Success True o False según corresponda).
* url: /usuario
* (completo: http://vast-headland-44785.herokuapp.com/usuario)

### Busqueda de un usuario

* Petición GET con el siguiente campo: 'id' (el id del usuario es su correo) (Nótese que el parámetro es enviado por la url).
* El servidor retorna un json con toda la información del usuario o en caso contrario manda un json con Success=False.
* url: /usuario/&#60;id&#62;

### Login de Usuario

* Petición POST con los siguientes campos: 'correo', 'contra'
* El servidor regresa Success True o false según sea el caso.
* url: /login

## Módulo Servicios

* (Nótese que las categorias son lo mismo que los servicios).

### Obtener servicios de un usuario

* Petición get con el campo: id (el id del usuario es su correo) (Nótese que el parámetro es enviado por la url).
* El servidor en caso de encontrar servicios regresa un json que contiene a todos los servicios que haya creado
o en caso contrario regresa Success=False
* url: /servicio/&#60;id&#62;

### Agregar servicio

* Petición post con los siguientes campos: 'correo' (id del usuario que esta creando el servicio), 'nombre' (nombre del servicio).
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /servicio

### Eliminar Servicio

* Petición delete con el siguiente campo: 'id' (es el id del servicio a eliminar).
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /servicio/&#60;id&#62;

## Módulo Frases

### Obtener Frases

* Petición get con los siguientes campos: 'id' (id del usuario), 'servicio_id' (id del servicio) (Nótese que los parámetros son enviados por la url).
* El servidor regresa un json con todas las frases que el usuario haya creado para esa categoria o en caso de que no tenga ninguna regresa Succes=False.
* url: /frase/&#60;id&#62;/&#60;servicio_id&#62;

### Eliminar Frase

* Petición delete con el siguiente campo: 'frase_id' (Nótese que el parámetro es enviado por la url).
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /frase/&#60;frase_id&#62;

### Añadir Frase

* Petición post con los siguiente campos: 'correo', 'categoria', 'nombre', 'contenido'.
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /frase

### Editar Frase

* Petición set con los siguiente campos: 'frase_id' (Nótese que el parámetro es enviado por la url), 'nombre', 'contenido'.
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /frase/&#60;frase_id&#62;

## Módulo Queja

### Crear Queja

* Petición post con el siguiente campo: 'contenido' (es el contenido de la queja).
* El servidor siempre regresa Success=True porque en teoría nada debería de salir mal.
* url: /queja

### Obtener Quejas
* Petición get.
* El servidor regresa un json con todas las quejas.
* url: /queja

<%-- 
    Document   : MenuDePeliculas
    Created on : 03-dic-2016, 23:19:18
    Author     : usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Menu De Peliculas</title>
    </head>
    <body>
        <h1>Aqui iran todas las peliculas de la pagina principal</h1>
        <form action="Buscar" method="post" role="form">
            <input type="search" class="form-control input-lg" id="buscar" name="buscar" placeholder="¿Qué deseas buscar?" required>
            <button type="submit">Buscar</button>
        </form>
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>

<%-- 
    Document   : Excel
    Created on : 06-dic-2016, 15:45:35
    Author     : usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link href="https://fonts.googleapis.com/css?family=Pathway+Gothic+One" rel="stylesheet">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>JSP Page</title>
    </head>
    <body>
        <div class="container">
            <!--Lista de planes-->
                <ul class="list-group list-inline">
                    <!--Plan 1-->
                    
                    <Br><Br><Br><Br><Br>
                    <Br><Br><Br><Br><Br>
                    <Br><Br>
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Excel" method="POST" role="repo">
                                <legend class="text-center"><button type="submit" name="reporte" value="repo1" class="btn btn-primary margin-btn">Reporte de Usuarios</button></legend>
                                <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">Muestra toda la informacion de los usuarios</li>
                                    </center>
                                </ol>                      
                            </form>
                        </li>
                    </div>
                    <!--Plan 2-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Excel" method="POST" role="repo">
                                <legend class="text-center"><button type="submit" name="reporte" value="repo2" class="btn btn-primary margin-btn">Reporte de peliculas</button></legend>
                                <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">Muestra la informacion de las peliculas</li>
                                    </center>
                                </ol>       
                            </form>
                        </li>
                    </div>
                    <!--Plan 3-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Excel" method="POST" role="repo">
                                <legend class="text-center"><button type="submit" name="reporte" value="repo3" class="btn btn-primary margin-btn">Usuarios y método de pago</button></legend>
                                 <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">Muestra la informacion de los clientes en cuanto a métodos de pago</li>
                                    </center>
                                </ol>                                  
                            </form>
                        </li>
                    </div>
                    
                </ul>
             <small><br><a class="btn btn-sm" href="index.html" role="button">Volver al inicio</a></small>
            </div>
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>

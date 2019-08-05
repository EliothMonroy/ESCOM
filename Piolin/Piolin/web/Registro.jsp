<%-- 
    Document   : Registro
    Created on : 30/11/2016, 08:57:51 PM
    Author     : 
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!doctype html>

<html lang="en"> 
    <head>
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link rel="stylesheet" href="css/normalize.css">
        <link rel="stylesheet" href="css/Index.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="icon" href="imagenes/Twitter_Bird.png">
        <!-- Bootstrap Core CSS -->
        <link href="css/bootstrap.min.css" rel="stylesheet">

        <!-- Custom CSS -->
        <link href="css/stylish-portfolio.css" rel="stylesheet">

        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    </head>
    <body> 
        <!-- Header -->
        <header class="header-registro">
            
            <div class="text-vertical-center">
                <div class="registro-container">
                    
                    <div class="registrate-container">
                        <div class="col-md-1">
                            <div>
                                    <form method="post" action="Registro" enctype="multipart/form-data"> <!--no tiene cierre!!-->
                                    <legend style="color:white">Registrate</legend>
                                    <label for="nombre">Nombre </label>
                                    <br/> <input type="text" class="form-control" placeholder="Nombre" name="nombre" id="nombre" style="color:black" required/>
                                    <br/> <label for="user">Usuario</label>
                                    <br/> <input type="text"  class="form-control" placeholder="Usuario" name="user" id="user" style="color:black" required/>
                                    <br/> <label for="email">Correo</label>
                                    <br/> <input type="email"  class="form-control" placeholder="e-mail" name="email" id="email" style="color:black" required/>
                                    <br/> <label  for="password">Password</label>
                                    <br/> <input type="password" class="form-control" placeholder="*****" name="password" id="password" style="color:black;" required/>
                                    <br/> <br/> <input type="submit" class="btn btn-info" value="Regitrarse" style="float: left;"><br><br>
                                    
                                    </div>
                                    </div>
                        </div>
                            <div class="imagen-seleccion-container">
                                <div class="col-md-1">
                                    <table class="text-center">
                                            <td>
                                                <section>

                                                        <legend style="color:white">Selecciona una foto de perfil:</legend>
                                                        <img src="imagenes/profile-icon.png" width="240" height="240">

                                                    <br/><input type="file" value="Examinar" class="btn " id="fotoP" name="fotoP">                                                   
                                                    <small>¿Ya tienes una cuenta? <a href="index.html" style="color:#6495ED">Inicia Sesión aquí</a></small>
                                                    </form>
                                                </section>
                                            </td>
                                    </table>
                                </div>
                            </div>
                        </div>
                    </div>

                    </header>


                    <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
                    <script src="js/jquery.js"></script>
                    <!-- JS de bootstrap -->
                    <script src="js/bootstrap.js"></script>
                    </body>
                    </html>
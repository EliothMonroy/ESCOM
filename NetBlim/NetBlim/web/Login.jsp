<%-- 
    Document   : Login
    Created on : 29/11/2016, 07:36:03 PM
    Author     : 
--%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0">        
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link rel="stylesheet" href="css/bootstrap.css">
        <!--<link rel="stylesheet" href="css/styles.css">-->
        <link rel="stylesheet" href="css/estilos_generales.css" >
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Inicia Sesión</title>
    </head>
    <body>
        <!--Header chido -->
        <header>
            <nav class="navbar navbar-fixed-top bar-fixed color-bar">
                <div class="container-fluid">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <div class="navbar-header">
                                <a href="/NetBlim" class="header-logo header-logo-fixed">NETBLIM<!--<img src="img/netblim.png" class="img-responsive" alt="Logo" width="200" height="200">--></a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!--Fin header -->
        <section class="container section-fixed">
             <%
          
                                String e ="";
                                
                                
                                    e = request.getParameter("r");
                                    if (e!=null){
                                        if (e.equals("1")) {
                                        out.write("<div class='alert alert-success alert-dismissable'>"
                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                + "<strong>¡Éxito!</strong> Inicia Sesion."
                                                + "</div>");
                                    }
                                    if (e.equals("2")) {
                                        out.write("<div class='alert alert-danger alert-dismissable'>"
                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                + "<strong>¡Error!</strong> Hubo un problema. Intente de nuevo."
                                                + "</div>");
                                    }
                                     if (e.equals("3")) {
                                        out.write("<div class='alert alert-danger alert-dismissable'>"
                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                + "<strong>¡Error! </strong>Usuario o contraseña incorrectos"
                                                + "</div>");
                                    }
                                    if (e.equals("4")) {
                                        out.write("<div class='alert alert-danger alert-dismissable'>"
                                                + "<button type='button' class='close' data-dismiss='alert'>&times;</button>"
                                                + "<strong>¡Error! </strong>Número maximo de usuarios alcanzado"
                                                + "</div>");
                                    }
                                    }
                                    
    
    %>
        <div class="container-fixed">
            <div class="text-center ">
                <h1>Inicia Sesión
                    <small><br><a class="btn btn-sm" href="Registro.jsp" role="button">O puedes registrarte aquí</a></small>
                </h1>
            </div>
        </div>
        <%/*
            if(request.getParameter("r")!=null){
                out.println(request.getParameter("r"));
            }*/
        %>
        
         <!--Formulario de Login-->
         <div>
             <div class="row">
                 <div class="col-xs-1"></div>
                 <div class="col-xs-10">
                     <form action="Login" method="post" role="form">
                        <legend></legend>
                        <div class="form-group">
                            <label for="email">Correo electrónico:</label>
                            <input type="email" class="form-control input-lg" id="email" name="email" placeholder="netblim@netblim.com" required>
                        </div>
                        <div class="form-group">
                            <label for="contra">Contraseña:</label>
                            <input type="password" class="form-control input-lg" id="contra" name="contra" placeholder="*******" required>
                        </div>
                        <button type="submit" class="btn btn-primary">Dale!</button>
                    </form>
                 </div>
                 <div class="col-xs-1"></div>
             </div>
         </div>
         <!--Fin formulario login--> 
        </section>
        
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>

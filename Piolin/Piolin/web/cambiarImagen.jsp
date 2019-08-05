<%-- 
    Document   : cambiarImagen
    Created on : 3/12/2016, 05:12:38 PM
    Author     : Daniel
--%>

<%@page import="Logica.Inicio_L"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Cambiar imagen</title>
         <link rel="stylesheet" href="css/bootstrap.css">
         <link rel="stylesheet" href="css/styles.css">
    </head>
   <header id="header" class="header" width="100%"><!-- Header -->
            <%
                HttpSession sesion= request.getSession();
                Integer id= (Integer)sesion.getAttribute("idUsuario");
                Inicio_L inicio= new Inicio_L();
                %>
            <nav role="navigation" style="background-color:#5AAFE6">
                    <!-- Brand and toggle get grouped for better mobile display -->
                    <div class="navbar-header">
                        <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                            <span class="sr-only">Toggle navigation</span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                            <span class="icon-bar"></span>
                        </button>
                        <img class="imagen-container-logo" src="imagenes\tweet.png" alt="Icono">
                    </div>

                    <!-- Collect the nav links, forms, and other content for toggling -->
                    <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                        <ul class="nav navbar-nav">
                        </ul>
                        <div class="col-sm-3 col-md-3">
                            
                        </div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="button1" href="Inicio.jsp">Inicio</a></li>
                            <li><a class="button1" href="index.html">Cerrar sesion</a></li>
                            <li><a class="button1" href="Perfil.jsp">Perfil</a></li>
                        </ul>
                    </div><!-- /.navbar-collapse -->
                </nav>
        </header>
<br/> 
    <body>     
        <table style="margin: 0 auto;" class="text-center">
            <tr>
                <td>
                    <div><form action="cambiarImagenserv" name="cambform" method="post" enctype="multipart/form-data">
                        <section><div><br/> <br/> <legend style="font-size: 150%">Selecciona tu foto de perfil</legend>
			<br/> <img src="<%=inicio.imagen(id)%>" width="300" height="300">
                        </div>
                        <br/><input  type="file" value="Examinar" class="btn" id="fotoP" name="imagenNueva" required>
                        <br/> <br/> <input type="submit" class="btn btn-primary" value="Cambiar"><br><br>
                        </section>             
		</form></div>
                        <form action="cambiarNombre"  method="post">
                            <div style="display:inline-block">
                                <textarea class="text-container-cambiar-nombre" name="txtcorreo" placeholder="tu nuevo nombre" required></textarea>
                                <input type="submit" class="btn btn-primary" value="Cambiar nombre">
                            </div>
                    </form>
                        </td>
                        
                    
            </tr>
        </table>       
    </body>
</html>

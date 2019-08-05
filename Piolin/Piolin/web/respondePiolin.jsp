<%-- 
    Document   : reeTweet
    Created on : 8/06/2017, 04:57:17 PM
    Author     : ANDRES
--%>
<%@page import="Logica.Inicio_L"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page session='true'%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bd.cConexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>rePiolin</title>
        <link rel="stylesheet" href="css/Fonts.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!-- Custom Fonts -->
        <link href="font-awesome/css/font-awesome.min.css" rel="stylesheet" type="text/css">
        <link href="https://fonts.googleapis.com/css?family=Source+Sans+Pro:300,400,700,300italic,400italic,700italic" rel="stylesheet" type="text/css">

    </head>
    
       <header id="header" class="header" width="100%"><!-- Header -->
        <%          
            int idPiolin=0,idUsuario=0,idUsu=0;
            String contenido="",usuarioOriginal="";
            Inicio_L inicio = new Inicio_L();
            
            /*cachamos el id del tweet a retuetear*/
            String id=request.getParameter("idTweet");
            System.out.println("idTweet: "+id);
            
            /*ahora del usuario que retueteara*/    
                cConexion con=new cConexion();
                con.conectar();
                System.out.println("Conexion exitosa");
                HttpSession sesion= request.getSession();
                idUsuario= (Integer) sesion.getAttribute("idUsuario");     
                System.out.println(idUsuario);
                ResultSet rs = con.consulta("call ObtenerTweet('"+id+"')");
                if (rs.first()) {
                    idUsu=rs.getInt("idUsuario");
                    contenido=rs.getString("contenido");                  
                }
            /*obtenemos el nombre del usuario del tweet original*/
                ResultSet rs1 = con.consulta("call obtenerNom('"+idUsu+"')");    
                if (rs1.first()) {
                    usuarioOriginal=rs1.getString("nom");                  
                }
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
    
    <body background="img/bg-registro3.jpeg" style="background-size: 1500px 2500px;">
        <br>

        <form action="responderPiolin" method="post">
            
            <div style="background-color: #CEE3F6; width: 50%; height: 22em; margin: auto;text-align:center;border-radius:5px;margin-top:8%;box-shadow:10px 10px 50px grey">
                <div style="background-color:#77B8F5;color:white;border-radius:5px;">
                <h1>Responder</h1>    
                <p  style="font-size: 20px;"> <%=usuarioOriginal%>:  <%=contenido%> </p>
                </div>
                <br>
                <div style="display: inline-block;float: left;width: 150px;height: 75px">
                <img src="<%=inicio.imagen(idUsuario)%>" alt="Logo" class="imagen-container-retweet">
                </div><div style="display: inline-block;float: left;width: 250px;height:75px">
                <textarea class="text-container-retweet" id="message1" name="Respuesta"  placeholder="Escribe aquí tu respuesta..." style="width: 32em;" required></textarea>   
                <input name="idTweet" id="idtwtorg" value="<%=id%>" type="text" hidden disabled>
                <button name="message2" id="message2" value="<%=usuarioOriginal%>: <%=contenido%>" type="submit" class="btn btn-info" style="margin-left:25em;margin-top:1em;" name="login"  value="Piolinazo">Responder <span class="glyphicon glyphicon-share-alt"></span></button>  
                </div>                       
            </div><br>            
        </form>
    </body>
</html>

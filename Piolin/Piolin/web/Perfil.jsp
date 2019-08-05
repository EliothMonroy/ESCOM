
<%@page import="Logica.Hashtag"%>
<%@page import="Logica.Inicio_L"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page session='true'%>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bd.cConexion"%>


<!DOCTYPE html>
<html lang="es">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Perfil</title>
        <link rel="stylesheet" href="css/Fonts.css">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">

    </head>

    <body style="background-color: #F2F2F2;">
        <%
            String datos[] = new String[5];
            Integer numeros[];
            numeros = new Integer[5];
            Inicio_L inicio = new Inicio_L();
            Integer idUsuario;
            HttpSession sesion = request.getSession();
            idUsuario = (Integer) sesion.getAttribute("idUsuario");
            int msj = 0;
            //Falta hacer la parte de que no se vuelva a mostrar el boton de seguir si un usuario ya sigue a otro.
            String rq1 = request.getParameter("id");

            if (rq1 == null) {
                cConexion con = new cConexion();
                con.conectar();
                ResultSet rs = con.consulta("call Perfil('" + idUsuario + "')");
                if (rs.first()) {
                    datos[0] = rs.getString("nombre");
                    datos[1] = rs.getString("nombreUsuario");
                    datos[2] = rs.getString("fotoPerfil");
                    numeros[0] = rs.getInt("tweets");
                    numeros[1] = rs.getInt("seguidores");
                    numeros[2] = rs.getInt("seguidos");

                }else{
                }
            //Caso de perfil foraneo 
            } else {

                cConexion con = new cConexion();
                con.conectar();
                ResultSet rs = con.consulta("call Perfil('" + rq1 + "')");
                if (rs.first()) {
                    datos[1] = rs.getString("nombreUsuario");
                    datos[0] = rs.getString("nombre");
                    datos[2] = rs.getString("fotoPerfil");
                    numeros[0] = rs.getInt("tweets");
                    numeros[1] = rs.getInt("seguidores");
                    numeros[2] = rs.getInt("seguidos");
                } else {
                    System.out.println("error D:");
                }
            }%>

        
            <div class="fb-profile">
                
                <!--barra de navegacion-->
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
                            <form class="navbar-form" role="search" action="Busqueda.jsp" method="get">
                                <div class="input-group">
                                    <input type="text" class="form-control" name="buscar" placeholder="Buscar" required/>
                                    <div class="input-group-btn">
                                        <button class="btn btn-default" type="submit"><i class="glyphicon glyphicon-search"></i></button>
                                    </div>
                                </div>
                            </form>
                        </div>
                        <ul class="nav navbar-nav navbar-right">
                            <li><a class="button1" href="#" data-toggle="modal" data-target="#login-modal" style="background-color:#3691C6">Piolinea</a></li>
                            <li><a class="button1" href="Inicio.jsp">Inicio</a></li>
                            <li><a class="button1" href="Salir">Cerrar sesión</a></li>
                            <li><img src="<%=inicio.imagen(idUsuario)%>" width="40" height="40" alt="Logo" class="imagen-container-perfil"></li>
                        </ul>
                    </div>
                </nav>

                
                <!--portada del perfil-->
                <div class="portada-container">
                    <img align="left" class="fb-image-lg" src="imagenes\light-blue-background-2.jpg" alt="Profile image example" width="200" height="300" />
                    <img align="left" class="fb-image-profile thumbnail" src="<%=datos[2]%>" width="210" height="250"/>
                    <% if (rq1 == null) { %>
                    <a href="cambiarImagen.jsp"><button class="btn btn-info">Cambiar imagen</button></a>
                    <%} else { %>
                </div>    
                

                
                <%
                    ResultSet r = inicio.Seguir(idUsuario, Integer.parseInt(rq1));
                    if (r.first()) {
                        msj = r.getInt("msj");
                    } else {
                        msj = 0;
                    }
                    System.out.println(msj);
                    if (msj == 0) {
                %>
                <form action="SeguirUsuario" method="post">
                    <a class="btn btn-info" href="SeguirUsuario?idSeguidor=<%=rq1%>">Seguir</a>
                    <input type="text" disabled hidden value="rql" name="idSeguidor">
                </form>

                <%
                } else {
                %>
                <button class="btn btn-info">Siguiendo</button>             
                <%}%>

                <%}%>

                <div class="fb-profile-text">

                    <div name="division1"> 
                        <h2><%=datos[0]%></h2>

                        <li><h3>@<%=datos[1]%></h3>
                            <h4>Piolinazos: <%=numeros[0]%></h4>
                            <h4>Seguidores: <%=numeros[1]%></h4>
                            <h4>Seguidos: <%=numeros[2]%></h4></li>
                    </div>
                    <br>
                    <div>
                        <!--tweets-->
                        <%
                            if (rq1 == null) {
                        %>
                
                        <%
                            /*caso de encontrar un primer tweet*/
                            try {
                                cConexion con = new cConexion();
                                con.conectar();
                                ResultSet rs = con.consulta("call ObtenerTweetsUsuario('" + idUsuario + "')");
                                if (rs.first()) {

                                    numeros[3] = rs.getInt("idTweet");
                                    datos[3] = rs.getString("contenido");
                                    Hashtag has=new Hashtag();
                                    datos[3]=has.hasHashtag(datos[3]); 
                                    numeros[4] = Integer.parseInt(rs.getString("fechacreacion"));
                                    String fecha = inicio.fecha(numeros[4]);
                        %>
                        <form method="post" action="reeTweet.jsp">
                        <div style="width: 70%; margin:auto;box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);">
                            <pre style="background-color: white;">
                            <img src="<%=inicio.imagen(idUsuario)%>" alt="Logo" class="imagen-container-perfiles" style="margin-top: 5%;">
                            <li style="font-size: 20px;"><a href="Perfil.jsp"><%=datos[0]%></a>: <%=datos[3]%></li>
                            <li style="color: grey;">Hace:   <%=fecha%></li>
                            <button name="idTweet" value="<%=numeros[3]%>" type="submit"  class="btn btn-info" style="float:right;margin-left: 2%;margin-bottom: 5%">Repiolin   <span class="glyphicon glyphicon-retweet"></span></button>
                           </form>
                           <form method="post" action="borrarTweet">
                               <button name="idTweet" value="<%=numeros[3]%>" type="submit" class="btn btn-alert" style="float:right"><span class="glyphicon glyphicon-remove"></span></button>
                           </form>
                            </pre>
                        </div><br>
                        
                        <%
                            /*caso de encontrar mas tweets*/
                            while (rs.next()) {
                                numeros[3] = rs.getInt("idTweet");
                                datos[3] = rs.getString("contenido");
                                datos[3]=has.hasHashtag(datos[3]); 
                                numeros[4] = Integer.parseInt(rs.getString("fechaCreacion"));
                                String fechas = inicio.fecha(numeros[4]);
                        %>
                        <form method="post" action="reeTweet.jsp">
                        <div style="width: 70%; margin:auto;box-shadow: 0px 2px 2px rgba(0, 0, 0, 0.1);">
                            <pre style="background-color: white;">
                            <img src="<%=inicio.imagen(idUsuario)%>" alt="Logo" class="imagen-container-perfiles" style="margin-top: 5%;">
                            <li style="font-size: 20px;"><a href="Perfil.jsp"><%=datos[0]%></a>: <%=datos[3]%></li>
                            <li style="color: grey;">Hace:   <%=fechas%></li>
                            <button name="idTweet" value="<%=numeros[3]%>" type="submit"  class="btn btn-info" style="float:right;margin-left: 2%;margin-bottom: 5%">Repiolin   <span class="glyphicon glyphicon-retweet"></span></button>
                           </form>
                           <form method="post" action="borrarTweet">
                               <button name="idTweet" value="<%=numeros[3]%>" type="submit" class="btn btn-alert" style="float:right"><span class="glyphicon glyphicon-remove"></span></button>
                           </form>
                            </pre>
                        </div><br>
                        <%
                                }
                            } else {
                                System.out.println("error D:");
                            }
                        %>
                        <%} catch (SQLException e) {
                                System.out.println("" + e.getMessage());
                            }
                        } else {
                            cConexion con = new cConexion();
                            con.conectar();
                            ResultSet rs = con.consulta("call ObtenerTweetsUsuario('" + rq1 + "')");
                            if (rs.first()) {
                                numeros[3] = rs.getInt("idTweet");
                                datos[3] = rs.getString("contenido");
                                Hashtag has=new Hashtag();
                                datos[3]=has.hasHashtag(datos[3]); 
                                numeros[4] = Integer.parseInt(rs.getString("fechacreacion"));
                                String fecha2 = inicio.fecha(numeros[4]);
                        %>
                        <form method="post" action="reeTweet.jsp">
                        <pre style="background-color: white; width: 70%; margin: auto;">
                            <li> <img src="<%=inicio.imagen(Integer.parseInt(rq1))%>" alt="Logo" class="imagen-container-retweet"></li>
                            <li style="font-size: 20px;"><a href="Perfil.jsp"><%=datos[0]%></a>: <%=datos[3]%></li>
                            <li style="color: grey;">Hace:   <%=fecha2%></li>
                            <button name="idTweet" value="<%=numeros[3]%>" type="submit"  class="btn btn-info" style="float:right;margin-left: 2%;margin-bottom: 5%">Repiolin   <span class="glyphicon glyphicon-retweet"></span></button>
                            </form>
                            <!--<form method="post" action="borrarTweet">
                               <button name="idTweet" value="<%=numeros[3]%>" type="submit" class="btn btn-alert" style="float:right"><span class="glyphicon glyphicon-remove"></span></button>
                           </form>-->
                        </pre><br>
                        
                        <%
                            while (rs.next()){
                                numeros[3] = rs.getInt("idTweet");
                                datos[3] = rs.getString("contenido");
                                datos[3]=has.hasHashtag(datos[3]); 
                                numeros[4] = Integer.parseInt(rs.getString("fechacreacion"));
                                String fecha3 = inicio.fecha(numeros[4]);
                        %>
                        <form method="post" action="reeTweet.jsp">
                        <pre style="background-color: white; width: 70%; margin: auto;">
                            <li><img src="<%=inicio.imagen(Integer.parseInt(rq1))%>" alt="Logo" class="imagen-container-retweet"></li>
                            <li style="font-size: 20px;"><a href="Perfil.jsp"><%=datos[0]%></a>: <%=datos[3]%></li>
                            <li style="color: grey;">Hace:   <%=fecha3%></li>
                            <button name="idTweet" value="<%=numeros[3]%>" type="submit"  class="btn btn-info" style="float:right;margin-left: 2%;margin-bottom: 5%">Repiolin   <span class="glyphicon glyphicon-retweet"></span></button>
                            </form>
                            <!--<form method="post" action="borrarTweet">
                               <button name="idTweet" value="<%=numeros[3]%>" type="submit" class="btn btn-alert" style="float:right"><span class="glyphicon glyphicon-remove"></span></button>
                           </form>-->
                        </pre>                           
                            <br>

                        <%
                                    }
                                } else {
                                    System.out.println("error D:");
                                }
                            }
                        %>

                    </div>                  
            </div>
        </div>
                        <!--Popup para twittear-->
                <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  style="display: none;">
                     <div class="modal-dialog">
                         <div class="loginmodal-container-tweet">
                                <form action="Piot_Ser" method="post">
                                    <img src="<%=inicio.imagen(idUsuario)%>" width="80" height="80" alt="Logo" class="imagen-container-perfil-tweet">
                                    <textarea class="text-container" id="message" name="message" maxlength="140" placeholder="Comparte un pensamiento" required></textarea>
                                    <h4 id='caracteres'>140</h4>          
                                    <button  class="btn btn-info" type="submit" name="login"  value="Piolinazo" style="width:10em;float: right;">
                                        Piolinazo   <span class="glyphicon glyphicon-send"></span>
                                    </button>       
                                </form>  
                        </div>
                    </div>
                </div>
        <!--Final del Popup de inicio de sesion-->
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- this goes inside the header tag-->
        <link href="//cdnjs.cloudflare.com/ajax/libs/animate.css/3.0.0/animate.min.css" rel="stylesheet" type="text/css">
        <!-- all these references goes before the closing body tag-->
        <script src="http://code.jquery.com/jquery-1.10.2.min.js"></script>
        <script src="http://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.3/jquery.easing.min.js"></script>
        <script src="//cdn.jsdelivr.net/stickynavbar.js/1.3.2/jquery.stickyNavbar.min.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
                                    

    </body>
</html>

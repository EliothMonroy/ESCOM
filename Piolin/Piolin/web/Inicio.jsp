<%@page import="Logica.Hashtag"%>
<%@page import="Logica.Inicio_L"%>
<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page session='true' %>
<%@page contentType="text/html" pageEncoding="UTF-8" import="bd.cConexion"%>
<!DOCTYPE html>
<html>
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <title>Inicio</title>
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">

    </head>
        <body style="background-color: #F2F2F2;">
    <!-- Header -->
                <header id="header" class="header">
                    <%
                        HttpSession sesion = request.getSession();
                        Integer idUsuario = (Integer) sesion.getAttribute("idUsuario");
                        //int id= Integer.parseInt(idUsuario);
                        Inicio_L inicio = new Inicio_L();
                        String n1 = inicio.name(idUsuario);
                    %>
                </header>

    <!--barra de navegacion-->
    <nav role="navigation" style=" background-color:#5AAFE6">
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

            <div class="col-sm-3 col-md-3">
                <form class="navbar-form" action="Busqueda.jsp" method="get">
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
                <li><a class="button1" href="Perfil.jsp"><%=n1%></a></li>
                <li><a class="button1" href="Salir">Cerrar sesion</a></li>
                <li><img src="<%=inicio.imagen(idUsuario)%>" width="40" height="40" alt="Logo" class="imagen-container-perfil"></li>
            </ul>
        </div><!-- /.navbar-collapse -->
    </nav>
    
            <br>
            <div class="inicio-container">
                
                <!-- contenedor de topicos-->
                <div class="topicos-container" style="background-color:#CEE3F6;"> 
                    <p style="font-size: 20px">Trending Topics</p>
                    <ul class="list-group">
                        <%
                            ResultSet h;
                            Hashtag has=new Hashtag();
                            h=has.obtenerTT();
                            if(h.first()){
                                do{
                        %>
                        <li class="list-group-item"  style="background-color:seashell;"><%=has.hasHashtag(h.getString("hashtag"))%></li>
                        <%
                                }while(h.next());
                            }
                        %>
                    </ul>
                </div>
                    <!-- contenedor de tweets-->
                    <div class="tweets-container" style="display:inline-block">
                        <%
                        ResultSet r,rs;
                        int i=0; //contador 
                            try {
                                
                                r = inicio.con(idUsuario);
                                //rs= inicio.con1(idUsuario);
                                if (r.first()) {
                                    do {
                                        int id = Integer.parseInt(r.getString(2));
                                        int minu = Integer.parseInt(r.getString(4));
                                        int idTweet= r.getInt((1));
                                        String fecha = inicio.fecha(minu);
                                        String contenido=r.getString(3);
                                        contenido=has.hasHashtag(contenido);                   
                        %>
                        <div style="margin-left:12%;width:90%;"> 
                        <pre style="background-color:white;">   
                        <form method="post" action="reeTweet.jsp">
                        <img src="<%=inicio.imagen(id)%>" alt="Logo" class="imagen-container-inicio">    
                                <a href="Perfil.jsp?id=<%=id%>" class="btn-link" style="color: #5AAFE6;font-size: 20px; float: left; margin-left: 5%;"><%=inicio.name(id)%>:</a><p style="font-size: 20px; margin-left: 5%;" id="parrafo<%=i%>">  <%=contenido%></p>
                                <a style="color: grey;float:left; margin-left: 5%;">Hace: <%=fecha%></a>                              
                                <button name="idTweet" value="<%=idTweet%>" type="submit"  class="btn btn-info" style="float:right;margin-left: 2%;margin-bottom: 5%">Repiolin   <span class="glyphicon glyphicon-retweet"></span></button>   
                        </form>
                        <!--<form method="post" action="borrarTweet">
                               <button name="idTweet" value="<%=idTweet%>" type="submit" class="btn btn-alert" style="float:right"><span class="glyphicon glyphicon-remove"></span></button>
                        </form>-->
                        </pre>
                        </div>
                        
                        <br>
                  
                                           
                        <% i++;} while (r.next());              
                        } else {
                        %>
                        <h3 class="alert-info">Parece que aún no sigues a nadie :/, intenta buscando a alguien, para que lo empieces a seguir.</h3>
                        <%
                                }
                            } catch (SQLException e) {
                                System.out.println("" + e.getMessage());
                            }%>
                    </div>
                </div>
                                  
                    
                <!--Popup para twittear-->
                <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  style="display: none;">
                     <div class="modal-dialog">
                         <div class="loginmodal-container-tweet">       
                                <form action="Piot_Ser" method="post">                                
                                    <img src="<%=inicio.imagen(idUsuario)%>" width="80" height="80" alt="Logo" class="imagen-container-perfil-tweet" >
                                    <textarea class="text-container" id="message" name="message" maxlength="140" placeholder="Comparte un pensamiento" required></textarea>
                                    <h5 id='caracteres' >140</h5>          
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
        
        <script>       
            $(function () {
        $('.header').stickyNavbar();
        });        
         </script>
    </body>
</html>

<%-- 
    Document   : busqueda
    Created on : 13/12/2016, 10:14:11 AM
    Author     : GO_HA
--%>

<%@page import="java.sql.SQLException"%>
<%@page import="java.sql.ResultSet"%>
<%@page import="Logica.Inicio_L"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link href="css/bootstrap.min.css" rel="stylesheet">
        <!--<link rel="stylesheet" href="css/Registro.css">-->
        <!--<link rel="stylesheet" href="css/Index.css">-->
         
         
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
                <section id="main-content">
                    <table style="margin: 0 auto;">
                                <tr>
            <td>

            </td>
        </tr>
                
                    <% 
                //Inicio_L inicio=new Inicio_L();
                String usuarioB= request.getParameter("buscar");
                System.out.println(usuarioB);
                ResultSet r=inicio.buscar(usuarioB);
                try{
                    if(r.first()){
                        do{
                       
                      
                        Integer id= Integer.parseInt(r.getString(1));
                        String Nombre= r.getString(3);
                        String nombreUsuario= r.getString(2);
                        String imagen= r.getString(4);
        %>

        
        <tr>
            <td widht="200" style="text-align:  center"><img src="<%=imagen%>" height="150" width="150"  /></td>
            <td><div class="col-lg-1"></div></td>
            <td widht="200" style="text-align:  center"><a href="Perfil.jsp?id=<%=id%>"><p style="font-size: 18px" ><%=nombreUsuario%></p> </a></td>
        </tr>
        <%}while(r.next());
            
                    }else{
                        System.out.println("Esta vacío los resultados"); %>    
                           <tr>
                               <td> No se han encontrado coincidencias con su busqueda   </td> </tr>
                        <%
                    }
                    
                }catch(SQLException e){
                   System.out.println(""+e.getMessage());
                  }%>
               
            
        </table>
                 
       </section>
                  
                  <a href="Inicio.jsp"><button class="btn-primary glyphicon glyphicon-arrow-left"> Volver</button></a>    
        <!--Popup para twittear-->
                <div class="modal fade" id="login-modal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel"  style="display: none;">
                     <div class="modal-dialog">
                         <div class="loginmodal-container-tweet">       
                                <form action="Piot_Ser" method="post">                                
                                    <img src="<%=inicio.imagen(idUsuario)%>" width="80" height="80" alt="Logo" class="imagen-container-perfil-tweet" >
                                    <textarea class="text-container" id="message" name="message"  placeholder="Comparte un pensamiento" required></textarea>
                                    <h5 id='caracteres' >140</h5>          
                                    <button  class="btn btn-info" type="submit" name="login"  value="Piolinazo" style="width:10em;float: right;">
                                        Piolinazo   <span class="glyphicon glyphicon-send"></span>
                                    </button>                                  
                                </form>  
                        </div>
                    </div>
                </div>
        <!--Final del Popup de inicio de sesion-->
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

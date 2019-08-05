<%-- 
    Document   : SeleccionaPerfil
    Created on : 04-dic-2016, 12:17:56
    Author     : Giselle
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="bd.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="viewport" content="width=device-width, initial-scale=1.0"> 
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Selecciona tu Perfil</title>
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
        <section class='section-seleccion-perfil'>
            <div class="container-fixed perfil-seleccion">
                <div class="text-center ">
                    <h1>Selecciona tu Perfil</h1>
                </div>
            </div>
            <div class="container">
            <%
                HttpSession sesion=request.getSession();
                Integer id=(Integer)sesion.getAttribute("idUsuario");
                try{
                    Conexion con=new Conexion();
                    con.conectar();
                    ResultSet r=con.consulta("call perfilesUsuario("+id+")");
                    if(r.first()){
                        do{
                            %>
                            <div class="perfil-container">
                            <!--<div class="row">-->
                                <div class="perfil-container-child">
                                    <form action="MenuCliente.jsp" method="post">
                                        <div class="caption">
                                            <center>                                                
                                                <img src="<%out.print(r.getString("url_imagen"));%>" class='img-container-child'>
                                                <button type="submit" value='<%out.print(r.getInt("idPerfil"));%>' name='perfil' class="btn btn-primary"><%out.print(r.getString("nombre"));%></button>
                                            </center>                                                
                                        </div>
                                    </form>
                                </div>
                           <!-- </div>-->
                            </div>
                            <%
                        }while(r.next());
                    }else{
                        response.sendRedirect("Login.jsp?r=2");
                    }
                    
                }catch(Exception e){
                    System.out.println("Error en SeleccionaPerfil.jsp"+e);
                }
                
                
            %>
                <div class="perfil-container-child">  
                    <form action="EditaPerfil.jsp" method="post">
                        <div class="caption">
                            <center>
                                <button type="submit" value="-1" name="perfil" class="btn"><img src="img/agregar.png" class='img-container-child'></button>                                
                            </center>
                        </div>
                    </form>
                </div>
            </div>
        </section>
        <form action="EditaPerfil.jsp" method="post">         
            <div class="btn-lel">
                <a href="Login.jsp" class="btn btn-info" role="button">Regresar</a>
                    <button type="submit" class="btn btn-danger">Editar Perfiles</button>               
            </div>
        </form>
    </body>
</html>
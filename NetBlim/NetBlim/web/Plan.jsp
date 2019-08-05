<%-- 
    Document   : Plan
    Created on : 29/11/2016, 09:31:46 PM
    Author     :
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <!-- Como casi nunca tenemos internet en la escuela, mejor descargue bootstrap-->
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Escoge tu plan</title>
    </head>
    <body>
        <%
            HttpSession sesion=request.getSession();
            String correo=(String)sesion.getAttribute("email");
            if(correo==null){
                response.sendRedirect("Registro.jsp");
            }
        %>
        <!--Header vacio porque queremos que el usuario siga el proceso-->
        <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="30" aria-valuemin="0" aria-valuemax="100" style="width:30%">
              30%
            </div>
        </div>
        <header></header>
        <div class="container container-margin">
            <div class="page-header text-center">
                <h1>Selecciona tu plan
                    <small><br><a class="btn btn-sm" href="Registro.jsp" role="button">Volver al paso anterior</a></small>
                </h1>
            </div>
            <div class="text-right">Paso 2 de 4</div>
        </div>
        <!--Formulario de Registro  / escoger plan-->
        <%
            //out.println("<h1>"+sesion.getAttribute("email")+"</h1>");
            
        %>
        <div class="container">
            <!--Lista de planes-->
                <ul class="list-group list-inline">
                    <!--Plan 1-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Registro" method="POST" role="form">
                                <legend class="text-center"><button type="submit" name="formulario" value="plan1" class="btn btn-primary margin-btn">PLAN 1</button></legend>
                                <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">$99.9</li>
                                    <li class="list-group-item">2 dispositivos</li>
                                    <li class="list-group-item">HD NO disponible</li>
                                    </center>
                                </ol>
                                
                            </form>
                        </li>
                    </div>
                    <!--Plan 2-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Registro" method="POST" role="form">
                                <legend class="text-center"><button type="submit" name="formulario" value="plan2" class="btn btn-primary margin-btn">PLAN 2</button></legend>
                                <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">$110</li>
                                    <li class="list-group-item">3 dispositivos</li>
                                    <li class="list-group-item">HD disponible</li>
                                    </center>
                                </ol>
                                
                            </form>
                        </li>
                    </div>
                    <!--Plan 3-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4">
                        <li class="list-group-item shadow">
                            <form action="Registro" method="POST" role="form">
                                <legend class="text-center"><button type="submit" name="formulario" value="plan3" class="btn btn-primary margin-btn">PLAN 3</button></legend>
                                <ol class="list-group">
                                    <center>
                                    <li class="list-group-item">$120</li>
                                    <li class="list-group-item">5 dispositivos</li>
                                    <li class="list-group-item">HD disponible</li>
                                    </center>
                                </ol>
                                
                            </form>
                        </li>
                    </div>
                </ul>
            </div>
         </div>
         <!--Fin formulario registro/ escoger plan-->
         <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>

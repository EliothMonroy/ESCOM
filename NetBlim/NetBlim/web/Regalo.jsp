<%-- 
    Document   : Regalo
    Created on : 2/12/2016, 03:53:43 PM
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
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Datos tarjeta</title>
    </head>
    <body>
        <%
            HttpSession sesion=request.getSession();
            Integer plan=(Integer)sesion.getAttribute("plan");
            if(plan==null){
                response.sendRedirect("Registro.jsp");
            }
        %>
        <!--Header chido -->
        <!--<header>
            <a href="/NetBlim"><img src="img/netblim.png" class="img-responsive" alt="Logo" width="200" height="200"></a>
        </header>-->
        <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="85" aria-valuemin="0" aria-valuemax="100" style="width:85%">
              85%
            </div>
        </div>
        
        <div class="container container-margin">
            <div class="page-header text-center">
                    <h1>Escribe la info de tu tarjeta
                        <small><br><a class="btn btn-sm" href="MetodoPago.jsp" role="button">Volver al paso anterior</a></small>
                    </h1>
            </div>
             <div class="text-right">Paso 4 de 4</div>
        </div>
       
         <!--Formulario de Login-->
         <div class="container">
             <div class="row">
                <div class="col-xs-3"></div>
                <div class="col-xs-6">
                    <form action="Registro" method="post" role="form">
                       <legend class="legend-lel"></legend>
                       <div class="form-group">
                           <label for="num">Número de tarjeta:</label>
                           <input type="text" class="form-control" id="" name="" placeholder="1234567" required>
                           <label for="num">Saldo:</label>
                           <input type="number" class="form-control" id="" name="saldo" placeholder="1234567" required>
                       </div>
                       <button type="submit" value='finalRegalo' name='formulario' class="btn btn-primary">Dale!</button>
                   </form>
                </div>
                <div class="col-xs-3"></div>   
             </div>
         </div>
         <!--Fin formulario pedir datos--> 
        
        
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>
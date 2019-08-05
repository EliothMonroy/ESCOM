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
        <title>Selecciona tu metodo de pago</title>
    </head>
    <body>
        <!--Header vacio porque queremos que el usuario siga el proceso-->
        <div class="progress">
            <div class="progress-bar" role="progressbar" aria-valuenow="70" aria-valuemin="0" aria-valuemax="100" style="width:70%">
              70%
            </div>
        </div>
        <header></header>
        
        <div class="container container-margin">
            <div class="page-header text-center">
                <h1>Selecciona tu Método de pago
                    <small><br><a class="btn btn-sm" href="Plan.jsp" role="button">Volver al paso anterior</a></small>
                </h1>
            </div>
            <div class="text-right">Paso 3 de 4</div>
        </div>
        <%
            HttpSession sesion=request.getSession();
            Integer plan=(Integer)sesion.getAttribute("plan");
            if(plan==null){
                response.sendRedirect("Registro.jsp");
            }
        %>
        <!--Formulario de Registro  / escoger metodo de pago-->
        <div class="container">
            <!--Lista de metodos de pago-->
                <ul class="list-group list-inline">
                    <!--Plan Credito-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 text-center">
                        <li class="list-group-item shadow li-padding">
                            <form action="Registro" method="POST" role="form">
                                <legend>Tarjeta de Crédito</legend>
                                <button type="submit" name="formulario" value="pagoCredito" class="btn btn-primary">
                                    <img src="img/credito.png" class="img-responsive img-height" alt="Tarjeta de credito" width="100" height="100">
                                </button>
                            </form>
                        </li>
                    </div>
                    <!--Pago Debito-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 text-center">
                        <li class="list-group-item shadow li-padding">
                            <form action="Registro" method="POST" role="form">
                                <legend>Tarjeta de Débito</legend>
                                <button type="submit" name="formulario" value="pagoDebito" class="btn btn-primary">
                                    <img src="img/debito.png" class="img-responsive img-height" alt="Tarjeta de debito" width="100" height="200">
                                </button>
                            </form>
                        </li>
                    </div>
                    <!--Pago Regalo-->
                    <div class="col-xs-4 col-sm-4 col-md-4 col-lg-4 text-center">
                        <li class="list-group-item shadow li-padding">
                            <form action="Registro" method="POST" role="form">
                                <legend>Tarjeta de Regalo</legend>
                                <button type="submit" name="formulario" value="pagoRegalo" class="btn btn-primary">
                                    <img src="img/gift.ico" class="img-responsive img-height" alt="Tarjeta de regalo" width="100" height="100">
                                </button>
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

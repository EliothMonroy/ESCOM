<%-- 
    Document   : AgregaPelicula
    Created on : 04-dic-2016, 19:27:45
    Author     : usuario
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <link rel="stylesheet" href="css/bootstrap.css">
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>JSP Page</title>
    </head>
    <body>
        <div>
             <div class="row">
                 <div class="col-xs-1"></div>
                 <div class="col-xs-10">
                     <form action="Login" method="post" role="form">
                        <legend></legend>
                        <div class="form-group">
                            <label for="NombreDirector">Nombre del Director:</label>
                            <input type="text" class="form-control input-lg" id="NombreDirector" name="NombreDirector" placeholder="Ingresa el nombre del Director" required>
                        </div>
                        <div class="form-group">
                            <label for="NombreActor">Nombre del Actor:</label>
                            <input type="text" class="form-control input-lg" id="NombreActor" name="NombreActor" placeholder="Ingresa el nombre del  Actor" required>
                        </div>
                        
                        <button type="submit" class="btn btn-primary">Dale!</button>
                    </form>
                 </div>
                 <div class="col-xs-1"></div>
             </div>
         </div>
        
        <script src="js/jquery.js"></script>
        <script src="js/bootstrap.js"></script>
    </body>
</html>

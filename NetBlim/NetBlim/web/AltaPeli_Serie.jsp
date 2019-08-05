<%-- 
    Document   : AltaPeli_Serie
    Created on : 04-dic-2016, 20:10:30
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
        <h1>Alta de Pelicula / Serie</h1>
        <div>
             <div class="row">
                 <div class="col-xs-1"></div>
                 <div class="col-xs-10">
                     <form action="Login" method="post" role="form">
                        <legend></legend>
                        <div class="form-group">
                            <label for="Nombre">Nombre:</label>
                            <input type="text" class="form-control input-lg" id="Nombre" name="Nombre" placeholder="Ingresa el nombre de la Pelicula o Serie" required>
                        </div>
                        <div class="form-group">
                            <label for="Anio">Año:</label>
                            <input type="text" class="form-control input-lg" id="Anio" name="Anio" placeholder="Ingresa el año de estreno" required>
                        </div>
                        <div class="form-group">
                            <label for="Url">Url:</label>
                            <input type="text" class="form-control input-lg" id="Url" name="Url" placeholder="Ingresa el URL de la foto de portada" required>
                        </div>
                        <div class="form-group">
                            <label for="Descripcion">Descripcion:</label>
                            <input type="text" class="form-control input-lg" id="Descripcion" name="Descripcion" placeholder="Ingresa una descripciòn" required>
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

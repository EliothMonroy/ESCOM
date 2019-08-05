<%-- 
    Document   : cambiarImagen
    Created on : 3/12/2016, 05:12:38 PM
    Author     : Daniel
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>JSP Page</title>
    </head>
    <body>
        <h1 > Por favor escriba su nuevo nombre de usuario </h1>
        <p><strong>Maximo 20 caracteres</strong></p>
        <div id="divform"  style="text-align:center">
          <form method="post" action="cambiarNombre"  style="text-align: center">      
                        Nuevo Nombre de Usuario:
                    <input type="text" name="txtcorreo" style="width:300px"/>
                    <input type="submit" value="Subir"/>
           </form>
        </div>
    </body>
</html>
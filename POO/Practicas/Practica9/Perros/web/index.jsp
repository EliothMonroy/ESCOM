<%-- 
    Document   : index
    Created on : 16/11/2016, 08:26:28 PM
    Author     : ELITH
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Perritos</title>
    </head>
    <body>
        <header>
            <h1>Por favor ingrese su consulta</h1>
        </header>
        <style>
            body{
                text-align: center;
            }
        </style>
        <form method="post" action="Perros">
            <%
                if(request.getParameter("r")==null){
                    out.println("<input type='text' name='consulta' placeholder='select * from perro;' required/>");
                }else{
                    out.println("<input type='text' name='consulta' value='"+request.getParameter("r")+"' placeholder='select * from perro;' required/>");
                }
            %>
            <input type="submit" value="Enviar" name="enviar" />
        </form>
    </body>
</html>

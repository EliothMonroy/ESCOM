<%-- 
    Document   : VistaPelicula
    Created on : 06-dic-2016, 16:31:16
    Author     : Giselle
--%>

<%@page import="java.sql.ResultSet"%>
<%@page import="bd.Conexion"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
  <head>
        <!-- Theme Made By www.w3schools.com - No Copyright -->
        <title>Bootstrap Theme Simply Me</title>
        <meta charset="utf-8">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/css/bootstrap.min.css">
        <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.1/jquery.min.js"></script>
        <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
        <style>
        .bg-1 { 
            background-color: #1abc9c; /* Green */
            color: #ffffff;
        }
        .bg-2 { 
            background-color: #474e5d; /* Dark Blue */
            color: #ffffff;
        }
        .bg-3 { 
            background-color: #fff; /* White */
            color: #555555;
        }
        </style>
</head>
<body>
    <div class="container-fluid bg-1 text-center">
      <img src="img/avatar.png" width="350" height="350">
    </div>
    <%
        String id=request.getParameter("idPeli_Serie");//Para probarlo comentar esta linea y mandar un id directo a los procedures
        try{
        Conexion con=new Conexion();
            con.conectar();
            ResultSet r=con.consulta("call Info_PeliSerie('"+id+"');");//procedure para obtener informacion de la peli_serie
            ResultSet r2=con.consulta("call Info_DireActor('"+id+"');");//procedure para obtener informacion de los directores y actores
            if(r.first()){
                String nombre=r.getString("nombre");//checar el nombre de las variables que coloque 
                String anio=r.getString("anio");//String duracion=r.getString("duracion");
                float valoracion=r.getFloat("valoracion");//Get float
                String sinopsis=r.getString("descripcion");
                String prod=r2.getString("dire_actor.nombre");//String actores=r2.getString("nombreAct");
              

                        %>
                        <div class="container-fluid bg-2 text-center">
      <h3>Nombre:<% out.print(nombre); %></h3>
      <h3>Año:<% out.print(anio); %></h3>
      <h3>Valoracion:<% out.print(valoracion); %></h3>
      <h3>Sinopsis:<% out.print(sinopsis); %></h3>
      <h3>Produccion:<% out.print(prod); %></h3>
      <h3>Añadir a Mi Lista</h3>
      <div class="perfil-container-child">  
        <center>
            <div class="btn-lel">
                <img src="img/agregar.png" class='btn' role="button"  width="60" height="50">
                <%
                    //ResultSet r3=con.consulta("call Alta_Usuario('"+id+"','"+nombre+"');");//solo es un ejemplo, aqui debe de ir el procedure para agregar una peli_serie por medio de su ID
                %>
            </div>
        </center>
      </div>
    </div>
                        <%
            }else{
                        response.sendRedirect("MenuCliente.jsp?r=Error extraño");
            }                    
        }catch(Exception e){
                    System.out.println("Error: "+e);
        }
    %>
    
    
    
</body>
        <div class="container">
            <a href="MenuCliente.jsp" class="btn btn-info" role="button">Regresar</a>
        </div>
    
    
    
    
    
</html>

<%-- 
    Document   : Peliculas
    Created on : 06-dic-2016, 15:15:21
--%>

<%@page import="logica.Pelicula"%>
<%@page import="java.sql.ResultSet"%>
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
        <title>Menu Cliente</title>
       <style>
       /* Set height of the grid so .sidenav can be 100% (adjust as needed) */
       .row.content {height: 550px}
       /* Set gray background color and 100% height */
      .sidenav {
        background-color: #000000;
        height: 1000%;
     }
      /* On small screens, set height to 'auto' for the grid */
        @media screen and (max-width: 767px) {
      .row.content {height: auto;}  
    }
      </style>
</head>
   <body style="background-color: #042B54">
     
    <nav class="navbar navbar-inverse visible-xs">
    <div class="container-fluid">
    <div class="navbar-header">
      <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#myNavbar">
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>                        
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
        <span class="icon-bar"></span>
      </button>

      <a class="navbar-brand" href="#"> <a href="/NetBlim" class="header-logo header-logo-fixed">NETBLIM</a></a>
    </div>
    <div class="collapse navbar-collapse" id="myNavbar">
      <ul class="nav navbar-nav">
        <li class="active"><a href="SeleccionaPerfil.jsp">Perfil</a></li>
        <br><li color='white'>Lista de Géneros</li></br>
        <li><a href="cf.jsp">Ciencia Ficcion</a></li>
        <li><a href="#">Aventura</a></li>
        <li><a href="#">Romanticas</a></li>
        <li><a href="#">Comedia</a></li>
        <li><a href="#">Terror</a></li>
        <li><a href="#">Clasicas</a></li>
        <li><a href="#">Accion</a></li>
      </ul>
    </div>
  </div>
</nav>

<div class="container-fluid">
  <div class="row content">
    <div class="col-sm-3 sidenav hidden-xs">
        <br><a href="/NetBlim" class="header-logo header-logo-fixed">NETBLIM</a></br>
      <ul class="nav nav-pills nav-stacked">
          <br><li class="active"><a href="SeleccionaPerfil.jsp">Perfil</a></li></br>
        <br><li color='white'>Lista de Géneros</li></br>
        <li><a href="cf.jsp" >Ciencia Ficcion</a></li>
        <li><a href="aventura.jsp">Aventura</a></li>
        <li><a href="romance.jsp">Romanticas</a></li>
        <li><a href="comedia.jsp">Comedia</a></li>
        <li><a href="terror.jsp">Terror</a></li>
        <li><a href="clasicas.jsp">Clasicas</a></li>
        <li><a href="accion.jsp">Accion</a></li>
        <br><br><br><a href="/NetBlim" class="header-logo header-logo-fixed"><img src="img/cerrarsesion.jpg" class="img-responsive" alt="CF" width="80" height="80"></a></br></br></br>

      </ul>
    </div> 
        <div class="col-sm-9">
      <nav class="navbar navbar-inverse">
       <div class="container-fluid">
        <div class="navbar-header">
          <a class="navbar-brand" href="MenuCliente.jsp">NetBlim</a>
        </div>
        <ul class="nav navbar-nav">
          <li><a href="Peliculas.jsp">Películas</a></li>
          <li><a href="Series.jsp">Series</a></li>
        </ul>
     <form method="post" action="ConsultaGeneral.jsp" class="navbar-form navbar-left">
           <div class="input-group">
             <input name="buscar" type="text" class="form-control" placeholder="Search">
               <div class="input-group-btn">
                <button class="btn btn-default" type="submit">
                    <i class="glyphicon glyphicon-search"></i>
                 </button>
              </div>
           </div>
        </form>
      </div><%--fin container fluid--%>
      </nav><%--fin navbar--%>
  <%ResultSet rs=null;
      Pelicula peli = new Pelicula();
     try{
          rs=peli.Peliculas();
     
     }catch(Exception e ){
         System.out.println("Error DB"+e);
     }
	  int count=0;
 	  out.println(" <div class='row'>");
 	while(rs.next())
 	{ 
  	if (count!= 37) {
   	out.println("<div width=132 height=202 class='col-sm-3'>"
           + " <div class='panel-body' color:#000000><a href='InfoPelil.jsp?idSesion="+rs.getString("idPeli_serie")+"''><img src='img/Images/"+rs.getString("url_imagen")+"' class='img-responsive' alt='Image'></a></div>"
           + "</div>");
    
 
    }else {
     out.println("'</div>"
             + "<div class='row'>");
       
      
       count=0;
    }
    count++;
  }
 peli.close();
%>
    </div><%--fin column 9--%>
  </div><%--fin row content--%>
</div><%--fin container fluid--%>
</body>
</html>

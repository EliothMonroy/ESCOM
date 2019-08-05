<%-- 
    Document   : Inicio
    Created on : 2/12/2016, 01:44:57 PM
    Author     :
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
        <link rel="stylesheet" href="css/estilos_generales.css" >
        <link rel="stylesheet" href="css/styles.css">
        <link rel="stylesheet" href="css/index-styles.css" >
        <title>Edita tu Perfil</title>
    </head>
    <body>
        <!--Header chido -->
        <header>
            <nav class="navbar navbar-fixed-top bar-fixed">
                <div class="container-fluid">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <div class="navbar-header">
                                <a href="/NetBlim"><img src="img/netblim.png" class="img-responsive" alt="Logo" width="200" height="200"></a>
                            </div>
                        </li>
                    </ul>
                </div>
            </nav>
        </header>
        <!--Fin header -->
        
        <div class="container-fixed">
            <div class="text-center ">
                <h1>Edita tu Perfil</h1>
            </div>
            <%
                if(request.getParameter("r")!=null){
                    out.println(request.getParameter("r"));
                }            
            %>
        </div>        
        <!--Formulario de Edita tu Perfil-->
         <div>
             <div class="row">
                 <div class="col-xs-1"></div>
                 <div class="col-xs-10">
                     
                        <%
                            HttpSession sesion=request.getSession();
                            if(sesion.getAttribute("primeraVez")!=null){
                                if((Integer)sesion.getAttribute("primeraVez")==1){
                                    %>
                                    <form action="EditarPerfil" method="post" role="form" enctype="multipart/form-data">
                                        <legend>Crea tu primer perfil</legend>

                                        <div class="caption">
                                            <center>
                                            <img src="img/avatar.png" style="width:18%">
                                            <input type="file" name="foto" value="Imagen">
                                            </center>
                                        </div>

                                        <div class="form-group">
                                            <label for="nombre">Ingresa tu nombre:</label>
                                            <input type="text" class="form-control input-lg" id="nombre" name="nombre" placeholder="NetBlim" required>
                                        </div>

                                        <div class="checkbox">
                                            <label><input type="checkbox" name="control" value="Control"> Control Parental</label>
                                        </div>
                                        <div class="container">
                                            <a href="Login.jsp" class="btn btn-info" role="button">Regresar</a>
                                            <input type="submit" value="Comenzar" name="boton" class="btn btn-success">
                                        </div>
                                    </form>
                                    <%
                                }else if((Integer)sesion.getAttribute("primeraVez")==0){
                                    System.out.println("No es la primera vez que entra el usuario");
                                    //Como no es primera vez pues checamos que onda
                                    Integer id=(Integer)sesion.getAttribute("idUsuario");
                                    String perfil=request.getParameter("perfil");
                                    if(perfil==null){
                                        System.out.println("Perfil es nulo");
                                        try{
                                        Conexion con=new Conexion();
                                        con.conectar();
                                        ResultSet r=con.consulta("call perfilesUsuario("+id+");");
                                        if(r.first()){
                                            do{
                                                %>
                                                <div class="perfil-container">
                                                <!--<div class="row">-->
                                                    <div class="perfil-container-child">
                                                        <form action="EditaPerfil.jsp" method="post">
                                                            <div class="caption">
                                                                <center>                                                
                                                                    <img src="<%out.print(r.getString("url_imagen"));%>" class='img-container-child'>
                                                                    <button type="submit" value='<%out.print(r.getInt("idPerfil"));%>' name='perfil' class="btn btn-primary">Editar a: <%out.print(r.getString("nombre"));%></button>
                                                                </center>                                                
                                                            </div>
                                                        </form>
                                                    </div>
                                               <!-- </div>-->
                                                </div>
                                                <%
                                            }while(r.next());
                                            %>
                                            <div class="container">
                                                <a href="SeleccionaPerfil.jsp" class="btn btn-info" role="button">Regresar</a>            
                                            </div>
                                            <%
                                        }else{
                                            response.sendRedirect("Login.jsp?r=2");
                                        }

                                        }catch(Exception e){
                                            System.out.println("Error en EditarPerfil.jsp"+e);
                                        }
                                    }else{//Perfil no es nulo, entonces
                                        System.out.println("Perfil no es nulo");
                                        if(perfil.equals("-1")){
                                            //Vamos a añadir un nuevo perfil
                                            System.out.println("Queremos añadir un nuevo perfil");
                                            %>
                                            <form action="EditarPerfil" method="post" role="form" enctype="multipart/form-data">
                                                <legend>Crea un nuevo perfil</legend>

                                                <div class="caption">
                                                    <center>
                                                    <img src="img/avatar.png" style="width:18%">
                                                    <input type="file" name="foto" value="Imagen">
                                                    </center>
                                                </div>

                                                <div class="form-group">
                                                    <label for="nombre">Ingresa el nombre:</label>
                                                    <input type="text" class="form-control input-lg" id="nombre" name="nombre" placeholder="NetBlim" required>
                                                </div>

                                                <div class="checkbox">
                                                    <label><input type="checkbox" name="control" value="Control"> Control Parental</label>
                                                </div>
                                                <div class="container">
                                                    <a href="SeleccionaPerfil.jsp" class="btn btn-info" role="button">Regresar</a>
                                                    <input type="submit" value="Guardar" name="boton" class="btn btn-success">
                                                </div>
                                            </form>
                                            <%
                                        }else{
                                            //Vamos editar un perfil
                                            System.out.println("Queremos editar un perfil en especifico");
                                            
                                            try{
                                                Conexion con=new Conexion();
                                                con.conectar();
                                                ResultSet r=con.consulta("call infoPerfil("+Integer.parseInt(perfil)+");");
                                                if(r.first()){
                                                    %>
                                                    <form action="EditarPerfil" method="post" role="form" enctype="multipart/form-data">
                                                        <legend>Editar Perfil</legend>

                                                        <div class="caption">
                                                            <center>
                                                                <img src="<%out.println(r.getString("imagen"));%>" style="width:18%">
                                                            <input type="file" name="foto" value="Imagen">
                                                            </center>
                                                        </div>

                                                        <div class="form-group">
                                                            <label for="nombre">Ingresa el nombre:</label>
                                                            <input type="text" class="form-control input-lg" value="<%out.println(r.getString("nombre"));%>" id="nombre" name="nombre" placeholder="NetBlim" required>
                                                        </div>

                                                        <div class="checkbox">
                                                            <label><input type="checkbox" name="control" value="Control"> Control Parental</label>
                                                        </div>
                                                        <div class="container">
                                                            <a href="SeleccionaPerfil.jsp" class="btn btn-info" role="button">Regresar</a>
                                                            <button type="submit" name='boton' class="btn btn-success" value="<%out.print(perfil);%>">Editar</button>
                                                        </div>
                                                    </form>
                                                <%
                                                }else{
                                                   System.out.println("Error base");
                                                }
                                                
                                            }catch(Exception e){
                                                System.out.println("Error en la base:"+e);
                                            }
                                            
                                        }
                                        
                                    }
                            }else{
                                System.out.println("Error en EditaPerfil.jsp, la variable de sesion primera vez no esta defninida");
                                response.sendRedirect("/NetBlim");
                            }  
                            } 
                        %>
                        
                 </div>
                 <div class="col-xs-1"></div>
             </div>
         </div>
         <!--Fin formulario login-->        
            
        
        <!-- jQuery (necessary for Bootstrap's JavaScript plugins) -->
        <script src="js/jquery.js"></script>
        <!-- JS de bootstrap -->
        <script src="js/bootstrap.js"></script>
    </body>
</html>

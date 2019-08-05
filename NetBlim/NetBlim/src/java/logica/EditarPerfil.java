/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import bd.Conexion;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.servlet.http.Part;

/**
 *
 * @author eliot
 */
@WebServlet(name = "EditarPerfil", urlPatterns = {"/EditarPerfil"})
@MultipartConfig
public class EditarPerfil extends HttpServlet {
    private final static Logger LOGGER = Logger.getLogger(Registro.class.getCanonicalName());
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //Aquí ustedes tienen que poner la dirección de la carpeta que aplique para su compu, aún no he logrado hacer una path relativa
        final String path = "C:\\Users\\arhel\\Documents\\GitHub\\NetBlim\\NetBlim\\web\\Imagenes-Usuarios";
        final String folder="Imagenes-Usuarios/";
        //Cachamos toda la info del formulario
        final String nombre=request.getParameter("nombre");
        final String boton=request.getParameter("boton");
        HttpSession sesion=request.getSession();
        final Integer idUsuario=(Integer)sesion.getAttribute("idUsuario");
        final String[] control = request.getParameterValues("control");
        int parental; 
        if(control==null){
            parental=0;
        }else{
            parental=1;
        }
        if(boton.equals("Comenzar")){
            //Aquí obtenemos el input file y su nombre
           final Part filePart = request.getPart("foto");
           //Obtenemos el nombre del archivo
           String fileName = getFileName(filePart);
           //A continuación procedemos a ver cual es la extensión del archivo, y verificamos que sea una extensión valida
           boolean valida=false;
           fileName=fileName.toLowerCase();
           if(fileName.endsWith(".jpg")){
               fileName=idUsuario+".jpg";
               valida=true;
           }if(fileName.endsWith(".png")){
               fileName=idUsuario+".png";
               valida=true;
           }if(fileName.endsWith(".ico")){
               fileName=idUsuario+".ico";
               valida=true;
           }if(fileName.endsWith(".gif")){
               fileName=idUsuario+".gif";
               valida=true;
           }
           System.out.println("File name: "+fileName);
           if(valida==false && !(fileName.equals(""))){
               System.out.println("El archivo no tiene extension valida");
               response.sendRedirect("EditaPerfil.jsp?r=Archivo de imagen no valido");
           }else{
               if(!(fileName.equals(""))){
                   //Si es un archivo valido
                   //Flujos para escribir y recibir el archivo    
                   OutputStream out = null;
                   InputStream filecontent = null;  
                   //Nos conectamos a la base para checar que el usuario existe o no.
                   try{
                       Conexion con=new Conexion();
                       con.conectar();
                       ResultSet r2=con.consulta("call proximoIdPerfil;");
                       if(r2.first()){
                           System.out.println("Obtuve el id");
                           fileName="i"+r2.getInt("msj")+"perfil"+fileName;
                       }else{
                           response.sendRedirect("EditaPerfil.jsp?r=Algo extraño paso");
                       }
                       ResultSet r=con.consulta("call Alta_Perfil("+idUsuario+",'"+folder+fileName+"','"+nombre+"',"+parental+");");
                       //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                       if(r.first()){
                           if(r.getInt("msj")==1){
                               //Aquí guardamos la imagen
                               out = new FileOutputStream(new File(path + File.separator + fileName));
                               filecontent = filePart.getInputStream();

                               int read = 0;
                               final byte[] bytes = new byte[1024];

                               //Aquí escribimos el contenido del archivo
                               while ((read = filecontent.read(bytes)) != -1) {
                                   out.write(bytes, 0, read);
                               }
                               sesion.setAttribute("primeraVez",0);
                               response.sendRedirect("SeleccionaPerfil.jsp");
                           }else{
                               response.sendRedirect("Login.jsp?r=2");
                           }
                       }else{
                           response.sendRedirect("Login.jsp?r=2");
                       }

                   } catch (SQLException ex) {
                       System.out.println("Error con la base: "+ex);
                       response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                   }
               }else{
                   //Si es un archivo valido
                   //Flujos para escribir y recibir el archivo    
                   OutputStream out = null;
                   InputStream filecontent = null;
                   fileName="avatar.png";
                   //Nos conectamos a la base para checar que el usuario existe o no.
                   try{
                       Conexion con=new Conexion();
                       con.conectar();
                       ResultSet r=con.consulta("call Alta_Perfil("+idUsuario+",'"+folder+fileName+"','"+nombre+"',"+parental+");");
                       //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                       if(r.first()){
                           if(r.getInt("msj")==1){                            
                               response.sendRedirect("SeleccionaPerfil.jsp");
                           }else{
                               response.sendRedirect("Login.jsp?r=2");
                           }
                       }else{
                           response.sendRedirect("Login.jsp?r=2");
                       }

                   } catch (SQLException ex) {
                       System.out.println("Error con la base: "+ex);
                       response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                   }
               }       
           }
        }else if(boton.equals("Guardar")){//Vamos a guardar un nuevo perfil
             //Aquí obtenemos el input file y su nombre
            final Part filePart = request.getPart("foto");
            //Obtenemos el nombre del archivo
            String fileName = getFileName(filePart);
            //A continuación procedemos a ver cual es la extensión del archivo, y verificamos que sea una extensión valida
            boolean valida=false;
            fileName=fileName.toLowerCase();
            if(fileName.endsWith(".jpg")){
                fileName=idUsuario+".jpg";
                valida=true;
            }if(fileName.endsWith(".png")){
                fileName=idUsuario+".png";
                valida=true;
            }if(fileName.endsWith(".ico")){
                fileName=idUsuario+".ico";
                valida=true;
            }if(fileName.endsWith(".gif")){
                fileName=idUsuario+".gif";
                valida=true;
            }
            System.out.println("File name: "+fileName);
            if(valida==false && !(fileName.equals(""))){
                System.out.println("El archivo no tiene extension valida");
                response.sendRedirect("EditaPerfil.jsp?r=Archivo de imagen no valido");
            }else{
                if(!(fileName.equals(""))){
                    //Si es un archivo valido
                    //Flujos para escribir y recibir el archivo    
                    OutputStream out = null;
                    InputStream filecontent = null;  
                    //Nos conectamos a la base para checar que el usuario existe o no.
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r2=con.consulta("call proximoIdPerfil;");
                        if(r2.first()){
                            System.out.println("Obtuve el id");
                            fileName="i"+r2.getInt("msj")+"perfil"+fileName;
                        }else{
                            response.sendRedirect("EditaPerfil.jsp?r=Algo extraño paso");
                        }
                        ResultSet r=con.consulta("call Alta_Perfil("+idUsuario+",'"+folder+fileName+"','"+nombre+"',"+parental+");");
                        //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                        if(r.first()){
                            if(r.getInt("msj")==1){
                                //Aquí guardamos la imagen
                                out = new FileOutputStream(new File(path + File.separator + fileName));
                                filecontent = filePart.getInputStream();

                                int read = 0;
                                final byte[] bytes = new byte[1024];

                                //Aquí escribimos el contenido del archivo
                                while ((read = filecontent.read(bytes)) != -1) {
                                    out.write(bytes, 0, read);
                                }
                                response.sendRedirect("SeleccionaPerfil.jsp");
                            }else{
                                response.sendRedirect("Login.jsp?r=2");
                            }
                        }else{
                            response.sendRedirect("Login.jsp?r=2");
                        }

                    } catch (SQLException ex) {
                        System.out.println("Error con la base: "+ex);
                        response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                    }
                }else{
                    //Si es un archivo valido
                    //Flujos para escribir y recibir el archivo    
                    OutputStream out = null;
                    InputStream filecontent = null;
                    fileName="avatar.png";
                    //Nos conectamos a la base para checar que el usuario existe o no.
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r=con.consulta("call Alta_Perfil("+idUsuario+",'"+folder+fileName+"','"+nombre+"',"+parental+");");
                        //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                        if(r.first()){
                            if(r.getInt("msj")==1){                            
                                response.sendRedirect("SeleccionaPerfil.jsp");
                            }else{
                                response.sendRedirect("Login.jsp?r=2");
                            }
                        }else{
                            response.sendRedirect("Login.jsp?r=2");
                        }

                    } catch (SQLException ex) {
                        System.out.println("Error con la base: "+ex);
                        response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                    }
                }       
            }
        }else{
            //Vamos a editar un perfil
             //Aquí obtenemos el input file y su nombre
            final Part filePart = request.getPart("foto");
            //Obtenemos el nombre del archivo
            String fileName = getFileName(filePart);
            //A continuación procedemos a ver cual es la extensión del archivo, y verificamos que sea una extensión valida
            boolean valida=false;
            fileName=fileName.toLowerCase();
            if(fileName.endsWith(".jpg")){
                fileName=idUsuario+".jpg";
                valida=true;
            }if(fileName.endsWith(".png")){
                fileName=idUsuario+".png";
                valida=true;
            }if(fileName.endsWith(".ico")){
                fileName=idUsuario+".ico";
                valida=true;
            }if(fileName.endsWith(".gif")){
                fileName=idUsuario+".gif";
                valida=true;
            }
            System.out.println("File name: "+fileName);
            if(valida==false && !(fileName.equals(""))){
                System.out.println("El archivo no tiene extension valida");
                response.sendRedirect("EditaPerfil.jsp?r=Archivo de imagen no valido");
            }else{
                if(!(fileName.equals(""))){
                    //Si es un archivo valido
                    //Flujos para escribir y recibir el archivo    
                    OutputStream out = null;
                    InputStream filecontent = null;  
                    //Nos conectamos a la base para checar que el usuario existe o no.
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r=con.consulta("call Actualizar_Perfil('',"+Integer.parseInt(request.getParameter("boton"))+",'"+nombre+"',"+parental+");");
                        //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                        if(r.first()){
                            if(!(r.getString("msj").equals(""))){
                                //EL procedure regresa la url de la imagen der archivo
                                fileName=r.getString("msj");
                                String filename[]=fileName.split("/");
                                //Aquí guardamos la imagen
                                out = new FileOutputStream(new File(path + File.separator + filename[1]));
                                filecontent = filePart.getInputStream();
                                int read = 0;
                                final byte[] bytes = new byte[1024];
                                //Aquí escribimos el contenido del archivo
                                while ((read = filecontent.read(bytes)) != -1) {
                                    out.write(bytes, 0, read);
                                }
                                response.sendRedirect("SeleccionaPerfil.jsp");
                            }else{
                                response.sendRedirect("Login.jsp?r=2");
                            }
                        }else{
                            response.sendRedirect("Login.jsp?r=2");
                        }

                    } catch (SQLException ex) {
                        System.out.println("Error con la base: "+ex);
                        response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                    }
                }else{
                    //Si es un archivo valido
                    //Flujos para escribir y recibir el archivo    
                    OutputStream out = null;
                    InputStream filecontent = null;
                    fileName="avatar.png";
                    //Nos conectamos a la base para checar que el usuario existe o no.
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r=con.consulta("call Actualizar_Perfil('Imagenes-Usuarios/avatar.png',"+Integer.parseInt(request.getParameter("boton"))+",'"+nombre+"',"+parental+");");
                        //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                        if(r.first()){
                            if(r.getInt("msj")==1){                            
                                response.sendRedirect("SeleccionaPerfil.jsp");
                            }else{
                                response.sendRedirect("Login.jsp?r=2");
                            }
                        }else{
                            response.sendRedirect("Login.jsp?r=2");
                        }

                    } catch (SQLException ex) {
                        System.out.println("Error con la base: "+ex);
                        response.sendRedirect("EditaPerfil.jsp?r=Hubo un error, intente de nuevo por favor");
                    }
                }       
            }
        }
               
    }
    //Metodo para obtener el nombre del archivo
    private String getFileName(final Part part) {
        final String partHeader = part.getHeader("content-disposition");
        LOGGER.log(Level.INFO, "Part Header = {0}", partHeader);
        for (String content : part.getHeader("content-disposition").split(";")) {
            if (content.trim().startsWith("filename")) {
                return content.substring(
                        content.indexOf('=') + 1).trim().replace("\"", "");
            }
        }
        return null;    
    }

    // <editor-fold defaultstate="collapsed" desc="HttpServlet methods. Click on the + sign on the left to edit the code.">
    /**
     * Handles the HTTP <code>GET</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Handles the HTTP <code>POST</code> method.
     *
     * @param request servlet request
     * @param response servlet response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        processRequest(request, response);
    }

    /**
     * Returns a short description of the servlet.
     *
     * @return a String containing servlet description
     */
    @Override
    public String getServletInfo() {
        return "Short description";
    }// </editor-fold>

}

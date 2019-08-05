/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import bd.cConexion;
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
import javax.servlet.http.Part;

/**
 *
 * @author ANDRES el chido
 */
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
@MultipartConfig
public class Registro extends HttpServlet {
    private final static Logger LOGGER = Logger.getLogger(Registro.class.getCanonicalName());
    /**
     * Processes requests for both HTTP <code>GET</code> and <code>POST</code>
     * methods.
     *
     * @param request
     * @param response
     * @throws ServletException if a servlet-specific error occurs
     * @throws IOException if an I/O error occurs
     */
    protected void processRequest(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {
        response.setContentType("text/html;charset=UTF-8");
        //Aquí ustedes tienen que poner la dirección de la carpeta que aplique para su compu, aún no he logrado hacer una path relativa
        final String path = "C:\\Users\\ANDRES\\Documents\\GitHub\\Piolin\\Piolin\\web\\Imagenes-Usuarios";
        final String folder="Imagenes-Usuarios/";
        //Cachamos toda la info del formulario
        final String nombre=request.getParameter("nombre");
        final String usuario=request.getParameter("user");
        final String correo=request.getParameter("email");
        final String contra=request.getParameter("password");
        //Aquí obtenemos el input file y su nombre
        final Part filePart = request.getPart("fotoP");
                System.out.println("cachamos:"+nombre+usuario+correo+contra+filePart);
        //Obtenemos el nombre del archivo
        String fileName = getFileName(filePart);
       
       
        //A continuación procedemos a ver cual es la extensión del archivo, y verificamos que sea una extensión valida
        boolean valida=false;
        fileName=fileName.toLowerCase();
        if(fileName.endsWith(".jpg")){
            fileName=correo+".jpg";
            valida=true;
        }if(fileName.endsWith(".png")){
            fileName=correo+".png";
            valida=true;
        }if(fileName.endsWith(".ico")){
            fileName=correo+".ico";
            valida=true;
        }if(fileName.endsWith(".gif")){
            fileName=correo+".gif";
            valida=true;
        }if(fileName.endsWith(".jpeg")){
            fileName=correo+".jpeg";
            valida=true;
        }
        
        System.out.println("File name: "+fileName);
        if(valida==false && !(fileName.equals(""))){
            System.out.println("El archivo no tiene extension valida");
            response.sendRedirect("Registro.jsp?r=Archivo de imagen no valido");
        }else{
            if(!(fileName.equals(""))){
                
                 //Si es un archivo valido
                //Flujos para escribir y recibir el archivo    
                OutputStream out = null;
                InputStream filecontent = null;  
                //Nos conectamos a la base para checar que el usuario existe o no.
                try{
                    cConexion con=new cConexion();
                    System.out.println("error?");
                    con.conectar();
                    ResultSet r=con.consulta("call RegistrarUsuario('"+usuario+"','"+correo+"','"+contra+"','"+nombre+"','"+folder+fileName+"');");
                    //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                    if(r.first()){
                        if(r.getInt("msj")==1){
                            //El usuario se registro con exito, redireccionamos al login
                            response.sendRedirect("index.html");
                        }else{
                            //No se pudo guardar
                            response.sendRedirect("Registro.jsp?r=El email o usuario ya existe");
                        }
                    }else{
                        response.sendRedirect("Registro.html?r=Hubo un error, intente de nuevo por favor");
                    }

                    out = new FileOutputStream(new File(path + File.separator + fileName));
                    filecontent = filePart.getInputStream();

                    int read = 0;
                    final byte[] bytes = new byte[1024];

                    //Aquí escribimos el contenido del archivo
                    while ((read = filecontent.read(bytes)) != -1) {
                        out.write(bytes, 0, read);
                    }
                } catch (SQLException ex) {
                    System.out.println("Error con la base: "+ex);
                    response.sendRedirect("Registro.html?r=Hubo un error, intente de nuevo por favor");
                }
            }else{
                //Nos conectamos a la base para checar que el usuario existe o no.
                try{
                    
                    cConexion con=new cConexion();
                    con.conectar();
                    fileName="default.jpg";
                    ResultSet r=con.consulta("call RegistrarUsuario('"+usuario+"','"+correo+"','"+contra+"','"+nombre+"','"+folder+fileName+"');");
                    //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                    if(r.first()){
                        if(r.getInt("msj")==1){
                            //El usuario se registro con exito, redireccionamos al login
                            response.sendRedirect("index.html");
                        }else{
                            //No se pudo guardar
                            response.sendRedirect("Registro.jsp?r=El email ya existe");
                        }
                    }else{
                        response.sendRedirect("Registro.html?r=Hubo un error, intente de nuevo por favor");
                    }
                }catch (SQLException ex) {
                    System.out.println("Error con la base: "+ex);
                    response.sendRedirect("Registro.html?r=Hubo un error, intente de nuevo por favor");
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


/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import bd.cConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.SQLException;
import javax.servlet.ServletException;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author GO_HA
 */
public class Piot_Ser extends HttpServlet {

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
        Integer idUsuario=0;
        response.setContentType("text/html;charset=UTF-8");
        try (PrintWriter out = response.getWriter()) {
            HttpSession sesion= request.getSession();
            idUsuario= (Integer) sesion.getAttribute("idUsuario");     
            System.out.println("*"+idUsuario);
            String text= request.getParameter("message");                       
            try{
                cConexion con=new cConexion();
                con.conectar();
                System.out.println("Conexion exitosa");
                ResultSet r=con.consulta("call crearTweet("+idUsuario+",'"+text+"');");
                if(r.first()){
                    //Obtenemos el id del tweet que acabamos de crear
                    int idTweetCreado=r.getInt("idTweet");
                    //veemos si el tweet tiene hashtags
                    hasHasthag(text,idTweetCreado);
                    response.sendRedirect("Inicio.jsp");
                }else{
                    System.out.println("Error al crear tweet");
                    response.sendRedirect("index.html");
                }                                       
                System.out.println(""+text+" - "+idUsuario);
            }catch(IOException | SQLException e){
                System.out.println(""+e.getMessage());
            }            
        }
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

    private void hasHasthag(String text, int idTweetCreado) {
        //Primero vamos a separar el tweet completo en palabras
        String[] palabras=text.split(" ");
        //Ahora vamos a recorrer todas las palabras encontradas en el tweet
        for (String palabra : palabras) {
            //Para cada palabra habrá que revisar si empieza con un gatito
            if(palabra.startsWith("#")){
                System.out.println("Esta palabra empieza con un hashtag:"+palabra);
                //Entonces hay que guardarla en la base
                try{
                    cConexion con=new cConexion();
                    con.conectar();
                    System.out.println("Conexion exitosa para guardar hashtag");
                    ResultSet r=con.consulta("call guardarHashtag('"+palabra+"',"+idTweetCreado+");");
                    if(r.first()){
                        System.out.println("El hashtag se guardo correctamente");
                    }else{
                        System.out.println("Error al guardar el hashtag del tweet");
                    }                                       
                }catch(SQLException e){
                    System.out.println("Error al guardar hashtag en la base: "+e.getMessage());
                }    
                
            }
        }
        
    }

}

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
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ANDRES
 */
@WebServlet(name = "Perfil", urlPatterns = {"/Perfil"})
public class Perfil extends HttpServlet {
    String datos [];
    int numeros[];
    
    
    public Perfil(){
    
    }
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
            try (PrintWriter out = response.getWriter()) {

            try{
               
                String rq1 = request.getParameter("idUsuario");     
                
                if(rq1==null){
                    
                    int idUsuario;
                    HttpSession sesion= request.getSession();
                    idUsuario= (int) sesion.getAttribute("idUsuario");
                    cConexion con= new cConexion();
                    con.conectar();
                    ResultSet rs=con.consulta("call Perfil('"+idUsuario+"')");
                    
                    datos[0]=rs.getString("nombreUsuario");
                    datos[1]=rs.getString("nombre");
                    datos[2]=rs.getString("fotoPerfil");
                    numeros[0]=rs.getInt("tweets");
                    numeros[1]=rs.getInt("seguidores");
                    numeros[2]=rs.getInt("seguidos");
                
                    ResultSet rs3=con.consulta("call ObtenerTweetsUsuario('"+idUsuario+"')");             
                }
                else{
                    
                    cConexion con= new cConexion();
                    con.conectar();
                    ResultSet rs=con.consulta("call Perfil('"+rq1+"')");
                    datos[0]=rs.getString("nombreUsuario");
                    datos[1]=rs.getString("nombre");
                    datos[2]=rs.getString("fotoPerfil");
                    numeros[0]=rs.getInt("tweets");
                    numeros[1]=rs.getInt("seguidores");
                    numeros[2]=rs.getInt("seguidos");
                    
                    ResultSet rs1=con.consulta("call MostrarSeguidores('"+rq1+"')");
                    
                    ResultSet rs2=con.consulta("call MostrarSeguidos('"+rq1+"')");
                    
                    ResultSet rs3=con.consulta("call MostrarTweets('"+rq1+"')");
                    
                    
                }

            }catch (Exception e){

            }
            
            /* TODO output your page here. You may use following sample code. */
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Perfil</title>");            
            out.println("</head>");
            out.println("<body>");
            out.println("<h1>Servlet Perfil at " + request.getContextPath() + "</h1>");
            out.println("</body>");
            out.println("</html>");
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

}

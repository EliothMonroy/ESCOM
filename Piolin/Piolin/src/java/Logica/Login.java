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
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ANDRES
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
@MultipartConfig
public class Login extends HttpServlet {

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
            /* TODO output your page here. You may use following sample code. */
            
            String n1 = request.getParameter("txtcorreo"); //atrapa el usuario
            String n2 = request.getParameter("contra");                    
            
            
            try{
                cConexion con=new cConexion();
                con.conectar();
               
                ResultSet r=con.consulta("call Login('"+n1+"','"+n2+"');");
                 System.out.println("n1 vale:" +n1 + " n2 vale: " +n2+"Hola!");
                
                if(r.first()){
                    int id= r.getInt("msj");
                    if(id==0){
                        response.sendRedirect("index.html?r=Contraseña o correo incorrecto, vuelva a intentarlo");
                    }
                    else{
                        HttpSession sesion= request.getSession();
                        sesion.setAttribute("idUsuario", id);                 
                        response.sendRedirect("Inicio.jsp");
                    }
                }                
                else{
                    response.sendRedirect("Login.jsp?r= Error inesperado, vuelva a intentarlo");
                }
            
            }catch(Exception e){
                System.out.println("Error : "+e.getMessage());
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

}

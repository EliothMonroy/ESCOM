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
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author ANDRES
 */
@WebServlet(name = "rePiot_ser", urlPatterns = {"/rePiot_ser"})
public class rePiot_ser extends HttpServlet {

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
            Integer idUsuario=0;
            String text1= request.getParameter("message1");
            String text2= request.getParameter("message2");
            String idtwt= request.getParameter("idtwtorg");
            System.out.println("tweet: "+text1);
            System.out.println("retweet: "+text2);
            try{
                cConexion con=new cConexion();
                con.conectar();
                System.out.println("Conexion exitosa");
                HttpSession sesion= request.getSession();
                idUsuario= (Integer) sesion.getAttribute("idUsuario");     
                System.out.println("*"+idUsuario);
                ResultSet r=con.consulta("call crearTweet("+idUsuario+",'"+text1+"\n"+text2+"');");
                
                //ResultSet rs1 = con.consulta("call crearReTweet("+idUsuario+","+idtwt+");");

                  response.sendRedirect("Inicio.jsp");
               
                                       
            System.out.println(""+text2+text1+"-"+idUsuario);
             
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

}

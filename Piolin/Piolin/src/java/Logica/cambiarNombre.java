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
 * @author Daniel
 */
@WebServlet(name = "cambiarNombre", urlPatterns = {"/cambiarNombre"})
public class cambiarNombre extends HttpServlet {

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
        String NuevoN=request.getParameter("txtcorreo");
        System.out.println("nuevo nombre: "+ NuevoN);
        int idUsuario=0;
         try{
                cConexion con=new cConexion();
                con.conectar();
                HttpSession sesion= request.getSession();
                idUsuario= (int) sesion.getAttribute("idUsuario");   
                ResultSet r=con.consulta("call cambiarNombre("+idUsuario+",'"+NuevoN+"');");
                //En java, siempre estamos obligados a ver si nuestro resulset trajo algo
                if(r.first()){
                    if(1==r.getInt("msj"))
                        response.sendRedirect("Perfil.jsp?r=Se cambio exitosamente el nombre");
                    else
                        response.sendRedirect("cambiarImagen.jsp?r=Hubo un problema al cambiar la imagen, vuelva a intentarlo");
                }
     
        }catch (SQLException ex) {
             System.out.println("Error con la base: "+ex);
             response.sendRedirect("Registro.html?r=Hubo un error, intente de nuevo por favor");
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

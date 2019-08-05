/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import bd.Conexion;
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
 * @author eliot
 */
@WebServlet(name = "Login", urlPatterns = {"/Login"})
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
        HttpSession sesion = request.getSession();
        
        try (PrintWriter out = response.getWriter()) {
            String email=request.getParameter("email");
            String contra=request.getParameter("contra");
            try{
                Conexion con=new Conexion();
                con.conectar();
                ResultSet r=con.consulta("call Iniciar_Sesion('"+email+"','"+contra+"');");
                if(r.first()){                    
                    if(r.getInt("msj")==-1){//Número maximo de dispositivos
                        System.out.println("Max dispositivos");
                        response.sendRedirect("Login.jsp?r=4");
                    }else if(r.getInt("msj")!=0){//Usuario valido
                        System.out.println("Usuario valido");                       
                        sesion.setAttribute("idUsuario", r.getInt("msj"));
                        System.out.println(sesion.getAttribute("idUsuario"));
                        //Integer idUsuario=(Integer)sesion.getAttribute(email);
                        ResultSet r2=con.consulta("call Es_PrimerPerfil('"+email+"');");//Caso 1:Primer inicio de sesion   Caso 2:Ya ha iniciado sesion  
                        if(r2.first()){
                            if("1".equals(r2.getString("msj"))){//Crear primer perfil
                                //Agregamos un atributo a la sesion
                                sesion.setAttribute("primeraVez", 1);
                                response.sendRedirect("EditaPerfil.jsp");    
                            }
                            else{//Ya existe un perfil
                                sesion.setAttribute("primeraVez", 0);//Atributo primera Vez falso
                                response.sendRedirect("SeleccionaPerfil.jsp");       
                            }
                        }else{
                            response.sendRedirect("Login.jsp?r=2");
                        }                            
                    }else{//El procedure devolvio 0
                        response.sendRedirect("Login.jsp?r=3");    
                    }                                        
                }else{
                    response.sendRedirect("Login.jsp?r=2");
                }
            }catch(IOException | SQLException e){
                System.out.println(e);
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

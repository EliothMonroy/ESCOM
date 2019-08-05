/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import bd.Conexion;
import java.io.IOException;
import java.sql.ResultSet;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

/**
 *
 * @author 
 */
@WebServlet(name = "Registro", urlPatterns = {"/Registro"})
public class Registro extends HttpServlet {

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
        String form=request.getParameter("formulario");
        if(form==null){
            response.sendRedirect("/NetBlim");
        }else{
            if(form.equals("Registro")){
                String correo=request.getParameter("email");
                String contra=request.getParameter("contra");
                try{
                    Conexion con=new Conexion();
                    con.conectar();
                    ResultSet r=con.consulta("call existeUsuario('"+correo+"');");
                    if(r.first()){
                        if(r.getInt("msj")==1){
                            response.sendRedirect("Registro.jsp?r=Email ya existente :/");
                        }else{
                            if(r.getInt("msj")==0){
                                HttpSession sesion=request.getSession();
                                sesion.setAttribute("email", correo);
                                sesion.setAttribute("contra", contra);
                                response.sendRedirect("Plan.jsp");
                            }
                        }
                    }else{
                        response.sendRedirect("Registro.jsp?r=Error extraño");
                    }
                }catch(Exception e){
                    System.out.println("Error: "+e);
                }


            }else{
                System.out.println("Llegue desde otro formulario");
                if(form.equals("plan1")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("plan", 1);
                    response.sendRedirect("MetodoPago.jsp");
                }else if(form.equals("plan2")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("plan", 2);
                    response.sendRedirect("MetodoPago.jsp");
                }else if(form.equals("plan3")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("plan", 3);
                    response.sendRedirect("MetodoPago.jsp");
                }else if(form.equals("pagoCredito")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("pago", 1);
                    response.sendRedirect("Datos.jsp");
                }else if(form.equals("pagoDebito")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("pago", 2);
                    response.sendRedirect("Datos.jsp");
                }else if(form.equals("pagoRegalo")){
                    HttpSession sesion=request.getSession();
                    sesion.setAttribute("pago", 3);
                    response.sendRedirect("Regalo.jsp");
                }else if(form.equals("finalTarjeta")){
                    HttpSession sesion=request.getSession();
                    String correo=(String)sesion.getAttribute("email");
                    String contra=(String)sesion.getAttribute("contra");
                    Integer plan=(Integer)sesion.getAttribute("plan");
                    Integer pago=(Integer)sesion.getAttribute("pago");
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r=con.consulta("call Alta_Usuario('"+correo+"','"+contra+"');");
                        if(r.first()){
                            int id=r.getInt("msj");
                            if(id==0){
                                response.sendRedirect("Registro.jsp?r=Email ya existe");
                            }else{
                                int plan_pago=0;
                                if(plan==1 && pago==1){
                                    plan_pago=1;
                                }else if(plan==1 && pago==2){
                                    plan_pago=2;
                                }else if(plan==1 && pago==3){
                                    plan_pago=3;
                                }else if(plan==2 && pago==1){
                                    plan_pago=4;
                                }else if(plan==2 && pago==2){
                                    plan_pago=5;
                                }else if(plan==2 && pago==3){
                                    plan_pago=6;
                                }else if(plan==3 && pago==1){
                                    plan_pago=7;
                                }else if(plan==3 && pago==2){
                                    plan_pago=8;
                                }else if(plan==3 && pago==3){
                                    plan_pago=9;
                                }
                                r=con.consulta("call Alta_Cliente("+id+",0.0,"+plan_pago+");");
                                if(r.first()){
                                    if(r.getInt("msj")==1){
                                        response.sendRedirect("Login.jsp?r=1");
                                    }else{
                                        response.sendRedirect("Registro.jsp?r=Algo raro paso");
                                    }
                                }else{
                                    response.sendRedirect("Registro.jsp?r=Error en base");
                                }
                            }
                        }else{
                            response.sendRedirect("Registro.jsp?=Error con la base");
                        }
                    }catch(Exception e){
                        System.out.println("Error: "+e);
                    }

                }else if(form.equals("finalRegalo")){
                    HttpSession sesion=request.getSession();
                    String correo=(String)sesion.getAttribute("email");
                    String contra=(String)sesion.getAttribute("contra");
                    Integer plan=(Integer)sesion.getAttribute("plan");
                    Integer pago=(Integer)sesion.getAttribute("pago");
                    String saldo=request.getParameter("saldo");
                    try{
                        Conexion con=new Conexion();
                        con.conectar();
                        ResultSet r=con.consulta("call Alta_Usuario('"+correo+"','"+contra+"');");
                        if(r.first()){
                            int id=r.getInt("msj");
                            if(id==0){
                                response.sendRedirect("Registro.jsp?r=Email ya existe");
                            }else{
                                int plan_pago=0;
                                if(plan==1 && pago==1){
                                    plan_pago=1;
                                }else if(plan==1 && pago==2){
                                    plan_pago=2;
                                }else if(plan==1 && pago==3){
                                    plan_pago=3;
                                }else if(plan==2 && pago==1){
                                    plan_pago=4;
                                }else if(plan==2 && pago==2){
                                    plan_pago=5;
                                }else if(plan==2 && pago==3){
                                    plan_pago=6;
                                }else if(plan==3 && pago==1){
                                    plan_pago=7;
                                }else if(plan==3 && pago==2){
                                    plan_pago=8;
                                }else if(plan==3 && pago==3){
                                    plan_pago=9;
                                }
                                r=con.consulta("call Alta_Cliente("+id+","+Float.parseFloat(saldo)+","+plan_pago+");");
                                if(r.first()){
                                    if(r.getInt("msj")==1){
                                        response.sendRedirect("Login.jsp?r=1");
                                    }else{
                                        response.sendRedirect("Registro.jsp?r=Algo raro paso");
                                    }
                                }else{
                                    response.sendRedirect("Registro.jsp?r=Error en base");
                                }
                            }
                        }else{
                            response.sendRedirect("Registro.jsp?=Error con la base");
                        }
                    }catch(Exception e){
                        System.out.println("Error: "+e);
                    }
                }
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

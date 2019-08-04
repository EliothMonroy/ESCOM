/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import bd.cConexion;
import java.io.IOException;
import java.io.PrintWriter;
import java.sql.ResultSet;
import java.sql.ResultSetMetaData;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 *
 * @author ELITH
 */
@WebServlet(name = "Perros", urlPatterns = {"/Perros"})
public class Perros extends HttpServlet {

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
            out.println("<!DOCTYPE html>");
            out.println("<html>");
            out.println("<head>");
            out.println("<title>Servlet Perros</title>");            
            out.println("</head>");
            out.println("<body style='text-align:center'>");
            out.println("<style>\ntable, th, td {\nborder: 1px solid black;\nborder-collapse: collapse;\n}\nth, td {\npadding: 5px;\ntext-align: center;\n}\n</style>");
            try{
                cConexion con=new cConexion();
                con.conectar();
                ResultSet rs=con.consulta(request.getParameter("consulta"));
                if(rs.first()){
                    out.println("<table style=\"width:100%\"><caption>Resultado consulta</caption>");
                    ResultSetMetaData rsmd=rs.getMetaData();
                    out.println("<tr>");
                    for(int i=0;i<rsmd.getColumnCount();i++){
                        out.println("<th>"+rsmd.getColumnName(i+1).toUpperCase()+"</th>");
                    }
                    out.println("</tr>");
                    do{
                        out.println("<tr>");
                        for (int i=0;i<rsmd.getColumnCount();i++){
                            out.println("<td>"+rs.getString(i+1)+"</td>");
                        }                        
                        out.println("</tr>");
                    }while(rs.next());
                    out.println("</table>");
                    out.println("<br><br><button><a href='index.jsp'>Volver</a></button>");
                }else{
                    out.println("<script>alert('No se encontraron resultados para esa busqueda');</script>");
                    out.println("<meta http-equiv=\"refresh\" content='0; url=index.jsp?r="+request.getParameter("consulta")+"' />");
                    //out.println("<button><a href='index.jsp?r="+request.getParameter("consulta")+"'>Volver</a></button>");
                }
            }catch(Exception e){
                System.out.println("Error:"+e);
                if(e.getMessage().startsWith("Table")){
                    out.println("<script>alert('La tabla que buscas no existe :/');</script>");
                    out.println("<meta http-equiv=\"refresh\" content='0; url=index.jsp?r="+request.getParameter("consulta")+"' />");
                    //out.println("<button><a href='index.jsp?r="+request.getParameter("consulta")+"'>Volver</a></button>");
                }else{
                    out.println("<script>alert('Error en tu sintaxis sql, revisa tu instrucción');</script>");
                    out.println("<meta http-equiv=\"refresh\" content='0; url=index.jsp?r="+request.getParameter("consulta")+"' />");
                    //out.println("<button><a href='index.jsp?r="+request.getParameter("consulta")+"'>Volver</a></button>");
                }
                
            }     
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

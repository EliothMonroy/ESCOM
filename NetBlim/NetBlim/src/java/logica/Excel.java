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

import java.io.PrintWriter;
import java.sql.Date;

import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.logging.Level;
import java.util.logging.Logger;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;

/**
 *
 * @author usuario
 */
@WebServlet(name = "Excel", urlPatterns = {"/Excel"})
public class Excel extends HttpServlet {

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
            throws ServletException, IOException, SQLException {
        String reporte =request.getParameter("reporte");
        System.out.println(reporte+"----------------------------------------------");
        if(reporte.equals("repo1")){
            String rutaArchivo = System.getProperty("user.home")+"/usuarios.xls";
            Conexion conectar = new Conexion();
            conectar.conectar();
            ResultSet rs;
            rs =conectar.consulta("select * from usuario;");
        
        System.out.println(rutaArchivo);
        File archivoXLS = new File(rutaArchivo);
        if(archivoXLS.exists()) 
            archivoXLS.delete();
        archivoXLS.createNewFile();
        Workbook libro = new HSSFWorkbook();
        try (FileOutputStream archivo = new FileOutputStream(archivoXLS)) {
            Sheet hoja = (Sheet) libro.createSheet("Mi hoja de trabajo");
            int f=1;
            Row fila2 = hoja.createRow(0);
            Cell celda2 = fila2.createCell(0);
            Cell celda3 = fila2.createCell(1);
            Cell celda4 = fila2.createCell(2);
            Cell celda5 = fila2.createCell(3);
            Cell celda6 = fila2.createCell(4);
            celda2.setCellValue("IdUsuario");
            celda3.setCellValue("email");
            celda4.setCellValue("estado");
            celda5.setCellValue("fecha de registro");
            celda6.setCellValue("contraseña");
            while(rs.next()){
                Row fila = hoja.createRow(f);
                for(int c=0;c<5;c++){
                    Cell celda = fila.createCell(c);
                        if(c==0){
                            celda.setCellValue(rs.getInt("IdUsuario"));
                        }
                        if(c==1){
                            celda.setCellValue(rs.getString("email"));
                        }
                        if(c==2){
                            celda.setCellValue(rs.getString("estado"));
                        }
                        if(c==3){
                            celda.setCellValue(rs.getString("fecha_registro"));
                        }
                        if(c==4){
                            celda.setCellValue(rs.getString("contra"));
                        }
                }
                f++;
            }
            libro.write(archivo);
        }
        response.sendRedirect("Excel.jsp?r=Ve_a_ver_las_consultas_en_excel");
        }
        if(reporte.equals("repo2")){
            
            String rutaArchivo = System.getProperty("user.home")+"/peliseries.xls";
            Conexion conectar = new Conexion();
            conectar.conectar();
            ResultSet rs;
            rs =conectar.consulta("select idPeli_serie, valoracion, nombre, fecha_registro, estado, anio, descripcion from peli_serie;");
        
        System.out.println(rutaArchivo);
        File archivoXLS = new File(rutaArchivo);
        if(archivoXLS.exists()) 
            archivoXLS.delete();
        archivoXLS.createNewFile();
        Workbook libro = new HSSFWorkbook();
        try (FileOutputStream archivo = new FileOutputStream(archivoXLS)) {
            Sheet hoja = (Sheet) libro.createSheet("Mi hoja de trabajo");
            int f=1;
            Row fila2 = hoja.createRow(0);
            Cell celda2 = fila2.createCell(0);
            Cell celda3 = fila2.createCell(1);
            Cell celda4 = fila2.createCell(2);
            Cell celda5 = fila2.createCell(3);
            Cell celda6 = fila2.createCell(4);
            Cell celda7 = fila2.createCell(5);
            Cell celda8 = fila2.createCell(6);
            celda2.setCellValue("IdPeli_serie");
            celda3.setCellValue("valoracion");
            celda4.setCellValue("nombre");
            celda5.setCellValue("fecha de registro");
            celda6.setCellValue("estado");
            celda7.setCellValue("anio");
            celda8.setCellValue("descripcion");
   
            while(rs.next()){
                Row fila = hoja.createRow(f);
                for(int c=0;c<7;c++){
                    Cell celda = fila.createCell(c);
                        if(c==0){
                            celda.setCellValue(rs.getInt("IdPeli_serie"));
                        }
                        if(c==1){
                            celda.setCellValue(rs.getString("valoracion"));
                        }
                        if(c==2){
                            celda.setCellValue(rs.getString("nombre"));
                        }
                        if(c==3){
                            celda.setCellValue(rs.getString("fecha_registro"));
                        }
                        if(c==4){
                            celda.setCellValue(rs.getString("estado"));
                        }
                        if(c==5){
                            celda.setCellValue(rs.getString("anio"));
                        }
                        if(c==6){
                            celda.setCellValue(rs.getString("descripcion"));
                        }
                }
                f++;
            }
            libro.write(archivo);
        }
        response.sendRedirect("Excel.jsp?r=Ve_a_ver_las_consultas_en_excel");
        }
        if(reporte.equals("repo3")){
            
            String rutaArchivo = System.getProperty("user.home")+"/usuarios_y_planes.xls";
            Conexion conectar = new Conexion();
            conectar.conectar();
            ResultSet rs;
            rs =conectar.consulta("select idUsuario, email, usuario.fecha_registro, contra, plan.metodo_pago, plan.costo, plan.max_dispo from usuario,cliente,plan where idUsuario=Usuario_idUsuario and idPlan=Plan_idPlan;");
        
        System.out.println(rutaArchivo);
        File archivoXLS = new File(rutaArchivo);
        if(archivoXLS.exists()) 
            archivoXLS.delete();
        archivoXLS.createNewFile();
        Workbook libro = new HSSFWorkbook();
        try (FileOutputStream archivo = new FileOutputStream(archivoXLS)) {
            Sheet hoja = (Sheet) libro.createSheet("Mi hoja de trabajo");
            int f=1;
            Row fila2 = hoja.createRow(0);
            Cell celda2 = fila2.createCell(0);
            Cell celda3 = fila2.createCell(1);
            Cell celda4 = fila2.createCell(2);
            Cell celda5 = fila2.createCell(3);
            Cell celda6 = fila2.createCell(4);
            Cell celda7 = fila2.createCell(5);
            Cell celda8 = fila2.createCell(6);
            celda2.setCellValue("IdUsuario");
            celda3.setCellValue("email");
            celda4.setCellValue("fecha de registro");
            celda5.setCellValue("contraseña");
            celda6.setCellValue("metodo de pago");
            celda7.setCellValue("costo");
            celda8.setCellValue("máximo # de dispositivos");
   
            while(rs.next()){
                Row fila = hoja.createRow(f);
                for(int c=0;c<7;c++){
                    Cell celda = fila.createCell(c);
                        if(c==0){
                            celda.setCellValue(rs.getInt("usuario.IdUsuario"));
                        }
                        if(c==1){
                            celda.setCellValue(rs.getString("usuario.email"));
                        }
                        if(c==2){
                            celda.setCellValue(rs.getString("usuario.fecha_registro"));
                        }
                        if(c==3){
                            celda.setCellValue(rs.getString("usuario.contra"));
                        }
                        if(c==4){
                            celda.setCellValue(rs.getString("plan.metodo_pago"));
                        }
                        if(c==5){
                            celda.setCellValue(rs.getString("plan.costo"));
                        }
                        if(c==6){
                            celda.setCellValue(rs.getString("plan.max_dispo"));
                        }
                }
                f++;
            }
            libro.write(archivo);
        }
        response.sendRedirect("Excel.jsp?r=Ve_a_ver_las_consultas_en_excel");
        }
        
        if(reporte.equals("repo4")){
            response.sendRedirect("index.html?r= ");
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Excel.class.getName()).log(Level.SEVERE, null, ex);
        }
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
        try {
            processRequest(request, response);
        } catch (SQLException ex) {
            Logger.getLogger(Excel.class.getName()).log(Level.SEVERE, null, ex);
        }
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

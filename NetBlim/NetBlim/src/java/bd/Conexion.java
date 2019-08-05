/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

package bd;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;
/**
 *
 * @author Giss
 */
public class Conexion {
    //Variables para la conexion con la base
    private String Driver_BD, Url_BD, Usuario_BD, Contrasena_BD;
    private Connection conexion=null;
    private Statement statequieto=null;
    //Constructor que sirve para inicializar variables para cualquier base de datos
    public Conexion(String driver, String url, String usuario, String contra){
        Driver_BD=driver;
        Url_BD=url;
        Usuario_BD=usuario;
        Contrasena_BD=contra;
    }
    //Constructor que sirve para inicializar variables para cualquier Base de Datos en MySql
    public Conexion(){
        Driver_BD="com.mysql.jdbc.Driver";
        Url_BD="jdbc:mysql://127.0.0.1:3306/netblim";
        Usuario_BD="root";
        Contrasena_BD="root";
    }
    //Conexion a la BD
    public void conectar(){
        try {
            Class.forName(Driver_BD).newInstance();
            conexion = DriverManager.getConnection(Url_BD, Usuario_BD, Contrasena_BD);

        } catch (ClassNotFoundException | InstantiationException | IllegalAccessException | SQLException err) {
            System.out.println("Error " + err.getMessage());
        }
    }
    //Cerrar la conexion de BD
    public void cerrarConexion() throws SQLException {
        conexion.close();
    }
    //Metodos para ejecutar sentencias SQL
    public ResultSet consulta(String consulta) throws SQLException{
        System.out.print("La consulta fue "+ consulta);
        
        statequieto = (Statement) conexion.createStatement();
        return statequieto.executeQuery(consulta);
    }
    public void actualizar(String actualiza) throws SQLException{
        statequieto = (Statement) conexion.createStatement();
        statequieto.executeUpdate(actualiza);
        statequieto.closeOnCompletion();
    }
    public int borrar(String borra) throws SQLException{
        statequieto = (Statement) conexion.createStatement();
        return statequieto.executeUpdate(borra);
    }
    public void insertar(String inserta) throws SQLException{
        statequieto = (Statement) conexion.createStatement();
        statequieto.executeUpdate(inserta);
    }
    public Connection getConexion() {
        return conexion;
    }
}

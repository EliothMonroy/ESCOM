/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package logica;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import bd.Conexion;
import java.beans.PropertyVetoException;
import java.io.IOException;
import java.sql.SQLException;

/**
 *
 * @author arhel
 */
public class Pelicula {
    Conexion con;
    ResultSet rs = null;
    PreparedStatement ps= null; 
    public ResultSet getPeliculas(String genero) throws SQLException{
        con=new Conexion();
        con.conectar();
        String sql="Select * from peli_serie where Genero_idGenero like ?";
        ps=con.getConexion().prepareStatement(sql);
        ps.setString(1,genero);
        rs=ps.executeQuery();
        return rs;
    }
     public ResultSet getPeliculasall(String genero) throws SQLException{
        con=new Conexion();
        con.conectar();
        String sql="Select * from peli_serie where idPeli_serie like ?";
        ps=con.getConexion().prepareStatement(sql);
        ps.setString(1,genero);
        rs=ps.executeQuery();
        return rs;
    }

    public ResultSet Peliculas()throws SQLException{
       con=new Conexion();
        con.conectar();
        String sql="Select * from peli_serie,pelicula where idPeli_serie=Peli_serie_idPeli_serie";
        ps=con.getConexion().prepareStatement(sql);
        rs=ps.executeQuery();
        return rs;
    }
    public ResultSet Series() throws SQLException{
        con=new Conexion();
        con.conectar();
        String sql="select * from peli_serie,serie where idPeli_serie=Peli_serie_idPeli_serie";
        ps=con.getConexion().prepareStatement(sql);
        rs=ps.executeQuery();
        return rs;
    
    }
      public ResultSet getSeriesall(String id) throws SQLException{
        con=new Conexion();
        con.conectar();
        String sql="Select * from peli_serie where idPeli_serie like ?";
        ps=con.getConexion().prepareStatement(sql);
        ps.setString(1,id);
        rs=ps.executeQuery();
        return rs;
    }
   //Generamos los metodos de busqueda
  
       public ResultSet Consulta(String sql) throws IOException, SQLException, PropertyVetoException{
                     if (Direactor(sql)) {
                        return rs=DireactorR(sql);
                     }else if(nombre(sql)){
                          return rs=nombreR(sql);
                      }else if(anio(sql)){
                           return rs=anioR(sql);
                      } else if(clasif(sql)){
                          return rs=clasifR(sql);
                      }
                      else{
                      rs=null;
                      }
           
           return rs;
           }
           
           public boolean Direactor(String s)throws IOException, SQLException, PropertyVetoException{
            String sql="select * from peli_serie,dire_actor_has_peli_serie,dire_actor where dire_actor_has_peli_serie.Dire_actor_idDire_actor=dire_actor.idDire_actor and dire_actor_has_peli_serie.Peli_serie_idPeli_serie=peli_serie.idPeli_serie and dire_actor.nombre like ?";
               con=new Conexion();
               con.conectar();
               ps=con.getConexion().prepareStatement(sql);
               ps.setString(1,""+s+"%");
               rs=ps.executeQuery();
               return rs.next();
           }
            public ResultSet DireactorR(String s)throws SQLException{
               con=new Conexion();
               con.conectar();
                String sql="select * from peli_serie,dire_actor_has_peli_serie,dire_actor where dire_actor_has_peli_serie.Dire_actor_idDire_actor=dire_actor.idDire_actor and dire_actor_has_peli_serie.Peli_serie_idPeli_serie=peli_serie.idPeli_serie and dire_actor.nombre like?";
               ps=con.getConexion().prepareStatement(sql);
               ps.setString(1,""+s+"%");
               rs=ps.executeQuery();
               return rs;
            }
          public boolean nombre(String s)throws IOException, SQLException, PropertyVetoException{
               String sql="select * from peli_serie where nombre like ?";
               con=new Conexion();
               con.conectar();
               ps=con.getConexion().prepareStatement(sql);
               ps.setString(1,""+s+"%");
               rs=ps.executeQuery();
               return rs.next();
           }
            public ResultSet nombreR(String s)throws IOException, SQLException, PropertyVetoException{
               String sql="select * from peli_serie where nombre like ?";
               con=new Conexion();
               con.conectar();
               ps=con.getConexion().prepareStatement(sql);
               ps.setString(1,""+s+"%");
               rs=ps.executeQuery();
               return rs;
           }
           public boolean anio (String a) throws IOException,SQLException,PropertyVetoException{
              con=new Conexion();
              con.conectar();
              String sql="Select * from Peli_serie where anio like ?";
              ps=con.getConexion().prepareStatement(sql);
              ps.setString(1,a);
              rs=ps.executeQuery();
              return rs.next();
           }
           public ResultSet anioR (String a) throws IOException,SQLException,PropertyVetoException{
              con=new Conexion();
              con.conectar();
              String sql="Select * from Peli_serie where anio like ?";
              ps=con.getConexion().prepareStatement(sql);
              ps.setString(1,a);
              rs=ps.executeQuery();
              return rs;
           }
            public boolean clasif (String c) throws IOException,SQLException,PropertyVetoException{
              con=new Conexion();
              con.conectar();
              String sql="Select * from Peli_serie,Clasificación where Clasificación_idClasificación=idClasificación and Clasificación.Nombre like ?";
              ps=con.getConexion().prepareStatement(sql);
              ps.setString(1,""+c+"%");
              rs=ps.executeQuery();
              return rs.next();
           }
            public ResultSet clasifR (String c) throws IOException,SQLException,PropertyVetoException{
              con=new Conexion();
              con.conectar();
              String sql="Select * from Peli_serie,Clasificación where Clasificación_idClasificación=idClasificación and Clasificación.Nombre like ?";
              ps=con.getConexion().prepareStatement(sql);
              ps.setString(1,""+c+"%");
              rs=ps.executeQuery();
              return rs;
           }
    
    public void close() throws SQLException{
    con.getConexion().close();
    }
    
}

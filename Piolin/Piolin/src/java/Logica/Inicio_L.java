/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;


import java.sql.ResultSet;
import java.sql.SQLException;
import bd.cConexion;


/**
 *
 * @author GO_HA
 */
public class Inicio_L{
   
    public static String name(int id){
        String nom=null; 
        try{
               cConexion con=new cConexion();
               con.conectar();
               //System.out.println("Conexion exitosa"); 
               //System.out.println("*"+id);
               ResultSet r=con.consulta("call obtenerNom("+id+");");
               r.first();
               nom= r.getString("nom");
               //System.out.println(nom+"-"+id);
            }catch(SQLException e){
                System.out.println(""+e.getMessage());
            }
         return nom;
    }
    public static String imagen(int id){ 
        String imagen=null;
        try{
               cConexion con=new cConexion();
               con.conectar();
               //System.out.println("Conexion exitosa"); 
               //System.out.println("*"+id);
               ResultSet r=con.consulta("call obtenerNom("+id+");");
               r.first();
               imagen= r.getString("fotoPerfil");
               //System.out.println(nom+"-"+id);
            }catch(SQLException e){
                System.out.println(""+e.getMessage());
            }
         return imagen;
    }
    public static ResultSet con(int idUsuario){
       ResultSet r=null;
       try{
            cConexion con= new cConexion();
            con.conectar();
            r= con.consulta("call mostrarTweets("+idUsuario+");");
            
        }catch(SQLException er){
            System.out.println(""+er.getMessage());
        }
       return r;
    }
    public static ResultSet con1(int idUsuario){
       ResultSet r=null;
       try{
            cConexion con= new cConexion();
            con.conectar();
            r= con.consulta("call ObtenerTweetsUsuario('" + idUsuario +"');");
            
        }catch(SQLException er){
            System.out.println(""+er.getMessage());
        }
       return r;
    }
    public String fecha(int minu){
        int hora= minu/60;
        int mn= minu%60;
        if(hora>=1) 
            if(hora>= 24){
                    int dia= hora/24;
                    return dia+" dias";
                }
            else if(mn >= 10)
                return hora+":"+mn+" horas";
                else
                return hora+":0"+mn+" horas";
        else 
            return minu+" min";
            
    }
    public String rePioT(String dueño, String msj, String fecha){
       return dueño+"(dijo): "+msj+"              Hace: "+fecha;
    }
    public ResultSet buscar(String usuarioB){
        ResultSet r=null;
       try{
            cConexion con= new cConexion();
            con.conectar();
            r= con.consulta("call buscar('"+usuarioB+"');");
            
        }catch(SQLException er){
            System.out.println(""+er.getMessage());
        }
       return r;
    }
    public static ResultSet Seguir(int idUsuario, int idSeguidor){
       ResultSet r=null;
       try{
            cConexion con= new cConexion();
            con.conectar();
            r= con.consulta("call verSeg("+idSeguidor+","+idUsuario+");");
            
        }catch(SQLException er){
            System.out.println(""+er.getMessage());
        }
       return r;
    }
    
    public static ResultSet idTweet(int idUsuario, int idSeguidor){
       ResultSet r=null;
       try{
            cConexion con= new cConexion();
            con.conectar();
            r= con.consulta("call ObtenerTweetsUsuario('" + idUsuario + "');");
        }catch(SQLException er){
            System.out.println(""+er.getMessage());
        }
       return r;
    }


                                        
    public static void main( String args[]) throws SQLException{
    ResultSet r= Seguir(1,2);
    r.next();
        System.out.println(r.getInt("msj")+"");
    }
}

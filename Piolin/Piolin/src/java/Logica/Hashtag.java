/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package Logica;

import bd.cConexion;
import java.sql.ResultSet;

/**
 *
 * @author ELITH
 */
public class Hashtag {
    public String hasHashtag(String contenido){
        //Primero vamos a separar el tweet completo en palabras
        String[] palabras=contenido.split(" ");
        contenido="";
        String encoded="";
        //Ahora vamos a recorrer todas las palabras encontradas en el tweet
        for (String palabra : palabras) {
            //Para cada palabra habrá que revisar si empieza con un gatito
            if(palabra.startsWith("#")){
                System.out.println("Esta palabra empieza con un hashtag:"+palabra);
                encoded=palabra;
                encoded=encoded.replaceFirst("#", "%23");
                System.out.println("encoded:"+encoded);
                palabra="<a href='Busqueda.jsp?buscar="+encoded+"'><span style='color:#55acee;'>"+palabra+"</span></a>";                
            }
            if(contenido.equals("")){
                contenido+=palabra;
            }else{
                contenido+=" "+palabra; 
            }
        }
        return contenido;
    }
    public ResultSet obtenerTT(){
        ResultSet r = null;
        try{
            cConexion con=new cConexion();
            con.conectar();
            r=con.consulta("call obtenerTT();");
        }catch(Exception e){
            System.out.println("Error al conectarse a la base para obtener TT: "+e);
        }        
        return r;
    }
}

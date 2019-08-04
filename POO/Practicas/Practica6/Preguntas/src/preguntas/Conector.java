package preguntas;


import java.io.BufferedReader;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.ServerSocket;
import java.net.Socket;

public class Conector{
    private Socket socket;
    private ServerSocket server;
    private DataInputStream entradaSocket;
    private DataOutputStream salida;
    private BufferedReader entrada;
    final short puerto=9000;
    public Conector(){
        try{
            //Establecemos la conexion
            server=new ServerSocket(puerto);
            socket=server.accept();
            //Declaramos a los objetos para el manejo de Inputs y Outputs
            entradaSocket=new DataInputStream(socket.getInputStream());
            //entrada=new BufferedReader(entradaSocket);
            salida=new DataOutputStream(socket.getOutputStream());
        }catch(Exception e){
            System.out.println("Hubo en error en el socket server: "+e);
        }
    }
    public Conector(String ip){
        try{
            //Establecemos la conexion
            socket=new Socket(ip,this.puerto);
            //Declaramos a los objetos para el manejo de Inputs y Outputs
            entradaSocket=new DataInputStream(socket.getInputStream());
            //entrada=new BufferedReader(entradaSocket);
            salida=new DataOutputStream(socket.getOutputStream());
        }catch(Exception e){
            System.out.println("Hubo en error en el socket: "+e);
        }
    }
    public void enviarMensaje(String mensaje){
        try{
            salida.writeUTF(mensaje);
        }catch(Exception e){
            System.out.println("Error al enviar el mensaje: "+e);
        }
    }
    public String recibirMensaje(){
        try{
            return entradaSocket.readUTF();
        }catch(Exception e){
            System.out.println("Error al leer el mensaje: "+e);
            return null;
        }
    }
    public void desconectar(){
        try{
            server.close();
            socket.close();
        }catch(Exception e){
            System.out.println("Error al desconectar: "+e);
        }
    }
}

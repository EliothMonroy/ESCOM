import java.net.*;
import java.io.*;
public class RecibeO{
	// public static final String  HOST="localhost";
	public static final int PUERTO=8000;
	public static void main(String[] args) {
		try{
			ServerSocket server = new ServerSocket(PUERTO);
			System.out.println("Servidor iniciado, esperando clientes");
			for (;;){
				Socket cl=server.accept();
				//Para recibir objeto por parte del socket
				ObjectInputStream ois = new ObjectInputStream(cl.getInputStream());
				Dato d1=(Dato)ois.readObject();
				System.out.println("Objeto recibido->v1:"+d1.getV1()+" v2:"+d1.getV2()+" v3:"+d1.getV3()+" v4:"+d1.getV4());
				Dato d=new Dato("Juan2",30,2.0f, 400000);
				//Para enviar el objeto a traves del socket
				ObjectOutputStream oos = new ObjectOutputStream(cl.getOutputStream());
				System.out.println("Se enviara el siguiente objeto:\nv1:"+d.getV1()+" v2:"+d.getV2()+" v3:"+d.getV3()+" v4:"+d.getV4());
				oos.writeObject(d);
				oos.flush();
				System.out.println("Objeto enviado");
				ois.close();
				oos.close();
				cl.close();
			}
		}catch(Exception e){
			e.printStackTrace();
			server.close();
		}
	}
}
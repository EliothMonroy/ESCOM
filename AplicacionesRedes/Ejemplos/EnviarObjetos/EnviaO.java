import java.net.*;
import java.io.*;
public class EnviaO{
	public static void main(String[] args) {
		try{
			Socket cl=new Socket("localhost",8000);
			Dato d=new Dato("Juan",20,1.0f, 300000);
			//Para enviar el objeto
			ObjectOutputStream oos = new ObjectOutputStream(cl.getOutputStream());
			System.out.println("Se enviara el siguiente objeto:\nv1:"+d.getV1()+" v2:"+d.getV2()+" v3:"+d.getV3()+" v4:"+d.getV4());
			oos.writeObject(d);
			oos.flush();
			System.out.println("Objeto enviado, Ahora se recibira un objeto");
			//Para recibir el objeto
			ObjectInputStream ois = new ObjectInputStream(cl.getInputStream());
			Dato d1=(Dato)ois.readObject();
			System.out.println("Objeto recibido->v1:"+d1.getV1()+" v2:"+d1.getV2()+" v3:"+d1.getV3()+" v4:"+d1.getV4());
			ois.close();
			oos.close();
			cl.close();
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
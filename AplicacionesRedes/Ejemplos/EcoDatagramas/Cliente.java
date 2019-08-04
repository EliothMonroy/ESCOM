import java.io.BufferedReader;
import java.io.ByteArrayInputStream;
import java.io.ByteArrayOutputStream;
import java.io.DataInputStream;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
public class Cliente{
	public static void main(String[] args) {
		try{
			InetAddress dst=InetAddress.getByName("localhost");
			int pto=9000;
			DatagramSocket cl=new DatagramSocket();
			BufferedReader br=new BufferedReader(new InputStreamReader(System.in));
			int limite=100;
			//TODO: como es un servicio eco, falta implementar la parte donde se recibe una respuesta
			for(;;){
				String msj=br.readLine();
				byte []b=msj.getBytes();
				if(b.length>limite){
					byte[] tmp=new byte[100];
					ByteArrayInputStream bais=new ByteArrayInputStream(b);
					int c=0;
					int np=(int)(b.length/tmp.length);
					if((b.length%tmp.length)>0){
						np=np+1;
					}
					int n;
					while((n=bais.read(tmp))!=-1){
						Dato d=new Dato(++c,np,tmp,tmp.length);
						ByteArrayOutputStream baos=new ByteArrayOutputStream();
						ObjectOutputStream oos=new ObjectOutputStream(baos);
						oos.writeObject(d);
						oos.flush();
						byte []b1=baos.toByteArray();
						DatagramPacket p=new DatagramPacket(b1, b1.length, dst, pto);
						cl.send(p);
					}
				}else{
					//Aqui se realizará la lectura ?
					DatagramPacket p1=new DatagramPacket(new byte[65535], 65535);
					cl.receive(p1);
					//Tipos primitivos
					DataInputStream dis=new DataInputStream(new ByteArrayInputStream(p1.getData()));
					//Objetos
					ObjectInputStream ois=new ObjectInputStream(new ByteArrayInputStream(p1.getData()));
					Dato d1=(Dato)ois.readObject();
				}
			}
			cl.close();
		}catch(Exception e){
			System.out.println(e.toString());
		}
	}
}
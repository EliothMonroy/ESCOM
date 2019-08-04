import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
import java.net.InetAddress;
public class Envia{
	public static void main(String[] args) {
		try {
			//parámetros para DatagramPacket, byte[] buff, int length
			DatagramPacket p=new DatagramPacket(new byte[1500],1500);
			String msj="Un mensaje";
			p.setData(msj.getBytes());
			p.setLength(msj.getBytes().length);
			p.setAddress(InetAddress.getByName("1.2.3.4"));
			p.setPort(1234);
			//Otra forma de declarar las dos lineas de arriba
			InetSocketAddress dst=new InetSocketAddress("1.2.3.4",4000);
			p.setSocketAddress(dst);
		} catch (Exception e) {
			//TODO: handle exception
		}
		try {
			//Para poder enviar DatagramPacket es necesario usar DatagramSocket
			DatagramSocket s=DatagramSocket(1234);
			System.out.println("Servicio de datagrama iniciado");
			//Otra forma de hacer lo mismo
			DatagramSocket s=new DatagramSocket();
			InetSocketAddress pto=new InetSocketAddress(1234);
			s.bind(pto);
		} catch (Exception e) {
			//TODO: handle exception
		}
		//Enviar cualquier tipo de dato
		try {
			int x=4;
			DatagramSocket cl=new DatagramSocket();
			InetAddress dst=InetAddress.getByName("localhost");
			int pto=9000;
			ByteArrayOutputStream baos=new ByteArrayOutputStream();
			DataOutputStream dos=new DataOutputStream(baos);
			dos.writeInt(x);
			dos.flush();
			byte []b=baos.toByteArray();
			DatagramPacket p=new DatagramPacket(b, b.length, dst, pto);
			cl.send(p);
			//Para recibir
			DatagramPacket p1=new DatagramPacket(new byte[65535], 65535);
			cl.receive(p1);
			//String datos=new String(p1.getData(),0,p1.getLength());
		} catch (Exception e) {
			//TODO: handle exception
		}
	}
}

import java.io.ByteArrayOutputStream;
import java.io.DataOutputStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;
public class Cliente{
	public static void main(String[] args){
		try{
			DatagramSocket s=new DatagramSocket(1234);
			s.setBroadcast(true);
			String msj="Mensaje";
			byte[] b=msj.getBytes();
			InetAddress dst=InetAddress.getByName("255.255.255.255");
			DatagramPacket p=new DatagramPacket(b,b.length,dst,5678);
			s.send(p);
		}catch (Exception e) {
			//TODO: handle exception
		}
	}
}

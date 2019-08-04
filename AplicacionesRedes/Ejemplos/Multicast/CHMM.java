import java.net.*;
import java.io.*;
//Como ejecutarlo: java -Djava.net.preferIPv4Stack=true MyProgram
class CHMM{
	public static void main(String[] args) {
		try{
			String dir="ff3e:40:2001::1";
			int pto=7778;
			MulticastSocket cl=new MulticastSocket(pto);
			cl.setReuseAddress(true);
			InetAddress gpo=InetAddress.getByName(dir);
			System.out.println("Servicio iniciado, preparando para unirse al grupo:"+gpo);
			cl.joinGroup(gpo);
			System.out.println("Unido al grupo:"+dir+" ...escuchando mensajes");
			for(;;){
				DatagramPacket p=new DatagramPacket(new byte[65535], 65535);
				cl.receive(p);
				System.out.println("Datagrama multicast recibido desde: "+p.getAddress()+": "+p.getPort()+"\nCon el mensaje: "+new String(p.getData(),0,p.getLength()));
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
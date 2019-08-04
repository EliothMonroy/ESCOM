import java.net.*;
import java.io.*;
public class SHMM{
	public static void main(String[] args) {
		try{
			MulticastSocket s=new MulticastSocket(7777);
			// InetAddress gpo=InetAddress.getByName("229.1.2.3");
			InetAddress gpo=InetAddress.getByName("ff3e:40:2001::1");
			s.setReuseAddress(true);
			s.setTimeToLive(255);//Número de saltos
			// s.joinGroup(gpo);
			System.out.println("Servicio multicast iniciado y unido a grupo: "+gpo);
			String msj="Un mensaje multicast";
			byte[] b=msj.getBytes();
			for(;;){
				DatagramPacket p=new DatagramPacket(b, b.length, gpo, 7778);
				s.send(p);
				System.out.println("Mensaje enviado");
				try{
					Thread.sleep(3000);
				}catch(InterruptedException ie){
					System.err.println(ie);
				}
			}
		}catch(Exception e){
			System.err.println(e);
		}
	}
}
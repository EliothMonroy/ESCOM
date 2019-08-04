import java.net.*;
import java.io.*;
public class Recibe{
	public static void main(String[] args) {
		try{
			int pto=5678;
			ServerSocket s = new ServerSocket(pto);
			System.out.println("Servidor iniciado, esperando clientes");
			for (;;){
				Socket cl=s.accept();
				DataInputStream dis = new DataInputStream(cl.getInputStream());
				String nombre=dis.readUTF()+"";
				System.out.println("Preparando para recibir el archivo: "+nombre+"\n");
				long tam=dis.readLong();
				long r=0;
				int n=0,p=0;
				DataOutputStream dos = new DataOutputStream(new FileOutputStream(nombre));
				while(r<tam){
					byte[] b=new byte[1500];
					n=dis.read(b);
					dos.write(b,0,n);
					dos.flush();
					r=r+n;
					p=(int)((r*100)/tam);
					System.out.print("\rrecibido el "+p+"%");
				}
				System.out.println("\nArchivo recibido");
				dos.close();
				dis.close();
				cl.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
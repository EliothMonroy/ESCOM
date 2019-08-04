import javax.swing.JFileChooser;
import java.net.*;
import java.io.*;
public class Envia{
	public static void main(String[] args) {
		try{
			int pto=5678;
			String host="127.0.0.1";
			JFileChooser jf = new JFileChooser();
			int r=jf.showOpenDialog(null);
			if (r==JFileChooser.APPROVE_OPTION) {
				File f=jf.getSelectedFile();
				String nombre=f.getName();
				long tam=f.length();
				String ruta=f.getAbsolutePath();
				Socket cl=new Socket(host,pto);
				System.out.println("Conexion establecida, se enviará el archivo"+ruta+"\n");
				long e=0;
				int n=0,p=0;
				DataOutputStream dos = new DataOutputStream(cl.getOutputStream());
				DataInputStream dis = new DataInputStream(new FileInputStream(ruta));
				dos.writeUTF(nombre);
				dos.flush();
				dos.writeLong(tam);
				dos.flush();
				while (e<tam){
					byte[] b=new byte[1500];
					n=dis.read(b);
					dos.write(b,0,n);
					dos.flush();
					e=e+n;
					p=(int)((e*100)/tam);
					System.out.print("\renviado el "+p+"%");
				}
				System.out.println("\nArchivo enviado");
				dos.close();
				dis.close();
				cl.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}

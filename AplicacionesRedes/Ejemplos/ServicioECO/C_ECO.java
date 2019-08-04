import java.net.*;
import java.io.*;
public class C_ECO{
	public static void main(String[] args) {
		try{
			int pto=1234;
			String host="localhost";
			Socket cl=new Socket(host,pto);
			System.out.println("Escribe un mensaje para enviar, 'Salir' para salir");
			BufferedReader br1=new BufferedReader(new InputStreamReader(System.in));
			PrintWriter pw=new PrintWriter(new OutputStreamWriter(cl.getOutputStream()));
			BufferedReader br2=new BufferedReader(new InputStreamReader(cl.getInputStream()));
			for(;;){
				String msj=br1.readLine();
				pw.println(msj);
				pw.flush();
				if(msj.compareToIgnoreCase("Salir")==0){
					System.out.println("Terminando aplicación");
					br1.close();
					br2.close();
					pw.close();
					cl.close();
					System.exit(0);
				}else{
					String re=br2.readLine();
					System.out.println("Mensaje respuesta: "+re);
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
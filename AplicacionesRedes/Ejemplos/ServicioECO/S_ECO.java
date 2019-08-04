import java.net.*;
import java.io.*;
public class S_ECO{
	public static void main(String[] args){
		try{
			int pto=1234;
			ServerSocket s=new ServerSocket(pto,2000);//backlog de 2000
			System.out.println("Server iniciado, esperando clientes");
			for (;;){
				Socket cl=s.accept();
				System.out.println("Cliente conectado, recibiendo mensaje");
				PrintWriter pw=new PrintWriter(new OutputStreamWriter(cl.getOutputStream()));
				BufferedReader br=new BufferedReader(new InputStreamReader(cl.getInputStream()));
				for(;;){
					String msj=br.readLine();
					System.out.println("Mensaje recibido:"+msj);
					if(msj.compareToIgnoreCase("Salir")==0){
						break;
					}else{
						msj=msj+" eco";
						pw.println(msj);
						pw.flush();
					}
				}
				br.close();
				pw.close();
				cl.close();
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}
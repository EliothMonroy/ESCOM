import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileWriter;
import java.io.PrintWriter;
import java.io.IOException;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.MalformedURLException;
import java.net.URL;
import java.util.ArrayList;
public class ManejadorURL extends Thread{
	URL url;
	String path;
	int nivel;
	InputStream is = null;
	BufferedReader br;
	String line;
	PrintWriter pw;
	ArrayList<String> porDescargar=new ArrayList<String>();
	ArrayList<String> descargadas=new ArrayList<String>();
	ArrayList<String> nombres=new ArrayList<String>();
	String aux[], aux2[];
	String nombre, line2="", direccion;
	public ManejadorURL(ArrayList<String> descargadas,String url, int nivel, String direccion){
		try{
			this.descargadas=descargadas;
			System.out.println("Voy a descargar: "+url);
			this.nivel=nivel;
			path=url;
			this.direccion=direccion;
			this.url=new URL(url);
			is = this.url.openStream();
			br = new BufferedReader(new InputStreamReader(is));
			pw=new PrintWriter(direccion,"UTF-8");
		}catch (Exception e) {
			//e.printStackTrace();
		}
	}
	@Override
	public void run() {
		try {
			descargadas.add(path);
			while ((line = br.readLine()) != null) {
				if ((line.contains("<link") && line.contains("stylesheet"))) {
					//System.out.println(line);
					line = manejarCSS(line);
					pw.println(line);
					pw.flush();

				} else if (line.contains("<script")) {
					//System.out.println(line);
					line = manejarJS(line);
					pw.println(line);
					pw.flush();

				} else if (line.contains("<a")) {
					//System.out.println(line);
					line = manejarLink(line);
					pw.println(line);
					pw.flush();

				} else{
					pw.println(line);
					pw.flush();
				}
			}
			descargar();
		}catch (Exception e) {
			//e.printStackTrace();
		}
	}
	public String manejarCSS(String line){
		line2="";
		aux=line.split(" ");
		for (int i=0; i<aux.length;i++) {
			if(aux[i].startsWith("href")){
				aux2=aux[i].split("\"");
				nombre=aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
				if(!aux2[1].startsWith("http")){
					aux2[1]=path+"/"+aux2[1];
				}
				nombre="css/"+nombre;
				agregarURL(aux2[1],nombre);
				//System.out.println(aux2[1]);
				if(aux2.length>2){
					line2+=aux2[0]+"\""+nombre+"\""+aux2[2];
				}else{
					line2+=aux2[0]+"\""+nombre+"\" ";
				}
			}else{
				line2+=aux[i]+" ";
			}
		}
		return line2;
	}
	public String manejarJS(String line){
		line2="";
		aux=line.split(" ");
		for (int i=0; i<aux.length;i++) {
			if(aux[i].startsWith("src")){
				aux2=aux[i].split("\"");
				nombre=aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
				if(!aux2[1].startsWith("http")){
					aux2[1]=path+"/"+aux2[1];
				}
				nombre="js/"+nombre;
				agregarURL(aux2[1],nombre);
				//System.out.println(aux2[1]);
				if(aux2.length>2){
					line2+=aux2[0]+"\""+nombre+"\""+aux2[2];
				}else{
					line2+=aux2[0]+"\""+nombre+"\" ";
				}
			}else{
				line2+=aux[i]+" ";
			}
		}
		return line2;
	}
	public String manejarLink(String line){
		line2="";
		aux=line.split(" ");
		for (int i=0; i<aux.length;i++) {
			if(aux[i].startsWith("href") && !aux[i].contains("#") && !aux[i].contains("?") && !aux[i].contains("href=\"\"") && !aux[i].contains("href=\"/\"")){
				aux2=aux[i].split("\"");
				if(aux2[1].endsWith("/")){
					//System.out.println("Tengo / al final");
					aux2[1]=aux2[1].substring(0,aux2[1].length()-1);
				}
				nombre=aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
				if(aux2[1].startsWith("http")){
					//Falta revisar si empieza con www
					agregarURL(aux2[1],nombre+".html");
					if(aux2.length>2){
						line2+=aux2[0]+"\""+nombre+".html\""+aux2[2];
					}else{
						line2+=aux2[0]+"\""+nombre+".html\" ";
					}
					//System.out.println(nombre);
				}else{
					agregarURL(path+"/"+nombre,nombre+".html");
					if(aux2.length>2){
						line2+=aux2[0]+"\""+nombre+".html\""+aux2[2];
					}else{
						line2+=aux2[0]+"\""+nombre+".html\" ";
					}
					//System.out.println(path+nombre);
				}
			}else{
				line2+=aux[i]+" ";
			}
		}
		return line2;
	}

	public void agregarURL(String url, String nombre) {
		if (!(descargadas.contains(url)) && !(nombres.contains("Pagina/"+nombre))){
			porDescargar.add(url);
			//System.out.println(porDescargar.size());
			nombres.add("Pagina/"+nombre);
			//System.out.println(url+"\t"+nombre);
		}
	}
	public void descargar(){
		if(nivel<2){
			ManejadorURL hilos[]=new ManejadorURL[porDescargar.size()+100];
			for (int i=0;i<porDescargar.size();i++){
				//System.out.println(porDescargar.size());
				hilos[i]=new ManejadorURL(descargadas,porDescargar.remove(0),nivel+1,nombres.remove(0));
				hilos[i].start();
				try{
					hilos[i].join();
				}catch (Exception e){
					e.printStackTrace();
				}
				for(int j=0;j<hilos[i].porDescargar.size();j++){
					porDescargar.add(hilos[i].porDescargar.remove(0));
					nombres.add(hilos[i].nombres.remove(0));
				}
				for(int j=0;j<hilos[i].descargadas.size();j++){
					descargadas.add(hilos[i].descargadas.remove(0));
				}
			}
		}else{
			porDescargar.remove(path);
			nombres.remove(direccion);
		}

		//System.out.println("Termine hilo");
	}
}

import java.io.BufferedReader;
import java.io.PrintWriter;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.net.URL;
import java.util.ArrayList;
import java.io.File;
public class ManejadorURL_NF extends Thread{
    URL url;
    String path;
    int nivel;
    InputStream is = null;
    String nombre_carpeta="";
    String root="/Users/eliothmonroy/Documents/Github/AplicacionesRedes/Examenes/2doParcial/Pagina/";
    BufferedReader br;
    String line;
    PrintWriter pw;
    ArrayList<String> porDescargar=new ArrayList<String>();
    ArrayList<String> descargadas=new ArrayList<String>();
    ArrayList<String> nombres=new ArrayList<String>();
    String aux[], aux2[];
    String nombre, line2="", direccion;
    public ManejadorURL_NF(ArrayList<String> descargadas,String url, int nivel, String direccion){
        try{
        	line="";
            this.descargadas=descargadas;
            System.out.println("Voy a descargar: "+url);
            this.nivel=nivel;
            path=url;
            this.direccion=direccion;
            this.url=new URL(url);
            is = this.url.openStream();
            br = new BufferedReader(new InputStreamReader(is));
            pw=new PrintWriter(direccion,"UTF-8");
	        //this.descargadas.add(path);
        }catch (Exception e) {
            //e.printStackTrace();
	        //System.exit(0);
        }
    }
    @Override
    public void run() {
        try {
	        descargadas.add(path);
            if(!path.endsWith(".js") && !path.endsWith(".css")){
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
            }else{
	            while ((line = br.readLine()) != null) {
		            pw.println(line);
		            pw.flush();
	            }
            }
        }catch (Exception e) {
        	System.out.println("Tuve problemas para descargar: "+path);
            //e.printStackTrace();
            //System.exit(0);
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
                nombre=root+"css/"+nombre;
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
                nombre=root+"js/"+nombre;
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
        try{
            int contador=0;
            aux=line.split(" ");
            for (int i=0; i<aux.length;i++) {
            	contador=0;
                if(aux[i].startsWith("href") && !aux[i].contains("#") && !aux[i].contains("?") && !aux[i].contains("href=\"\"") && !aux[i].contains("href=\"/\"") && !aux[i].contains("logo") && !aux[i].contains("mailto") && !aux[i].endsWith("=\"") && !aux[i].contains(":") && !aux[i].contains("!")){
                	if (aux[i].contains("'")){
		                aux2=aux[i].split("'");
	                }else{
		                aux2=aux[i].split("\"");
	                }
                    if(aux2[1].endsWith("/")){
                        //System.out.println("Tengo / al final");
                        aux2[1]=aux2[1].substring(0,aux2[1].length()-1);
                    }
                    for( int k=0; k<aux2[1].length(); k++ ) {
                        if( aux2[1].charAt(k) == '/' ) {
                            contador++;
                        }
                    }
                    //System.out.println(aux2[1]);
                    if (contador>3) {
                        //Hay que crear una carpeta
	                    String aux4=aux2[1].substring(0,aux2[1].lastIndexOf("/"));
                        String aux3=aux4.substring(aux4.lastIndexOf("/"));
	                    nombre_carpeta=aux3.substring(aux3.lastIndexOf("/")+1);
                        if(nombre_carpeta.startsWith("/")){
                        	nombre_carpeta=nombre_carpeta.substring(1);
                        }
                        nombre=root+nombre_carpeta+aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
                    }else{
                        nombre=root+aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
                    }
                    if(!nombres.contains(nombre) && nombre_carpeta!=null && nombre_carpeta!=""){
                    	//System.out.println("Nombre carpeta: "+nombre_carpeta);
	                    //System.out.println("Nombre archivo: "+nombre);
	                   new File(root+nombre_carpeta).mkdirs();
                    }
                    //nombre=aux2[1].substring((aux2[1].lastIndexOf("/"))+1);
                    if(aux2[1].startsWith("http")){
                        agregarURL(aux2[1],nombre+".html");
                        if(aux2.length>2){
                            line2+=aux2[0]+"\""+nombre+".html\""+aux2[2]+" ";
                        }else{
                            line2+=aux2[0]+"\""+nombre+".html\" ";
                        }
                        //System.out.println(nombre);
                    }else{
                        agregarURL(path+aux2[1],nombre+".html");
                        if(aux2.length>2){
                            line2+=aux2[0]+"\""+nombre+".html\""+aux2[2]+" ";
                        }else{
                            line2+=aux2[0]+"\""+nombre+".html\" ";
                        }
                        //System.out.println(path+nombre);
                    }
                }else{
                    line2+=aux[i]+" ";
                }
            }
        }catch (Exception e){
            //e.printStackTrace();
            System.out.println(line);
            //System.exit(0);
        }
        return line2;
    }

    public void agregarURL(String url, String nombre) {
        if (!(descargadas.contains(url)) && !(nombres.contains(nombre)) && !(porDescargar.contains(url))){
            porDescargar.add(url);
            //System.out.println(porDescargar.size());
            nombres.add(nombre);
            //System.out.println(url+"\t"+nombre);
        }
    }
    public void descargar(){
        if(nivel<2){
            ManejadorURL hilos[]=new ManejadorURL[porDescargar.size()];
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
            //porDescargar.remove(path);
            //nombres.remove(direccion);
        }

        //System.out.println("Termine hilo");
    }
}
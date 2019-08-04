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
import java.util.LinkedList;
public class Descargador extends Thread{
    URL url;
    InputStream is = null;
    BufferedReader br;
    String line;
    PrintWriter pw;
    public ManejadorURL(String url){
        try{
            this.url=new URL(url);
            is = this.url.openStream();
            br = new BufferedReader(new InputStreamReader(is));
            pw=new PrintWriter("Pagina/index.html","UTF-8");
        }catch (Exception e) {
            e.printStackTrace();
        }
    }
    public void iniciar(){
        try{
            while ((line = br.readLine()) != null) {
                if (line.contains("<link") && line.contains("stylesheet")){
                    descargarCSS();

                    System.out.println(line);
                }else if (line.contains("<script")){
                    System.out.println(line);
                }else if (line.contains("<a")){
                    System.out.println(line);
                }else if(line.contains("<img")){
                    System.out.println(line);
                }else{
                    pw.println(line);
                    pw.flush();
                }
            }
        }catch (Exception e){
            e.printStackTrace();
        }

    }
}
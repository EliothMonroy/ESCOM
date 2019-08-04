import javax.swing.JFrame;
import javax.swing.JOptionPane;
import java.util.ArrayList;
public class Principal {
    public static void main(String args[]){
        JFrame frame=new JFrame("Descargador de pagínas");
        String url=JOptionPane.showInputDialog(frame,"Ingresa la página a descargar");
        //String url="https://www.last.fm/user/DjElith";
        ArrayList<String> nada=new ArrayList<String>();
        ManejadorURL manejador=new ManejadorURL(nada,url,1,"Pagina/index.html");
        manejador.start();
        try{
			manejador.join();
        }catch (Exception e){

        }
        //System.exit(0);
    }
}
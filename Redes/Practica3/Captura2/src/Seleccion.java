
import java.io.File;
import javax.swing.JFileChooser;
import javax.swing.filechooser.FileNameExtensionFilter;




public class Seleccion {
    
    public static void main(String[] args){
      JFileChooser fileChooser = new JFileChooser(); 
      FileNameExtensionFilter extension = new FileNameExtensionFilter("archivos pcap (*.pcap)", "pcap");
            fileChooser.setFileFilter(extension);
            fileChooser.setDialogTitle("Abrir archivo");
 // set selected filter
        fileChooser.setFileFilter(extension);
      int resultado = fileChooser.showOpenDialog(null);
      if(resultado==JFileChooser.APPROVE_OPTION){
          File f = fileChooser.getSelectedFile();
          System.out.println("Archivo seleccionado: "+f.getAbsolutePath());
      }
    }//main

}

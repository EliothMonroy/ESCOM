import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStreamReader;
import java.net.InetAddress;
import java.net.NetworkInterface;
import java.nio.ByteBuffer;  
import java.util.ArrayList;  
import java.util.Arrays;  
import java.util.Collections;
import java.util.Date;
import java.util.Enumeration;
import java.util.Iterator;
import java.util.List;  
  
import org.jnetpcap.Pcap;  
import org.jnetpcap.PcapAddr;
import org.jnetpcap.PcapBpfProgram;
import org.jnetpcap.PcapIf;  
import org.jnetpcap.PcapSockAddr;
import org.jnetpcap.packet.PcapPacket;
import org.jnetpcap.packet.PcapPacketHandler;
  
public class Envia {  
    
    private static String asString(final byte[] mac) {
    final StringBuilder buf = new StringBuilder();
    for (byte b : mac) {
      if (buf.length() != 0) {
        buf.append(':');
      }
      if (b >= 0 && b < 16) {
        buf.append('0');
      }
      buf.append(Integer.toHexString((b < 0) ? b + 256 : b).toUpperCase());
    }

    return buf.toString();
  }
    
  public static void main(String[] args) {  
    List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs  
    StringBuilder errbuf = new StringBuilder(); // For any error msgs  
    String ip_interfaz="";
   /***************************************************************************
		 * First get a list of devices on this system
		 **************************************************************************/
		int r = Pcap.findAllDevs(alldevs, errbuf);
		if (r == Pcap.NOT_OK || alldevs.isEmpty()) {
			System.err.printf("Can't read list of devices, error is %s", errbuf
			    .toString());
			return;
		}

		System.out.println("Dispositivos encontrados:");
		int i = 0;
                try{
		for (PcapIf device : alldevs) {
			String description =
			    (device.getDescription() != null) ? device.getDescription()
			        : "No description available";
                        final byte[] mac = device.getHardwareAddress();
			String dir_mac = (mac==null)?"No tiene direccion MAC":asString(mac);
                        System.out.printf("\n#%d: %s [%s] MAC:[%s]\n", i++, device.getName(), description, dir_mac);
                        Iterator<PcapAddr> it = device.getAddresses().iterator();
                        while(it.hasNext()){
                            PcapAddr dir = it.next();//dir, familia, mascara,bc
                            PcapSockAddr direccion =dir.getAddr();
                            byte[]d_ip = direccion.getData();
                            int familia=direccion.getFamily();
                            int[]ipv4 = new int[4];
                            if(familia==org.jnetpcap.PcapSockAddr.AF_INET){
                                ipv4[0]=((int)d_ip[0]<0)?((int)d_ip[0])+256:(int)d_ip[0];
                                ipv4[1]=((int)d_ip[1]<0)?((int)d_ip[1])+256:(int)d_ip[1];
                                ipv4[2]=((int)d_ip[2]<0)?((int)d_ip[2])+256:(int)d_ip[2];
                                ipv4[3]=((int)d_ip[3]<0)?((int)d_ip[3])+256:(int)d_ip[3];
                                
                                System.out.println("\nIP4->"+ipv4[0]+"."+ipv4[1]+"."+ipv4[2]+"."+ipv4[3]);
                            }else if(familia==org.jnetpcap.PcapSockAddr.AF_INET6){
                                System.out.print("\nIP6-> ");
                                for(int z=0;z<d_ip.length;z++)
                                    System.out.printf("%02X:",d_ip[z]);
                            }//if
                        }//while
		}//for
                }catch(IOException io){
                  io.printStackTrace();
                }//catch
   try{
       BufferedReader br = new BufferedReader(new InputStreamReader(System.in));
       System.out.print("\nElije la interfaz de red: ");
       int interfaz = Integer.parseInt(br.readLine());
    PcapIf device = alldevs.get(interfaz); // We know we have atleast 1 device  
       /******************************************************/
        Iterator<PcapAddr> it1 = device.getAddresses().iterator();
        while(it1.hasNext()){
         PcapAddr dir = it1.next();//dir, familia, mascara,bc
         PcapSockAddr direccion1 =dir.getAddr();
         byte[]d_ip = direccion1.getData(); //esta sera la ip origen
         int familia=direccion1.getFamily();
         int[]ipv4_1 = new int[4];
         if(familia==org.jnetpcap.PcapSockAddr.AF_INET){
            ipv4_1[0]=((int)d_ip[0]<0)?((int)d_ip[0])+256:(int)d_ip[0];
            ipv4_1[1]=((int)d_ip[1]<0)?((int)d_ip[1])+256:(int)d_ip[1];
            ipv4_1[2]=((int)d_ip[2]<0)?((int)d_ip[2])+256:(int)d_ip[2];
            ipv4_1[3]=((int)d_ip[3]<0)?((int)d_ip[3])+256:(int)d_ip[3];
            ip_interfaz = ipv4_1[0]+"."+ipv4_1[1]+"."+ipv4_1[2]+"."+ipv4_1[3];  
            System.out.println("\nInterfaz que se usara:"+ip_interfaz);
            System.out.println("-------------------------> Inicio del Envio de Datos >--------------------------------\n\n");
        }
        }
       /******************************************************/
       System.out.print("MAC ORIGEN: ");   
       byte[] MACo = device.getHardwareAddress();
       for(int j=0;j<MACo.length;j++)
    System.out.printf("%02X ",MACo[j]); 
        
    /***************************************** 
     * Second we open a network interface 
     *****************************************/  
    int snaplen = 64 * 1024; // Capture all packets, no trucation  
    int flags = Pcap.MODE_PROMISCUOUS; // capture all packets  
    int timeout = 10 * 1000; // 10 seconds in millis  
    Pcap pcap = Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);  
  
  
    /******************************************************* 
     * Third we create our crude packet we will transmit out 
     * This creates a broadcast packet 
     *******************************************************/  
    byte[] trama = new byte[1500];
   
    for(int k=0;k<MACo.length;k++){
        trama[k] = (byte) 0xff;
        trama[k+6]=MACo[k];
    }

    trama[12]= (byte) 0x16; //tipo sin asignar
    trama[13]= (byte) 0x01; //tipo sin asignar rfc 1340 
    
    
    /////////////////Abre Archivo
    
    File archivo = null;
    FileReader frr = null;
    BufferedReader brr;
    brr = null;
  
    try {
        archivo = new File ("C:\\Users\\alumno\\Desktop\\TEXTO.txt");
        frr = new FileReader (archivo);
        brr = new BufferedReader(frr);
        // Lectura del fichero
        FileInputStream ficheroStream = new FileInputStream(archivo);
        byte contenido[] = new byte[(int)archivo.length()]; 
        ficheroStream.read(contenido);

        }catch(Exception e){
            e.printStackTrace();
        }finally{
            try{                    
                if( null != frr ){   
                    frr.close();     
                }                  
            }catch (Exception e2){ 
                e2.printStackTrace();
            }
        }

    String linea=new String(contenido);
    
    System.out.println(linea);
    
    String mensaje= "Un breve mensaje";
    
    byte[]buf = mensaje.getBytes();
    int tam = buf.length;
    if(tam<50){
    for(int c=0;c<tam;c++)
        trama[14+c]=buf[c];
    }else{
        System.out.println("El mensaje es muy largo... maximo 50 bytes");
        System.exit(1);
    }  
    
    ///se define la MAC a la que se envira
    trama[0]= (byte) 0xD8;
    trama[1]= (byte) 0xCB;
    trama[2]= (byte) 0x8A;
    trama[3]= (byte) 0xD2;
    trama[4]= (byte) 0x84;
    trama[5]= (byte) 0xC9;
    
    //Arrays.fill(a, (byte) 0xff);  
    ByteBuffer b = ByteBuffer.wrap(trama);  
  
    
  
    
  
    /********F I L T R O********/
            PcapBpfProgram filter = new PcapBpfProgram();
            String expression ="ether proto 0x1601"; // "port 80";
            int optimize = 0; // 1 means true, 0 means false
            int netmask = 0;
            int r2 = pcap.compile(filter, expression, optimize, netmask);
            if (r2 != Pcap.OK) {
                System.out.println("Filter error: " + pcap.getErr());
            }//if
            pcap.setFilter(filter);
    PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {

			
        public void nextPacket(PcapPacket packet, String user) {

				System.out.printf("Paquete recibido el %s bytes capturados=%-4d tam original=%-4d %s\n\n",
				    new Date(packet.getCaptureHeader().timestampInMillis()),
				    packet.getCaptureHeader().caplen(),  // Length actually captured
				    packet.getCaptureHeader().wirelen(), // Original length
				    user                                 // User supplied object
				    );
                                /******Desencapsulado********/
                                System.out.print("MAC destino: ");
                                for(int i=0;i<6;i++){
                                System.out.printf("%02X ",packet.getUByte(i));
                                }
                                
                                System.out.println("");
      
                                System.out.print("MAC origen: ");
                                for(int i=6;i<12;i++){
                                System.out.printf("%02X ",packet.getUByte(i));
                                }
                                
                                System.out.println("");
          
                                System.out.print("Tipo: ");
                                for(int i=12;i<14;i++){
                                System.out.printf("%02X ",packet.getUByte(i));
                                }
                                
                                System.out.println("");
                                
                                int tipo = (packet.getUByte(12)*256)+packet.getUByte(13);
                                
                                System.out.printf("Tipo Valor: %d \n",tipo);
                                
                                if(tipo==5633){ //0x1601

                                System.out.print("\n-------> Mensaje que se envio, con los datos: \n");
                                   
                                byte[]t = packet.getByteArray(14, 50);
                                   
                                for(int k=0;k<t.length;k++){
                                    System.out.printf("%02X ",t[k]);
                                }
                                
                                System.out.print("\n-------> Mensaje que se envio, con los datos codificados: \n");
                                        
                                String datos = new String(t);
                                System.out.println(datos+"\n\n");

                                for(int l=0;l<packet.size();l++){
                                System.out.printf("%02X ",packet.getUByte(l));
                                if(l%16==15)
                                    System.out.println("");
                                }
                                
                                System.out.printf("//////////////////////////////////////////////////\n\n");


                                }//if
                                
                                //System.out.println("\n\nEncabezado: "+ packet.toHexdump());
      

			}
		};
    //pcap.loop(1, jpacketHandler, "");
    /******************************************************* 
     * Fourth We send our packet off using open device 
     *******************************************************/  
    for(int zz=0;zz<10;zz++){
        //if (pcap.sendPacket(b) != Pcap.OK) {  
//        if(pcap.inject(b)<0){
            if (pcap.sendPacket(trama) != Pcap.OK) {  
          System.err.println(pcap.getErr());  
        }
            System.out.println("---------> Envie un Paquete <--------- \n");
        try{
            Thread.sleep(500);
        }catch(InterruptedException e){}
        pcap.loop(1, jpacketHandler, "");
    }//for
    /******************************************************** 
     * Lastly we close 
     ********************************************************/  
    pcap.close();  
    
   }catch(Exception e){
       e.printStackTrace();
   }//catch
  }  
} 
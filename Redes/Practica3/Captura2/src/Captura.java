import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.*;

import org.jnetpcap.Pcap;
import org.jnetpcap.PcapAddr;
import org.jnetpcap.PcapIf;
import org.jnetpcap.packet.PcapPacket;
import org.jnetpcap.packet.PcapPacketHandler;
import org.jnetpcap.PcapBpfProgram;
import org.jnetpcap.protocol.lan.Ethernet;
import org.jnetpcap.protocol.tcpip.*;
import org.jnetpcap.protocol.network.*;
import org.jnetpcap.nio.JBuffer;
import org.jnetpcap.packet.Payload;
import org.jnetpcap.protocol.network.Arp;
import org.jnetpcap.protocol.lan.IEEE802dot2;
import org.jnetpcap.protocol.lan.IEEE802dot3;


public class Captura {

	/**
	 * Main startup method
	 *
	 * @param args
	 *          ignored
	 */
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
            Pcap pcap=null;
               try{
                BufferedReader br = new BufferedReader(new InputStreamReader(System.in));   
		List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs
		StringBuilder errbuf = new StringBuilder(); // For any error msgs
                System.out.println("[0]-->Realizar captura de paquetes al vuelo");
                System.out.println("[1]-->Cargar traza de captura desde archivo");
                System.out.print("\nElige una de las opciones:");
                int opcion = Integer.parseInt(br.readLine());
                if (opcion==1){
                    
                    /////////////////////////lee archivo//////////////////////////
                //String fname = "archivo.pcap";
                String fname = "paquetes3.pcap";
                pcap = Pcap.openOffline(fname, errbuf);
                if (pcap == null) {
                  System.err.printf("Error while opening device for capture: "+ errbuf.toString());
                  return;
                 }//if
                } else if(opcion==0){
		/***************************************************************************
		 * First get a list of devices on this system
		 **************************************************************************/
		int r = Pcap.findAllDevs(alldevs, errbuf);
		if (r == Pcap.NOT_OK || alldevs.isEmpty()) {
			System.err.printf("Can't read list of devices, error is %s", errbuf
			    .toString());
			return;
		}

		System.out.println("Network devices found:");

		int i = 0;
		for (PcapIf device : alldevs) {
			String description =
			    (device.getDescription() != null) ? device.getDescription()
			        : "No description available";
                        final byte[] mac = device.getHardwareAddress();
			String dir_mac = (mac==null)?"No tiene direccion MAC":asString(mac);
                        System.out.printf("#%d: %s [%s] MAC:[%s]\n", i++, device.getName(), description, dir_mac);
                        List<PcapAddr> direcciones = device.getAddresses();
                        for(PcapAddr direccion:direcciones){
                            System.out.println(direccion.getAddr().toString());
                        }//foreach

		}//for
                
                System.out.print("\nEscribe el número de interfaz a utilizar:");
                int interfaz = Integer.parseInt(br.readLine());
		PcapIf device = alldevs.get(interfaz); // We know we have atleast 1 device
		System.out
		    .printf("\nChoosing '%s' on your behalf:\n",
		        (device.getDescription() != null) ? device.getDescription()
		            : device.getName());
                
		/***************************************************************************
		 * Second we open up the selected device
		 **************************************************************************/
                /*"snaplen" is short for 'snapshot length', as it refers to the amount of actual data captured from each packet passing through the specified network interface.
                64*1024 = 65536 bytes; campo len en Ethernet(16 bits) tam máx de trama */

		int snaplen = 64 * 1024;           // Capture all packets, no trucation
		int flags = Pcap.MODE_PROMISCUOUS; // capture all packets
		int timeout = 10 * 1000;           // 10 seconds in millis

                
                pcap = Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);

		if (pcap == null) {
			System.err.printf("Error while opening device for capture: "
			    + errbuf.toString());
			return;
		}//if
                  
                       /********F I L T R O********/
            PcapBpfProgram filter = new PcapBpfProgram();
            String expression =""; // "port 80";
            int optimize = 0; // 1 means true, 0 means false
            int netmask = 0;
            int r2 = pcap.compile(filter, expression, optimize, netmask);
            if (r2 != Pcap.OK) {
                System.out.println("Filter error: " + pcap.getErr());
            }//if
            pcap.setFilter(filter);
                /****************/
            }//else if

		/***************************************************************************
		 * Third we create a packet handler which will receive packets from the
		 * libpcap loop.
		 **********************************************************************/
		PcapPacketHandler<String> jpacketHandler = new PcapPacketHandler<String>() {

			public void nextPacket(PcapPacket packet, String user) {

				System.out.printf("\n\nPaquete recibido el %s caplen=%-4d longitud=%-4d %s\n\n",
				    new Date(packet.getCaptureHeader().timestampInMillis()),
				    packet.getCaptureHeader().caplen(),  // Length actually captured
				    packet.getCaptureHeader().wirelen(), // Original length
				    user                                 // User supplied object
				    );
                                
                                
                                /******Desencapsulado********/
                                for(int i=0;i<packet.size();i++){
                                System.out.printf("%02X ",packet.getUByte(i));
                                
                                if(i%16==15)
                                    System.out.println("");
                                }//if
                                
                                int longitud = (packet.getUByte(12)*256)+packet.getUByte(13);
                                System.out.printf("\nLongitud: %d (%04X)",longitud,longitud );
                                if(longitud<1500){
                                    System.out.println("--->Trama IEEE802.3");
                                    System.out.printf(" |-->MAC Destino: %02X:%02X:%02X:%02X:%02X:%02X",packet.getUByte(0),packet.getUByte(1),packet.getUByte(2),packet.getUByte(3),packet.getUByte(4),packet.getUByte(5));
                                    System.out.printf("\n |-->MAC Origen: %02X:%02X:%02X:%02X:%02X:%02X",packet.getUByte(6),packet.getUByte(7),packet.getUByte(8),packet.getUByte(9),packet.getUByte(10),packet.getUByte(11));
                                    System.out.printf("\n |-->Longitud: %02X%02X",packet.getUByte(12),packet.getUByte(13));
                                    int longi =(packet.getUByte(12)*256) + packet.getUByte(13);
                                    System.out.printf("\n |-->Longitud Valor: %d",longi);                               
                                    System.out.printf("\n |-->DSAP: %02X",packet.getUByte(14));
                                    //System.out.println(packet.getUByte(15)& 0x00000001);
                                    int ssap = packet.getUByte(15)& 0x00000001;
                                    
                                    String c_r ="";
                                    
                                    if(ssap==1){
                                       c_r = "Comando";
                                    }else if(ssap==0){
                                       c_r = "Otro";
                                    }
                                    
                                    int Control;
                                    int ValorControl;
                                   
                                    System.out.printf("\n |-->SSAP: %02X   %s",packet.getUByte(15), c_r);
                                    if(longi>3){
                                        System.out.printf("\n |-->Control de 2 Bytes: %02X%02X ",packet.getUByte(16),packet.getUByte(17));
                                        Control = 2;
                                        ValorControl=(packet.getUByte(16)*256)+packet.getUByte(17);
                                        
                                    }else{
                                        System.out.printf("\n |-->Control de 1 Byte: %02X",packet.getUByte(16));
                                        Control = 1;
                                        ValorControl=packet.getUByte(16);
                                    }
                                    
                                    System.out.printf("\n |-->ValorControl: %d",ValorControl);
                                    
                                    String Binaryo=obtenerBinario(ValorControl);
                                    
                                    System.out.printf("\n |-->Valor en Binario: %s",Binaryo);
                                    
                                    Binaryo =  reverse(Binaryo);
                                    
                                     System.out.printf("\n |-->Valor en Binario Invertido: %s",Binaryo);
                                String aux="";
                                if(Control==1){
                                    aux=String.valueOf(Binaryo.charAt(0));
                                }else{
                                    aux=String.valueOf(Binaryo.charAt(0))+String.valueOf(Binaryo.charAt(1));
                                }
                                     

                                    
                                                              
                                } else if(longitud>=1500){
                                    System.out.println("-->Trama Ethernet");
                                }//else
                                
                                
                                //System.out.println("\n\nEncabezado: "+ packet.toHexdump());
      

			}
		};


		/***************************************************************************
		 * Fourth we enter the loop and tell it to capture 10 packets. The loop
		 * method does a mapping of pcap.datalink() DLT value to JProtocol ID, which
		 * is needed by JScanner. The scanner scans the packet buffer and decodes
		 * the headers. The mapping is done automatically, although a variation on
		 * the loop method exists that allows the programmer to sepecify exactly
		 * which protocol ID to use as the data link type for this pcap interface.
		 **************************************************************************/
		pcap.loop(-1, jpacketHandler, " ");

		/***************************************************************************
		 * Last thing to do is close the pcap handle
		 **************************************************************************/
		pcap.close();
                }catch(IOException e){e.printStackTrace();}
	}
        
        public static String obtenerBinario(int numero){
   ArrayList<String> binario = new ArrayList<String>();
   int resto;
   String binarioString = "";

   do{
      resto = numero%2;
      numero = numero/2;
      binario.add(0, Integer.toString(resto));
   }while(numero > 2); //Haremos el bucle hasta que el cociente no se pueda dividir mas

   binario.add(0, Integer.toString(numero)); //Cogeremos el ultimo cociente

   //Cogemos cada uno de los elementos del ArrayList y los juntamos en un String
   for(int i = 0; i < binario.size(); i++){
       binarioString += binario.get(i);
   }
   return binarioString;
 }
        
        public static String reverse(String input){
    char[] in = input.toCharArray();
    int begin=0;
    int end=in.length-1;
    char temp;
    while(end>begin){
        temp = in[begin];
        in[begin]=in[end];
        in[end] = temp;
        end--;
        begin++;
    }
    return new String(in);
}

        
        
}


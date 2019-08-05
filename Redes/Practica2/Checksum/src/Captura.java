import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.io.*;

import org.jnetpcap.Pcap;
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
		List<PcapIf> alldevs = new ArrayList<PcapIf>(); // Will be filled with NICs
		StringBuilder errbuf = new StringBuilder(); // For any error msgs

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
                try{
		for (PcapIf device : alldevs) {
			String description =
			    (device.getDescription() != null) ? device.getDescription()
			        : "No description available";
                        final byte[] mac = device.getHardwareAddress();
			String dir_mac = (mac==null)?"No tiene direccion MAC":asString(mac);
                        System.out.printf("#%d: %s [%s] MAC:[%s]\n", i++, device.getName(), description, dir_mac);

		}//for

		PcapIf device = alldevs.get(0); // We know we have atleast 1 device
		System.out
		    .printf("\nSeleccionando su tarjeta de red:  '%s'\n\n",
		        (device.getDescription() != null) ? device.getDescription()
		            : device.getName());

		/***************************************************************************
		 * Second we open up the selected device
		 **************************************************************************/
                /*"snaplen" is short for 'snapshot length', as it refers to the amount of actual data captured from each packet passing through the specified network interface.
                64*1024 = 65536 bytes; campo len en Ethernet(16 bits) tam mÃ¡x de trama */

		int snaplen = 64 * 1024;           // Capture all packets, no trucation
		int flags = Pcap.MODE_PROMISCUOUS; // capture all packets
		int timeout = 10 * 1000;           // 10 seconds in millis
                Pcap pcap =
		    Pcap.openLive(device.getName(), snaplen, flags, timeout, errbuf);

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


		/***************************************************************************
		 * Third we create a packet handler which will receive packets from the
		 * libpcap loop.
		 **********************************************************************/
		PcapPacketHandler<String> jpacketHandler;
                    jpacketHandler = new PcapPacketHandler<String>() {
                        
                        public void nextPacket(PcapPacket packet, String user) {
                            
                            System.out.printf("Recibiendo paquete, fecha:  %s caplen=%-4d len=%-4d %s\n",
                                    new Date(packet.getCaptureHeader().timestampInMillis()),
                                    packet.getCaptureHeader().caplen(),  // Length actually captured
                                    packet.getCaptureHeader().wirelen(), // Original length
                                    user                                 // User supplied object
                            );
                            /******Desencapsulado********/
                            System.out.printf("------------------------------------------------\n");
                            for(int i=0;i<packet.size();i++){
                                System.out.printf("%02X ",packet.getUByte(i));
                                if(i%16==15)
                                    System.out.println("");
                            }
                            System.out.println("\n\nEncabezado: "+ packet.toHexdump());
                            
                            //Despues de recibir el encabezado de la trama, tenemos que verificar
                            //que tipo de trama es, los bits 13 y 14 lo dicen;
                            
                            int tipo = (packet.getUByte(12)*256) + packet.getUByte(13);
                            System.out.println("Tipo de trama: "+ tipo);
                            
                            //Ahora si la trama es mayor a 1500, se puede calcular si es IP, y si es menor ieee
                            
                            if (tipo>=1500){
                                System.out.println("---> Es una trama Ethernet <----");
                                if (tipo==2048){
                                    System.out.println("---> Es una trama IP <----");
                                    
                                    int IHL= packet.getUByte(14);
                                    IHL=(IHL&0x0F)*4;
                                    int longitud = (packet.getUByte(16)*256) + packet.getUByte(17);
                                    longitud-=IHL;
                                    int longitud2=longitud;
                                    int bytesEncIP=longitud;
                                    System.out.println(longitud+" bytes conforman el Encabezado IP");
                                    System.out.println("IHL:"+IHL+" bytes.");

                                    //Trama a ser enviada para calcular checksum
                                    byte trama []= new byte [10+IHL+longitud];
                                    int i;
                                    //IP origen e IP destino
                                    for(i=0;i<6;i++){
                                        trama[i]=(byte)packet.getUByte(i+26);
                                    }
                                    //Byte de ceros
                                    trama[i]=0;
                                    i++;
                                    //Protocolo
                                    trama[i]=(byte)packet.getUByte(23);
                                    i++;
                                    //Longitud
                                    longitud=longitud/256;
                                    longitud=(longitud&0x0000FF);
                                    trama[i]=(byte)longitud;
                                    i++;
                                    trama[i]=(byte)(longitud2&0x000000FF);
                                    i++;

                                    /*Concatenamos los bytes que se van a sumar para calcular checksum
                                    (valor de IHL)*/
                                    for(int aux=0;aux<IHL;aux++,i++){
                                        trama[i]=(byte)packet.getUByte(aux+14);
                                    }

                                    //Concatenamos los bytes del encabezado IP
                                    for(int l=0;l<bytesEncIP;l++,i++){
                                        trama[i]=(byte)packet.getUByte(l+14+IHL);
                                    }
                                    
                                    System.out.println("");
                                    System.out.println("Trama a ser enviada al metodo Checksum:");
                                    for (int cont = 0; cont < trama.length; cont++) {
                                        System.out.printf("%02X ", trama[cont]);
                                        if (cont % 16 == 15) {
                                            System.out.println("");
                                        }
                                    }
                                    System.out.println("\n");
                                    /*Llamamos al metodo que calcula el checksum, enviando como parametro
                                    la cadena de byres que hemos creado: trama*/
                                    long ChkSum=Checksum.calculateChecksum(trama);
                                    System.out.printf("Checksum calculado: %02X \n\n",ChkSum);
                                    
                                    
                                    
                                }else{
                                    System.out.println("---> NO es una trama IP <----");
                                }
                            }else{
                                System.out.println("Es una trama IEEE802.3");
                            }
                            
                            System.out.printf("------------------------------------------------\n\n");
                            
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
		pcap.loop(10, jpacketHandler, "<---------- Trama recibida");

		/***************************************************************************
		 * Last thing to do is close the pcap handle
		 **************************************************************************/
		pcap.close();
                }catch(IOException e){e.printStackTrace();}
	}
}
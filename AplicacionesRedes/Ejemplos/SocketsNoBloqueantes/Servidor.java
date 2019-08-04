package Ejemplos.SocketsNoBloqueantes;
import java.net.InetSocketAddress;
import java.net.StandardSocketOptions;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.ServerSocketChannel;
import java.nio.channels.SocketChannel;
import java.util.Iterator;

public class Servidor {
	public static void main(String args[]){
		try{
			ServerSocketChannel s=ServerSocketChannel.open();
			s.configureBlocking(false);
			s.setOption(StandardSocketOptions.SO_REUSEADDR,true);
			int pto=1234;
			InetSocketAddress p= new InetSocketAddress(pto);
			s.bind(p);
			Selector sel=Selector.open();
			s.register(sel, SelectionKey.OP_ACCEPT);
			for (;;){
				sel.select();
				Iterator<SelectionKey> it=sel.selectedKeys().iterator();
				while (it.hasNext()){
					SelectionKey k=(SelectionKey)it.next();
					//Quitamos el iterador
					it.remove();
					//Intento de conexión
					if (k.isAcceptable()){
						SocketChannel cl=s.accept();
						System.out.println("Cliente conectado desde: "+cl.socket().getInetAddress()+":"+cl.socket().getPort());
						cl.configureBlocking(false);
						cl.register(sel,SelectionKey.OP_READ|SelectionKey.OP_WRITE);
						continue;
					}else if (k.isReadable()){
						//Un cliente ya conectado quiere leer
						SocketChannel cl=(SocketChannel) k.channel();
						//Especificamos el tamaño de lo que vamos a leer
						ByteBuffer b=ByteBuffer.allocate(100);
						int n=cl.read(b);
						b.clear();
						if (b.hasArray()){
							String msj=new String(b.array(),0,n);
							System.out.println(msj);
						}
						continue;
					}else if (k.isWritable()){
						//Un cliente ya conectado quiere recibir un mensaje
						SocketChannel cl=(SocketChannel) k.channel();
						String msj="un mensaje";
						byte[] b=msj.getBytes();
						ByteBuffer buf=ByteBuffer.wrap(b);
						cl.write(buf);
						continue;
					}
				}
			}
		}catch (Exception e){
			e.printStackTrace();
		}
	}
}

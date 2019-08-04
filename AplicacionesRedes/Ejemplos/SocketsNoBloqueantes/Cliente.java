package Ejemplos.SocketsNoBloqueantes;
import java.net.InetAddress;
import java.net.InetSocketAddress;
import java.nio.ByteBuffer;
import java.nio.channels.SelectionKey;
import java.nio.channels.Selector;
import java.nio.channels.SocketChannel;
import java.util.Iterator;

public class Cliente {
	public static void main(String[] args) {
		try{
			InetAddress dir=InetAddress.getByName("127.0.0.1");
			SocketChannel cl=SocketChannel.open();
			cl.configureBlocking(false);
			InetSocketAddress dst=new InetSocketAddress(dir,1234);
			Selector sel= Selector.open();
			cl.connect(dst);
			cl.register(sel, SelectionKey.OP_CONNECT);
			while(true){
				sel.select();
				Iterator<SelectionKey>it=sel.selectedKeys().iterator();
				while(it.hasNext()){
					SelectionKey k=(SelectionKey)it.next();
					it.remove();
					if(k.isConnectable()) {
						SocketChannel ch = (SocketChannel) k.channel();
						if (ch.isConnectionPending()) {
							try {
								ch.finishConnect();
								System.out.println("Conexión establecida");
							} catch (Exception e) {
								e.printStackTrace();
							}
						}
						ch.register(sel, SelectionKey.OP_READ | SelectionKey.OP_WRITE);
						continue;
					}
					if (k.isReadable()){
						SocketChannel ch2=(SocketChannel)k.channel();
						ByteBuffer b=ByteBuffer.allocate(100);
						b.clear();
						ch2.read(b);
						continue;
					}else if(k.isWritable()){
						SocketChannel ch2=(SocketChannel)k.channel();
						String msj="Un mensaje";
						byte[] b=msj.getBytes();
						ByteBuffer buf=ByteBuffer.wrap(b);
						ch2.write(buf);
					}
				}
			}
		}catch(Exception e){
			e.printStackTrace();
		}
	}
}

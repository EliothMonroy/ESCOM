import javax.swing.JFrame;
import java.net.ServerSocket;
import java.sql.ResultSet;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.ImageIcon;
import java.net.Socket;
public class Server{
	public static final int PUERTO=8000;
	public static void main(String[] args) {
		Producto[] compras;
		JFrame frame=new JFrame("Servidor carrito de compras");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setBounds(100, 100, 500, 500);
		frame.setVisible(true);
		try{
			ResultSet rs;
			cConexion conexion=new cConexion();
			conexion.conectar();
			rs=conexion.consulta("select count(*) from producto;");
			if(rs.first()){
				JLabel[] etiquetas=new JLabel[rs.getInt(1)];
				JLabel[] precios=new JLabel[rs.getInt(1)];
				JLabel[] existencias=new JLabel[rs.getInt(1)];
				Producto[] productos=new Producto[rs.getInt(1)];
				rs=conexion.consulta("select * from producto order by id;");
				if(rs.first()){
					for(int i=0; i<productos.length;i++){
						productos[i]=new Producto(rs.getInt(1), rs.getString(2), rs.getFloat(3), rs.getInt(4), rs.getString(5));
						etiquetas[i]=new JLabel(productos[i].getNombre(),new ImageIcon(productos[i].getImagen()),JLabel.RIGHT);
						etiquetas[i].setBounds(0, 100*i, 200, 100);
						precios[i]=new JLabel("Precio: "+ productos[i].getPrecio());
						precios[i].setBounds(220, 100*i, 100, 50);
						existencias[i]=new JLabel("Existencia: "+ productos[i].getExistencia());
						existencias[i].setBounds(220, 50+(100*i), 100, 50);
						frame.add(etiquetas[i]);
						frame.add(precios[i]);
						frame.add(existencias[i]);
						rs.next();
					}
					JLabel producto4=new JLabel("");
					producto4.setBounds(0, 400, 80, 80);
					frame.add(producto4);
					//Iniciamos el server aquí
					ServerSocket s=new ServerSocket(PUERTO);
					System.out.println("Servidor iniciado, esperando clientes");
					while(true){
						Socket cl=s.accept();
						System.out.println("Cliente conectado, empezando a transmitir información");
						Integer cantidad=productos.length;
						ObjectOutputStream oos = new ObjectOutputStream(cl.getOutputStream());
						System.out.println("A continuación se enviará la cantidad de productos encontrados: "+productos.length);
						oos.writeObject(cantidad);
						oos.flush();
						System.out.println("Cantidad enviada, ahora se empezarán a enviar los productos");
						for(int i=0; i<productos.length;i++){
							System.out.println("Se enviará el producto: "+productos[i].getNombre());
							oos.writeObject(productos[i]);
							oos.flush();
						}
						//Aquí recibimos cualquier actualización
						ObjectInputStream ois=new ObjectInputStream(cl.getInputStream());
						Integer total=(Integer)ois.readObject();
						compras=new Producto[total];
						System.out.println("Un cliente requiere realizar una compra");
						for(int i=0; i<total;i++){
							compras[i]=(Producto)ois.readObject();
						}
						System.out.println("Total de productos a comprar: "+compras.length);
						//Registro en base de datos
						for(int i=0;i<compras.length;i++){
							conexion.actualizar("UPDATE producto SET existencia = existencia - 1 WHERE  id = "+compras[i].getId()+";");
						}
						rs=conexion.consulta("select existencia from producto order by id;");
						if(rs.first()){
							for(int i=0;i<productos.length;i++){
								existencias[i].setText("Existencia: "+rs.getInt(1));
								productos[i].setExistencia(rs.getInt(1));
								rs.next();
							}
						}
						System.out.println("Existencias actualizadas");
						cl.close();
						oos.close();
						ois.close();
					}
				}else{
					System.out.println("No existen productos");
				}
			}else{
				System.out.println("No existen productos");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
}
import java.awt.event.WindowEvent;
import javax.swing.JFrame;
import java.awt.event.ActionEvent;
import java.io.ObjectInputStream;
import java.io.ObjectOutputStream;
import javax.swing.JLabel;
import javax.swing.JButton;
import javax.swing.ImageIcon;
import java.net.Socket;
import javax.swing.JButton;
import java.awt.event.ActionListener;
import java.util.ArrayList;
import javax.swing.JButton;
import java.util.ArrayList;
import java.util.List;
public class Cliente implements ActionListener{
	public static final String HOST="localhost";
	public static final int PUERTO=8000;
	List<Producto> carrito=new ArrayList<>();
	Producto[] productos;
	JButton carritoCompras;
	Socket cl;
	JFrame frame;
	public Cliente(){
		frame=new JFrame("Cliente carrito de compras");
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
		frame.setBounds(100, 100, 700, 500);
		frame.setVisible(true);
		try {
			cl=new Socket(HOST,PUERTO);
			System.out.println("Conexion exitosa con el servidor");
			ObjectInputStream ois=new ObjectInputStream(cl.getInputStream());
			Integer cantidad=(Integer)ois.readObject();
			System.out.println("Cantidad de productos a recibir: "+cantidad);
			JLabel[] etiquetas=new JLabel[cantidad];
			JLabel[] precios=new JLabel[cantidad];
			JLabel[] existencias=new JLabel[cantidad];
			JButton[] botones=new JButton[cantidad];
			productos=new Producto[cantidad];
			carritoCompras=new JButton("Carrito: 0",new ImageIcon("images/carrito.png"));
			carritoCompras.setBounds(600, 50, 150, 100);
			carritoCompras.addActionListener(this);
			carritoCompras.setName("carrito");
			frame.add(carritoCompras);
			
			for(int i=0; i<cantidad;i++){
				productos[i]=(Producto)ois.readObject();
				System.out.println("Se recibio el producto: "+productos[i].getNombre());
				etiquetas[i]=new JLabel(productos[i].getNombre(),new ImageIcon(productos[i].getImagen()),JLabel.RIGHT);
				etiquetas[i].setBounds(0, 100*i, 200, 100);
				precios[i]=new JLabel("Precio: "+ productos[i].getPrecio());
				precios[i].setBounds(220, 100*i, 100, 50);
				existencias[i]=new JLabel("Existencia: "+ productos[i].getExistencia());
				existencias[i].setBounds(220, 50+(100*i), 150, 50);
				botones[i]=new JButton("Agregar al carrito");
				botones[i].setBounds(320, 35+(100*i), 150, 30);
				botones[i].setName(""+productos[i].getId());
				botones[i].addActionListener(this);

				frame.add(etiquetas[i]);
				frame.add(precios[i]);
				frame.add(existencias[i]);
				frame.add(botones[i]);
			}
			JLabel producto4=new JLabel("");
			producto4.setBounds(0, 400, 80, 80);
			frame.add(producto4);
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	public static void main(String[] args) {
		new Cliente();
	}
	@Override
	public void actionPerformed(ActionEvent e) {
		String nombre=((JButton)(e.getSource())).getName();
		if (nombre.equals("carrito")){
			//Creo nueva ventana de carrito
			new Carrito(carrito,cl);
			// carrito.clear();
			carritoCompras.setText("Carrito: "+carrito.size());
			frame.setVisible(false);
		}else{
			int id=Integer.parseInt(nombre);
			carrito.add(productos[id-1]);
			carritoCompras.setText("Carrito: "+carrito.size());
			//System.out.println(carrito);
		}
	}
}